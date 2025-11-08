SET NOCOUNT ON;

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_assignee'
      AND object_id = OBJECT_ID(N'dbo.assignee')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_assignee ON dbo.assignee;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_examiner'
      AND object_id = OBJECT_ID(N'dbo.examiner')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_examiner ON dbo.examiner;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_inventor'
      AND object_id = OBJECT_ID(N'dbo.inventor')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_inventor ON dbo.inventor;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication'
      AND object_id = OBJECT_ID(N'dbo.publication')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication ON dbo.publication;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_abstract'
      AND object_id = OBJECT_ID(N'dbo.publication_abstract')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_abstract ON dbo.publication_abstract;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_assignee'
      AND object_id = OBJECT_ID(N'dbo.publication_assignee')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_assignee ON dbo.publication_assignee;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_citation'
      AND object_id = OBJECT_ID(N'dbo.publication_citation')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_citation ON dbo.publication_citation;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_child'
      AND object_id = OBJECT_ID(N'dbo.publication_child')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_child ON dbo.publication_child;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_claim'
      AND object_id = OBJECT_ID(N'dbo.publication_claim')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_claim ON dbo.publication_claim;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_cpc'
      AND object_id = OBJECT_ID(N'dbo.publication_cpc')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_cpc ON dbo.publication_cpc;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_description'
      AND object_id = OBJECT_ID(N'dbo.publication_description')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_description ON dbo.publication_description;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_examiner'
      AND object_id = OBJECT_ID(N'dbo.publication_examiner')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_examiner ON dbo.publication_examiner;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_fi'
      AND object_id = OBJECT_ID(N'dbo.publication_fi')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_fi ON dbo.publication_fi;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_fterm'
      AND object_id = OBJECT_ID(N'dbo.publication_fterm')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_fterm ON dbo.publication_fterm;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_inventor'
      AND object_id = OBJECT_ID(N'dbo.publication_inventor')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_inventor ON dbo.publication_inventor;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_ipc'
      AND object_id = OBJECT_ID(N'dbo.publication_ipc')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_ipc ON dbo.publication_ipc;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_locarno'
      AND object_id = OBJECT_ID(N'dbo.publication_locarno')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_locarno ON dbo.publication_locarno;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_non_patent_reference'
      AND object_id = OBJECT_ID(N'dbo.publication_non_patent_reference')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_non_patent_reference ON dbo.publication_non_patent_reference;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_parent'
      AND object_id = OBJECT_ID(N'dbo.publication_parent')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_parent ON dbo.publication_parent;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_priority_claim'
      AND object_id = OBJECT_ID(N'dbo.publication_priority_claim')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_priority_claim ON dbo.publication_priority_claim;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_title'
      AND object_id = OBJECT_ID(N'dbo.publication_title')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_title ON dbo.publication_title;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'cci_publication_uspc'
      AND object_id = OBJECT_ID(N'dbo.publication_uspc')
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX cci_publication_uspc ON dbo.publication_uspc;
END;
GO
