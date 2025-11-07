SET NOCOUNT ON;

/* ---------------------------------------------------------------------
   For large tables we avoid delete-heavy logging by selecting unique rows into a fresh heap, dropping the helper column, then swapping it in.
--------------------------------------------------------------------- */

-- publication_title
IF OBJECT_ID(N'dbo.publication_title_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_title_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, language ORDER BY publication_number, language) AS rn
    FROM dbo.publication_title WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_title_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_title_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_title;
    EXEC sys.sp_rename N'dbo.publication_title_deduped', N'publication_title';
COMMIT TRANSACTION;
GO

-- publication_abstract
IF OBJECT_ID(N'dbo.publication_abstract_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_abstract_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, language ORDER BY publication_number, language) AS rn
    FROM dbo.publication_abstract WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_abstract_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_abstract_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_abstract;
    EXEC sys.sp_rename N'dbo.publication_abstract_deduped', N'publication_abstract';
COMMIT TRANSACTION;
GO

-- publication_claim
IF OBJECT_ID(N'dbo.publication_claim_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_claim_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, language ORDER BY publication_number, language) AS rn
    FROM dbo.publication_claim WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_claim_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_claim_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_claim;
    EXEC sys.sp_rename N'dbo.publication_claim_deduped', N'publication_claim';
COMMIT TRANSACTION;
GO

-- publication_uspc
IF OBJECT_ID(N'dbo.publication_uspc_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_uspc_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, code ORDER BY publication_number, code) AS rn
    FROM dbo.publication_uspc WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_uspc_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_uspc_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_uspc;
    EXEC sys.sp_rename N'dbo.publication_uspc_deduped', N'publication_uspc';
COMMIT TRANSACTION;
GO

-- publication_ipc
IF OBJECT_ID(N'dbo.publication_ipc_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_ipc_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, code ORDER BY publication_number, code) AS rn
    FROM dbo.publication_ipc WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_ipc_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_ipc_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_ipc;
    EXEC sys.sp_rename N'dbo.publication_ipc_deduped', N'publication_ipc';
COMMIT TRANSACTION;
GO

-- publication_cpc
IF OBJECT_ID(N'dbo.publication_cpc_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_cpc_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, code ORDER BY publication_number, code) AS rn
    FROM dbo.publication_cpc WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_cpc_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_cpc_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_cpc;
    EXEC sys.sp_rename N'dbo.publication_cpc_deduped', N'publication_cpc';
COMMIT TRANSACTION;
GO

-- publication_fi
IF OBJECT_ID(N'dbo.publication_fi_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_fi_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, code ORDER BY publication_number, code) AS rn
    FROM dbo.publication_fi WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_fi_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_fi_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_fi;
    EXEC sys.sp_rename N'dbo.publication_fi_deduped', N'publication_fi';
COMMIT TRANSACTION;
GO

-- publication_fterm
IF OBJECT_ID(N'dbo.publication_fterm_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_fterm_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, code ORDER BY publication_number, code) AS rn
    FROM dbo.publication_fterm WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_fterm_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_fterm_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_fterm;
    EXEC sys.sp_rename N'dbo.publication_fterm_deduped', N'publication_fterm';
COMMIT TRANSACTION;
GO

-- publication_locarno
IF OBJECT_ID(N'dbo.publication_locarno_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_locarno_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, code ORDER BY publication_number, code) AS rn
    FROM dbo.publication_locarno WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_locarno_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_locarno_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_locarno;
    EXEC sys.sp_rename N'dbo.publication_locarno_deduped', N'publication_locarno';
COMMIT TRANSACTION;
GO

-- publication_inventor
IF OBJECT_ID(N'dbo.publication_inventor_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_inventor_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, inventor_id ORDER BY publication_number, inventor_id) AS rn
    FROM dbo.publication_inventor WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_inventor_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_inventor_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_inventor;
    EXEC sys.sp_rename N'dbo.publication_inventor_deduped', N'publication_inventor';
COMMIT TRANSACTION;
GO

-- publication_assignee
IF OBJECT_ID(N'dbo.publication_assignee_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_assignee_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, assignee_id ORDER BY publication_number, assignee_id) AS rn
    FROM dbo.publication_assignee WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_assignee_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_assignee_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_assignee;
    EXEC sys.sp_rename N'dbo.publication_assignee_deduped', N'publication_assignee';
COMMIT TRANSACTION;
GO

-- publication_examiner
IF OBJECT_ID(N'dbo.publication_examiner_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_examiner_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, examiner_id ORDER BY publication_number, examiner_id) AS rn
    FROM dbo.publication_examiner WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_examiner_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_examiner_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_examiner;
    EXEC sys.sp_rename N'dbo.publication_examiner_deduped', N'publication_examiner';
COMMIT TRANSACTION;
GO

-- publication_child
IF OBJECT_ID(N'dbo.publication_child_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_child_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, child_application_number ORDER BY publication_number, child_application_number) AS rn
    FROM dbo.publication_child WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_child_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_child_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_child;
    EXEC sys.sp_rename N'dbo.publication_child_deduped', N'publication_child';
COMMIT TRANSACTION;
GO

-- publication_parent
IF OBJECT_ID(N'dbo.publication_parent_deduped', N'U') IS NOT NULL
    DROP TABLE dbo.publication_parent_deduped;

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY publication_number, parent_application_number ORDER BY publication_number, parent_application_number) AS rn
    FROM dbo.publication_parent WITH (HOLDLOCK, TABLOCK)
)
SELECT *
INTO dbo.publication_parent_deduped
FROM numbered
WHERE rn = 1;

ALTER TABLE dbo.publication_parent_deduped DROP COLUMN rn;

BEGIN TRANSACTION;
    DROP TABLE dbo.publication_parent;
    EXEC sys.sp_rename N'dbo.publication_parent_deduped', N'publication_parent';
COMMIT TRANSACTION;
GO

