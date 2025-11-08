#requires -version 5.1
[CmdletBinding()]
param(
    [string]$ServerName = $env:SERVER_NAME,
    [string]$DatabaseName = $env:DATABASE_NAME,
    [string]$SqlCmdUser = $env:SQLCMD_USER,
    [string]$SqlCmdPassword = $env:SQLCMD_PASSWORD,
    [string]$DataRoot = $env:DATA_ROOT,
    [string]$FileExtension = $env:FILE_EXT,
    [string]$CodePage = $env:CODEPAGE,
    [string]$FieldTerminator = $env:FIELD_TERMINATOR,
    [string]$RowTerminator = $env:ROW_TERMINATOR,
    [int]$BatchSize,
    [int]$FirstDataRow
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# Apply defaults when no parameter or environment override is provided.
if (-not $ServerName) { $ServerName = 'tcp:localhost,1433' }
if (-not $DatabaseName) { $DatabaseName = 'data_202409' }
if (-not $SqlCmdUser) { $SqlCmdUser = 'sa' }
if (-not $SqlCmdPassword) { $SqlCmdPassword = 'YourStrong!Passw0rd' }
if (-not $DataRoot) { $DataRoot = 'C:\data\output_202409' }
if (-not $FileExtension) { $FileExtension = '.csv' }
if (-not $CodePage) { $CodePage = '65001' }
if (-not $FieldTerminator) { $FieldTerminator = '0x09' }
if (-not $RowTerminator) { $RowTerminator = '0x0d0a' }
if (-not $PSBoundParameters.ContainsKey('BatchSize')) {
    if ($env:BATCH_SIZE) {
        $BatchSize = [int]$env:BATCH_SIZE
    } else {
        $BatchSize = 100000
    }
}
if (-not $PSBoundParameters.ContainsKey('FirstDataRow')) {
    if ($env:FIRST_DATA_ROW) {
        $FirstDataRow = [int]$env:FIRST_DATA_ROW
    } else {
        $FirstDataRow = 2
    }
}

function Resolve-Executable {
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if (-not $command) {
        throw "Required command '$Name' was not found in PATH. Install the SQL Server command-line tools (sqlcmd/bcp)."
    }

    return $command.Source
}

$sqlCmdPath = Resolve-Executable -Name 'sqlcmd'
$bcpPath = Resolve-Executable -Name 'bcp'

function Invoke-SqlStatement {
    param(
        [Parameter(Mandatory)]
        [string]$Statement
    )

    $arguments = @(
        '-S', $ServerName,
        '-U', $SqlCmdUser,
        '-P', $SqlCmdPassword,
        '-d', $DatabaseName,
        '-b',
        '-V16',
        '-Q', $Statement
    )
    & $sqlCmdPath @arguments
    if ($LASTEXITCODE -ne 0) {
        throw "sqlcmd failed with exit code $LASTEXITCODE."
    }
}

function Invoke-BulkCopy {
    param(
        [Parameter(Mandatory)]
        [string]$Table,

        [Parameter(Mandatory)]
        [string]$FileStub
    )

    $filePath = Join-Path -Path $DataRoot -ChildPath ("{0}{1}" -f $FileStub, $FileExtension)

    if (-not (Test-Path -LiteralPath $filePath)) {
        throw "File not found: $filePath"
    }

    Write-Host "Loading $Table from $filePath"

    $arguments = @(
        "$DatabaseName.dbo.$Table", 'in', $filePath,
        '-S', $ServerName,
        '-U', $SqlCmdUser,
        '-P', $SqlCmdPassword,
        '-c',
        '-C', $CodePage,
        '-t', $FieldTerminator,
        '-r', $RowTerminator,
        '-F', $FirstDataRow,
        '-b', $BatchSize,
    )
    & $bcpPath @arguments
    if ($LASTEXITCODE -ne 0) {
        throw "BCP import for table '$Table' failed with exit code $LASTEXITCODE."
    }
}

Write-Host "Clearing existing data in $DatabaseName"

$tablesToClear = @(
    'publication_citation'
    'publication_non_patent_reference'
    'publication_title'
    'publication_abstract'
    'publication_claim'
    'publication_description'
    'publication_uspc'
    'publication_ipc'
    'publication_cpc'
    'publication_fi'
    'publication_fterm'
    'publication_locarno'
    'publication_child'
    'publication_parent'
    'publication_priority_claim'
    'publication_inventor'
    'publication_assignee'
    'publication_examiner'
    'publication'
    'inventor'
    'assignee'
    'examiner'
)

foreach ($table in $tablesToClear) {
    Write-Host "Deleting dbo.$table"
    Invoke-SqlStatement -Statement "IF OBJECT_ID('dbo.$table', 'U') IS NOT NULL DELETE FROM dbo.$table;"
}

Write-Host 'Beginning bulk loads with bcp'

$imports = @(
    @{ Table = 'assignee'; FileStub = 'assignee_harmonized' }
    @{ Table = 'examiner'; FileStub = 'examiner' }
    @{ Table = 'inventor'; FileStub = 'inventor_harmonized' }
    @{ Table = 'publication'; FileStub = 'publication' }
    @{ Table = 'publication_citation'; FileStub = 'publication_citation' }
    @{ Table = 'publication_non_patent_reference'; FileStub = 'publication_non_patent_reference' }
    @{ Table = 'publication_title'; FileStub = 'publication_title' }
    @{ Table = 'publication_abstract'; FileStub = 'publication_abstract' }
    @{ Table = 'publication_claim'; FileStub = 'publication_claim' }
    @{ Table = 'publication_description'; FileStub = 'publication_description' }
    @{ Table = 'publication_uspc'; FileStub = 'publication_uspc' }
    @{ Table = 'publication_ipc'; FileStub = 'publication_ipc' }
    @{ Table = 'publication_cpc'; FileStub = 'publication_cpc' }
    @{ Table = 'publication_fi'; FileStub = 'publication_fi' }
    @{ Table = 'publication_fterm'; FileStub = 'publication_fterm' }
    @{ Table = 'publication_locarno'; FileStub = 'publication_locarno' }
    @{ Table = 'publication_child'; FileStub = 'publication_child' }
    @{ Table = 'publication_parent'; FileStub = 'publication_parent' }
    @{ Table = 'publication_priority_claim'; FileStub = 'publication_priority_claim' }
    @{ Table = 'publication_inventor'; FileStub = 'publication_inventor' }
    @{ Table = 'publication_assignee'; FileStub = 'publication_assignee' }
    @{ Table = 'publication_examiner'; FileStub = 'publication_examiner' }
)

foreach ($entry in $imports) {
    Invoke-BulkCopy -Table $entry.Table -FileStub $entry.FileStub
}

Write-Host 'All imports completed successfully.'
