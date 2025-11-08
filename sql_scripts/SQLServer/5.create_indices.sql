SET NOCOUNT ON;

/* ---------------------------------------------------------------------
   Primary keys and mandatory data preparation
--------------------------------------------------------------------- */

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_assignee')
BEGIN
    ALTER TABLE dbo.assignee
    ADD CONSTRAINT pk_assignee PRIMARY KEY NONCLUSTERED (assignee_id);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_examiner')
BEGIN
    ALTER TABLE dbo.examiner
    ADD CONSTRAINT pk_examiner PRIMARY KEY NONCLUSTERED (examiner_id);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_inventor')
BEGIN
    ALTER TABLE dbo.inventor
    ADD CONSTRAINT pk_inventor PRIMARY KEY NONCLUSTERED (inventor_id);
END;
GO

ALTER TABLE dbo.publication
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication')
BEGIN
    ALTER TABLE dbo.publication
    ADD CONSTRAINT pk_publication PRIMARY KEY NONCLUSTERED (publication_number);
END;
GO

UPDATE dbo.publication_title SET language = '' WHERE language IS NULL;
ALTER TABLE dbo.publication_title
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_title
ALTER COLUMN language VARCHAR(2) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_title')
BEGIN
    ALTER TABLE dbo.publication_title
    ADD CONSTRAINT pk_publication_title PRIMARY KEY NONCLUSTERED (publication_number, language);
END;
GO

UPDATE dbo.publication_abstract SET language = '' WHERE language IS NULL;
ALTER TABLE dbo.publication_abstract
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_abstract
ALTER COLUMN language VARCHAR(2) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_abstract')
BEGIN
    ALTER TABLE dbo.publication_abstract
    ADD CONSTRAINT pk_publication_abstract PRIMARY KEY NONCLUSTERED (publication_number, language);
END;
GO

UPDATE dbo.publication_claim SET language = '' WHERE language IS NULL;
ALTER TABLE dbo.publication_claim
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_claim
ALTER COLUMN language VARCHAR(2) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_claim')
BEGIN
    ALTER TABLE dbo.publication_claim
    ADD CONSTRAINT pk_publication_claim PRIMARY KEY NONCLUSTERED (publication_number, language);
END;
GO

ALTER TABLE dbo.publication_description
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_description
ALTER COLUMN language VARCHAR(2) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_description')
BEGIN
    ALTER TABLE dbo.publication_description
    ADD CONSTRAINT pk_publication_description PRIMARY KEY NONCLUSTERED (publication_number, language);
END;
GO

ALTER TABLE dbo.publication_uspc
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_uspc
ALTER COLUMN code VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_uspc')
BEGIN
    ALTER TABLE dbo.publication_uspc
    ADD CONSTRAINT pk_publication_uspc PRIMARY KEY NONCLUSTERED (publication_number, code);
END;
GO

ALTER TABLE dbo.publication_ipc
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_ipc
ALTER COLUMN code VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_ipc')
BEGIN
    ALTER TABLE dbo.publication_ipc
    ADD CONSTRAINT pk_publication_ipc PRIMARY KEY NONCLUSTERED (publication_number, code);
END;
GO

ALTER TABLE dbo.publication_cpc
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_cpc
ALTER COLUMN code VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_cpc')
BEGIN
    ALTER TABLE dbo.publication_cpc
    ADD CONSTRAINT pk_publication_cpc PRIMARY KEY NONCLUSTERED (publication_number, code);
END;
GO

ALTER TABLE dbo.publication_fi
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_fi
ALTER COLUMN code VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_fi')
BEGIN
    ALTER TABLE dbo.publication_fi
    ADD CONSTRAINT pk_publication_fi PRIMARY KEY NONCLUSTERED (publication_number, code);
END;
GO

ALTER TABLE dbo.publication_fterm
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_fterm
ALTER COLUMN code VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_fterm')
BEGIN
    ALTER TABLE dbo.publication_fterm
    ADD CONSTRAINT pk_publication_fterm PRIMARY KEY NONCLUSTERED (publication_number, code);
END;
GO

ALTER TABLE dbo.publication_locarno
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_locarno
ALTER COLUMN code VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_locarno')
BEGIN
    ALTER TABLE dbo.publication_locarno
    ADD CONSTRAINT pk_publication_locarno PRIMARY KEY NONCLUSTERED (publication_number, code);
END;
GO

ALTER TABLE dbo.publication_citation
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_citation
ALTER COLUMN cited_publication_number VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_citation')
BEGIN
    ALTER TABLE dbo.publication_citation
    ADD CONSTRAINT pk_publication_citation PRIMARY KEY NONCLUSTERED (publication_number, cited_publication_number);
END;
GO

ALTER TABLE dbo.publication_inventor
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_inventor
ALTER COLUMN inventor_id BIGINT NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_inventor')
BEGIN
    ALTER TABLE dbo.publication_inventor
    ADD CONSTRAINT pk_publication_inventor PRIMARY KEY NONCLUSTERED (publication_number, inventor_id);
END;
GO

ALTER TABLE dbo.publication_assignee
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_assignee
ALTER COLUMN assignee_id BIGINT NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_assignee')
BEGIN
    ALTER TABLE dbo.publication_assignee
    ADD CONSTRAINT pk_publication_assignee PRIMARY KEY NONCLUSTERED (publication_number, assignee_id);
END;
GO

ALTER TABLE dbo.publication_examiner
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_examiner
ALTER COLUMN examiner_id BIGINT NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_examiner')
BEGIN
    ALTER TABLE dbo.publication_examiner
    ADD CONSTRAINT pk_publication_examiner PRIMARY KEY NONCLUSTERED (publication_number, examiner_id);
END;
GO

ALTER TABLE dbo.publication_priority_claim
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_priority_claim
ALTER COLUMN priority_application_number VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_priority_claim')
BEGIN
    ALTER TABLE dbo.publication_priority_claim
    ADD CONSTRAINT pk_publication_priority_claim PRIMARY KEY NONCLUSTERED (publication_number, priority_application_number);
END;
GO

ALTER TABLE dbo.publication_child
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_child
ALTER COLUMN child_application_number VARCHAR(32) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_child')
BEGIN
    ALTER TABLE dbo.publication_child
    ADD CONSTRAINT pk_publication_child PRIMARY KEY NONCLUSTERED (publication_number, child_application_number);
END;
GO

ALTER TABLE dbo.publication_parent
ALTER COLUMN publication_number VARCHAR(32) NOT NULL;
ALTER TABLE dbo.publication_parent
ALTER COLUMN parent_application_number VARCHAR(64) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.key_constraints WHERE name = 'pk_publication_parent')
BEGIN
    ALTER TABLE dbo.publication_parent
    ADD CONSTRAINT pk_publication_parent PRIMARY KEY NONCLUSTERED (publication_number, parent_application_number);
END;
GO

/* ---------------------------------------------------------------------
   Secondary indexes
--------------------------------------------------------------------- */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_npr_pubnum')
BEGIN
    CREATE NONCLUSTERED INDEX idx_npr_pubnum ON dbo.publication_non_patent_reference(publication_number);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_inventor_name')
BEGIN
    CREATE NONCLUSTERED INDEX idx_inventor_name ON dbo.inventor(name);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_inventor_country_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_inventor_country_code ON dbo.inventor(country_code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_assignee_name')
BEGIN
    CREATE NONCLUSTERED INDEX idx_assignee_name ON dbo.assignee(name);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_assignee_country_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_assignee_country_code ON dbo.assignee(country_code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_publication_application_number')
BEGIN
    CREATE NONCLUSTERED INDEX idx_publication_application_number ON dbo.publication(application_number);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_publication_family_id')
BEGIN
    CREATE NONCLUSTERED INDEX idx_publication_family_id ON dbo.publication(family_id);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_publication_publication_date')
BEGIN
    CREATE NONCLUSTERED INDEX idx_publication_publication_date ON dbo.publication(publication_date);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_publication_filing_date')
BEGIN
    CREATE NONCLUSTERED INDEX idx_publication_filing_date ON dbo.publication(filing_date);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_publication_grant_date')
BEGIN
    CREATE NONCLUSTERED INDEX idx_publication_grant_date ON dbo.publication(grant_date);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_publication_priority_date')
BEGIN
    CREATE NONCLUSTERED INDEX idx_publication_priority_date ON dbo.publication(priority_date);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_publication_country_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_publication_country_code ON dbo.publication(country_code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_citation_cited_pub_num')
BEGIN
    CREATE NONCLUSTERED INDEX idx_citation_cited_pub_num ON dbo.publication_citation(cited_publication_number);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_pub_inventor_inventor_id')
BEGIN
    CREATE NONCLUSTERED INDEX idx_pub_inventor_inventor_id ON dbo.publication_inventor(inventor_id);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_pub_assignee_assignee_id')
BEGIN
    CREATE NONCLUSTERED INDEX idx_pub_assignee_assignee_id ON dbo.publication_assignee(assignee_id);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_pub_examiner_examiner_id')
BEGIN
    CREATE NONCLUSTERED INDEX idx_pub_examiner_examiner_id ON dbo.publication_examiner(examiner_id);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_parent_parent_app_num')
BEGIN
    CREATE NONCLUSTERED INDEX idx_parent_parent_app_num ON dbo.publication_parent(parent_application_number);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_uspc_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_uspc_code ON dbo.publication_uspc(code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_ipc_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_ipc_code ON dbo.publication_ipc(code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_cpc_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_cpc_code ON dbo.publication_cpc(code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_fi_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_fi_code ON dbo.publication_fi(code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_fterm_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_fterm_code ON dbo.publication_fterm(code);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'idx_locarno_code')
BEGIN
    CREATE NONCLUSTERED INDEX idx_locarno_code ON dbo.publication_locarno(code);
END;
GO
