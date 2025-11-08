#!/usr/bin/env bash

set -euo pipefail

# Connection defaults (override via env vars before running)
SERVER_NAME="${SERVER_NAME:-tcp:localhost,1433}"
DATABASE_NAME="${DATABASE_NAME:-data_202409}"
SQLCMD_USER="${SQLCMD_USER:-sa}"
SQLCMD_PASSWORD="${SQLCMD_PASSWORD:-YourStrong!Passw0rd}"

# Data file configuration
DATA_ROOT="${DATA_ROOT:-/data/output_202409}"
FILE_EXT="${FILE_EXT:-.csv}"
CODEPAGE="${CODEPAGE:-65001}"
BATCH_SIZE="${BATCH_SIZE:-50000}"
FIELD_TERMINATOR="${FIELD_TERMINATOR:-0x09}"
ROW_TERMINATOR="${ROW_TERMINATOR:-0x0d0a}"
FIRST_DATA_ROW="${FIRST_DATA_ROW:-2}"

command -v sqlcmd >/dev/null 2>&1 || {
    echo "sqlcmd not found. Install the SQL Server command-line tools (mssql-tools)." >&2
    exit 1
}

command -v bcp >/dev/null 2>&1 || {
    echo "bcp not found. Install the SQL Server command-line tools (mssql-tools)." >&2
    exit 1
}

run_sql() {
    local stmt="$1"
    sqlcmd -S "$SERVER_NAME" \
           -U "$SQLCMD_USER" \
           -P "$SQLCMD_PASSWORD" \
           -d "$DATABASE_NAME" \
           -b -V16 -Q "$stmt"
}

run_bcp() {
    local table="$1"
    local file_stub="$2"
    local file_path="${DATA_ROOT}/${file_stub}${FILE_EXT}"

    if [[ ! -f "$file_path" ]]; then
        echo "File not found: $file_path" >&2
        exit 1
    fi

    echo "Loading ${table} from ${file_path}"
    bcp "${DATABASE_NAME}.dbo.${table}" in "$file_path" \
        -S "$SERVER_NAME" \
        -U "$SQLCMD_USER" \
        -P "$SQLCMD_PASSWORD" \
        -c \
        -C "$CODEPAGE" \
        -t "$FIELD_TERMINATOR" \
        -r "$ROW_TERMINATOR" \
        -F "$FIRST_DATA_ROW" \
        -b "$BATCH_SIZE" \
        -u
}

echo "Clearing existing data in ${DATABASE_NAME}"

# Delete from child tables first to honor FK constraints
tables_to_clear=(
    publication_citation
    publication_non_patent_reference
    publication_title
    publication_abstract
    publication_claim
    publication_description
    publication_uspc
    publication_ipc
    publication_cpc
    publication_fi
    publication_fterm
    publication_locarno
    publication_child
    publication_parent
    publication_priority_claim
    publication_inventor
    publication_assignee
    publication_examiner
    publication
    inventor
    assignee
    examiner
)

for tbl in "${tables_to_clear[@]}"; do
    echo "Deleting dbo.${tbl}"
    run_sql "IF OBJECT_ID('dbo.${tbl}', 'U') IS NOT NULL DELETE FROM dbo.${tbl};"
done

echo "Beginning bulk loads with bcp"

declare -a imports=(
    "assignee:assignee_harmonized"
    "examiner:examiner"
    "inventor:inventor_harmonized"
    "publication:publication"
    "publication_citation:publication_citation"
    "publication_non_patent_reference:publication_non_patent_reference"
    "publication_title:publication_title"
    "publication_abstract:publication_abstract"
    "publication_claim:publication_claim"
    "publication_description:publication_description"
    "publication_uspc:publication_uspc"
    "publication_ipc:publication_ipc"
    "publication_cpc:publication_cpc"
    "publication_fi:publication_fi"
    "publication_fterm:publication_fterm"
    "publication_locarno:publication_locarno"
    "publication_child:publication_child"
    "publication_parent:publication_parent"
    "publication_priority_claim:publication_priority_claim"
    "publication_inventor:publication_inventor"
    "publication_assignee:publication_assignee"
    "publication_examiner:publication_examiner"
)

for item in "${imports[@]}"; do
    table="${item%%:*}"
    file_stub="${item##*:}"
    run_bcp "$table" "$file_stub"
done

echo "All imports completed successfully."
