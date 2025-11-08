-- Optional: change to your target database before running these statements
-- USE [data_202409];
-- GO

-- Inventor table
IF OBJECT_ID(N'dbo.inventor', N'U') IS NOT NULL
    DROP TABLE dbo.inventor;
GO
CREATE TABLE dbo.inventor (
    inventor_id BIGINT NOT NULL,
    name NVARCHAR(MAX) NOT NULL,
    country_code VARCHAR(2) NULL
);
GO

-- Assignee table
IF OBJECT_ID(N'dbo.assignee', N'U') IS NOT NULL
    DROP TABLE dbo.assignee;
GO
CREATE TABLE dbo.assignee (
    assignee_id BIGINT NOT NULL,
    name NVARCHAR(MAX) NOT NULL,
    country_code VARCHAR(2) NULL
);
GO

-- Examiner table
IF OBJECT_ID(N'dbo.examiner', N'U') IS NOT NULL
    DROP TABLE dbo.examiner;
GO
CREATE TABLE dbo.examiner (
    examiner_id BIGINT NOT NULL,
    name NVARCHAR(MAX) NULL,
    department NVARCHAR(MAX) NULL,
    level VARCHAR(32) NULL
);
GO

-- Publication master table
IF OBJECT_ID(N'dbo.publication', N'U') IS NOT NULL
    DROP TABLE dbo.publication;
GO
CREATE TABLE dbo.publication (
    publication_number VARCHAR(32) NOT NULL,
    application_number VARCHAR(32) NULL,
    country_code VARCHAR(2) NULL,
    kind_code VARCHAR(2) NULL,
    application_kind VARCHAR(2) NULL,
    application_number_formatted VARCHAR(32) NULL,
    pct_number VARCHAR(32) NULL,
    family_id BIGINT NULL,
    spif_publication_number VARCHAR(32) NULL,
    spif_application_number VARCHAR(32) NULL,
    publication_date DATE NULL,
    filing_date DATE NULL,
    grant_date DATE NULL,
    priority_date DATE NULL,
    entity_status VARCHAR(20) NULL,
    art_unit VARCHAR(20) NULL
);
GO

-- Publication citation table
IF OBJECT_ID(N'dbo.publication_citation', N'U') IS NOT NULL
    DROP TABLE dbo.publication_citation;
GO
CREATE TABLE dbo.publication_citation (
    publication_number VARCHAR(32) NOT NULL,
    cited_publication_number VARCHAR(32) NOT NULL,
    type VARCHAR(32) NULL,
    category VARCHAR(20) NULL
);
GO

-- Publication title table
IF OBJECT_ID(N'dbo.publication_title', N'U') IS NOT NULL
    DROP TABLE dbo.publication_title;
GO
CREATE TABLE dbo.publication_title (
    publication_number VARCHAR(32) NOT NULL,
    text NVARCHAR(MAX) NULL,
    language VARCHAR(2) NULL,
    truncated BIT NULL
);
GO

-- Publication abstract table
IF OBJECT_ID(N'dbo.publication_abstract', N'U') IS NOT NULL
    DROP TABLE dbo.publication_abstract;
GO
CREATE TABLE dbo.publication_abstract (
    publication_number VARCHAR(32) NOT NULL,
    text NVARCHAR(MAX) NULL,
    language VARCHAR(2) NULL,
    truncated BIT NULL
);
GO

-- Publication claim table
IF OBJECT_ID(N'dbo.publication_claim', N'U') IS NOT NULL
    DROP TABLE dbo.publication_claim;
GO
CREATE TABLE dbo.publication_claim (
    publication_number VARCHAR(32) NOT NULL,
    text NVARCHAR(MAX) NULL,
    language VARCHAR(2) NULL,
    truncated BIT NULL
);
GO

-- Publication description table
IF OBJECT_ID(N'dbo.publication_description', N'U') IS NOT NULL
    DROP TABLE dbo.publication_description;
GO
CREATE TABLE dbo.publication_description (
    publication_number VARCHAR(32) NOT NULL,
    text NVARCHAR(MAX) NULL,
    language VARCHAR(2) NULL,
    truncated BIT NULL
);
GO

-- Publication USPC classification table
IF OBJECT_ID(N'dbo.publication_uspc', N'U') IS NOT NULL
    DROP TABLE dbo.publication_uspc;
GO
CREATE TABLE dbo.publication_uspc (
    publication_number VARCHAR(32) NOT NULL,
    code VARCHAR(32) NOT NULL,
    inventive BIT NULL,
    first BIT NULL,
    tree NVARCHAR(MAX) NULL
);
GO

-- Publication IPC classification table
IF OBJECT_ID(N'dbo.publication_ipc', N'U') IS NOT NULL
    DROP TABLE dbo.publication_ipc;
GO
CREATE TABLE dbo.publication_ipc (
    publication_number VARCHAR(32) NOT NULL,
    code VARCHAR(32) NOT NULL,
    inventive BIT NULL,
    first BIT NULL,
    tree NVARCHAR(MAX) NULL
);
GO

-- Publication CPC classification table
IF OBJECT_ID(N'dbo.publication_cpc', N'U') IS NOT NULL
    DROP TABLE dbo.publication_cpc;
GO
CREATE TABLE dbo.publication_cpc (
    publication_number VARCHAR(32) NOT NULL,
    code VARCHAR(32) NOT NULL,
    inventive BIT NULL,
    first BIT NULL,
    tree NVARCHAR(MAX) NULL
);
GO

-- Publication FI classification table
IF OBJECT_ID(N'dbo.publication_fi', N'U') IS NOT NULL
    DROP TABLE dbo.publication_fi;
GO
CREATE TABLE dbo.publication_fi (
    publication_number VARCHAR(32) NOT NULL,
    code VARCHAR(32) NOT NULL,
    inventive BIT NULL,
    first BIT NULL,
    tree NVARCHAR(MAX) NULL
);
GO

-- Publication F-term classification table
IF OBJECT_ID(N'dbo.publication_fterm', N'U') IS NOT NULL
    DROP TABLE dbo.publication_fterm;
GO
CREATE TABLE dbo.publication_fterm (
    publication_number VARCHAR(32) NOT NULL,
    code VARCHAR(32) NOT NULL,
    inventive BIT NULL,
    first BIT NULL,
    tree NVARCHAR(MAX) NULL
);
GO

-- Publication Locarno classification table
IF OBJECT_ID(N'dbo.publication_locarno', N'U') IS NOT NULL
    DROP TABLE dbo.publication_locarno;
GO
CREATE TABLE dbo.publication_locarno (
    publication_number VARCHAR(32) NOT NULL,
    code VARCHAR(32) NOT NULL,
    inventive BIT NULL,
    first BIT NULL,
    tree NVARCHAR(MAX) NULL
);
GO

-- Publication-inventor bridge table
IF OBJECT_ID(N'dbo.publication_inventor', N'U') IS NOT NULL
    DROP TABLE dbo.publication_inventor;
GO
CREATE TABLE dbo.publication_inventor (
    publication_number VARCHAR(32) NOT NULL,
    inventor_id BIGINT NOT NULL,
    inventor_sequence INT NULL
);
GO

-- Publication-assignee bridge table
IF OBJECT_ID(N'dbo.publication_assignee', N'U') IS NOT NULL
    DROP TABLE dbo.publication_assignee;
GO
CREATE TABLE dbo.publication_assignee (
    publication_number VARCHAR(32) NOT NULL,
    assignee_id BIGINT NOT NULL,
    assignee_sequence INT NULL
);
GO

-- Publication-examiner bridge table
IF OBJECT_ID(N'dbo.publication_examiner', N'U') IS NOT NULL
    DROP TABLE dbo.publication_examiner;
GO
CREATE TABLE dbo.publication_examiner (
    publication_number VARCHAR(32) NOT NULL,
    examiner_id BIGINT NOT NULL
);
GO

-- Publication non-patent reference table
IF OBJECT_ID(N'dbo.publication_non_patent_reference', N'U') IS NOT NULL
    DROP TABLE dbo.publication_non_patent_reference;
GO
CREATE TABLE dbo.publication_non_patent_reference (
    publication_number VARCHAR(32) NOT NULL,
    npl_text NVARCHAR(MAX) NULL,
    type VARCHAR(32) NULL,
    category VARCHAR(20) NULL
);
GO

-- Publication priority claim table
IF OBJECT_ID(N'dbo.publication_priority_claim', N'U') IS NOT NULL
    DROP TABLE dbo.publication_priority_claim;
GO
CREATE TABLE dbo.publication_priority_claim (
    publication_number VARCHAR(32) NOT NULL,
    priority_application_number VARCHAR(32) NOT NULL,
    filing_date DATE NULL
);
GO

-- Publication child application table
IF OBJECT_ID(N'dbo.publication_child', N'U') IS NOT NULL
    DROP TABLE dbo.publication_child;
GO
CREATE TABLE dbo.publication_child (
    publication_number VARCHAR(32) NOT NULL,
    child_application_number VARCHAR(32) NOT NULL,
    type VARCHAR(32) NULL,
    filing_date DATE NULL
);
GO

-- Publication parent application table
IF OBJECT_ID(N'dbo.publication_parent', N'U') IS NOT NULL
    DROP TABLE dbo.publication_parent;
GO
CREATE TABLE dbo.publication_parent (
    publication_number VARCHAR(32) NOT NULL,
    parent_application_number VARCHAR(64) NOT NULL,
    type VARCHAR(32) NULL,
    filing_date DATE NULL
);
GO
