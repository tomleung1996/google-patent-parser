SET NOCOUNT ON;

/* ---------------------------------------------------------------------
   Publication relationships
--------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubcite_pub_num')
    ALTER TABLE dbo.publication_citation DROP CONSTRAINT fk_pubcite_pub_num;
GO
ALTER TABLE dbo.publication_citation
WITH NOCHECK
ADD CONSTRAINT fk_pubcite_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubtitle_pub_num')
    ALTER TABLE dbo.publication_title DROP CONSTRAINT fk_pubtitle_pub_num;
GO
ALTER TABLE dbo.publication_title
WITH NOCHECK
ADD CONSTRAINT fk_pubtitle_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubabstract_pub_num')
    ALTER TABLE dbo.publication_abstract DROP CONSTRAINT fk_pubabstract_pub_num;
GO
ALTER TABLE dbo.publication_abstract
WITH NOCHECK
ADD CONSTRAINT fk_pubabstract_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubclaim_pub_num')
    ALTER TABLE dbo.publication_claim DROP CONSTRAINT fk_pubclaim_pub_num;
GO
ALTER TABLE dbo.publication_claim
WITH NOCHECK
ADD CONSTRAINT fk_pubclaim_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubdesc_pub_num')
    ALTER TABLE dbo.publication_description DROP CONSTRAINT fk_pubdesc_pub_num;
GO
ALTER TABLE dbo.publication_description
WITH NOCHECK
ADD CONSTRAINT fk_pubdesc_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubuspc_pub_num')
    ALTER TABLE dbo.publication_uspc DROP CONSTRAINT fk_pubuspc_pub_num;
GO
ALTER TABLE dbo.publication_uspc
WITH NOCHECK
ADD CONSTRAINT fk_pubuspc_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubipc_pub_num')
    ALTER TABLE dbo.publication_ipc DROP CONSTRAINT fk_pubipc_pub_num;
GO
ALTER TABLE dbo.publication_ipc
WITH NOCHECK
ADD CONSTRAINT fk_pubipc_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubcpc_pub_num')
    ALTER TABLE dbo.publication_cpc DROP CONSTRAINT fk_pubcpc_pub_num;
GO
ALTER TABLE dbo.publication_cpc
WITH NOCHECK
ADD CONSTRAINT fk_pubcpc_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubfi_pub_num')
    ALTER TABLE dbo.publication_fi DROP CONSTRAINT fk_pubfi_pub_num;
GO
ALTER TABLE dbo.publication_fi
WITH NOCHECK
ADD CONSTRAINT fk_pubfi_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubfterm_pub_num')
    ALTER TABLE dbo.publication_fterm DROP CONSTRAINT fk_pubfterm_pub_num;
GO
ALTER TABLE dbo.publication_fterm
WITH NOCHECK
ADD CONSTRAINT fk_pubfterm_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_publocarno_pub_num')
    ALTER TABLE dbo.publication_locarno DROP CONSTRAINT fk_publocarno_pub_num;
GO
ALTER TABLE dbo.publication_locarno
WITH NOCHECK
ADD CONSTRAINT fk_publocarno_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubnpl_pub_num')
    ALTER TABLE dbo.publication_non_patent_reference DROP CONSTRAINT fk_pubnpl_pub_num;
GO
ALTER TABLE dbo.publication_non_patent_reference
WITH NOCHECK
ADD CONSTRAINT fk_pubnpl_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubprio_pub_num')
    ALTER TABLE dbo.publication_priority_claim DROP CONSTRAINT fk_pubprio_pub_num;
GO
ALTER TABLE dbo.publication_priority_claim
WITH NOCHECK
ADD CONSTRAINT fk_pubprio_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubchild_pub_num')
    ALTER TABLE dbo.publication_child DROP CONSTRAINT fk_pubchild_pub_num;
GO
ALTER TABLE dbo.publication_child
WITH NOCHECK
ADD CONSTRAINT fk_pubchild_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubparent_pub_num')
    ALTER TABLE dbo.publication_parent DROP CONSTRAINT fk_pubparent_pub_num;
GO
ALTER TABLE dbo.publication_parent
WITH NOCHECK
ADD CONSTRAINT fk_pubparent_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

/* ---------------------------------------------------------------------
   Bridge tables to entity tables
--------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubinventor_pub_num')
    ALTER TABLE dbo.publication_inventor DROP CONSTRAINT fk_pubinventor_pub_num;
GO
ALTER TABLE dbo.publication_inventor
WITH NOCHECK
ADD CONSTRAINT fk_pubinventor_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubinventor_inventor_id')
    ALTER TABLE dbo.publication_inventor DROP CONSTRAINT fk_pubinventor_inventor_id;
GO
ALTER TABLE dbo.publication_inventor
WITH NOCHECK
ADD CONSTRAINT fk_pubinventor_inventor_id FOREIGN KEY (inventor_id)
REFERENCES dbo.inventor (inventor_id)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubassignee_pub_num')
    ALTER TABLE dbo.publication_assignee DROP CONSTRAINT fk_pubassignee_pub_num;
GO
ALTER TABLE dbo.publication_assignee
WITH NOCHECK
ADD CONSTRAINT fk_pubassignee_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubassignee_assignee_id')
    ALTER TABLE dbo.publication_assignee DROP CONSTRAINT fk_pubassignee_assignee_id;
GO
ALTER TABLE dbo.publication_assignee
WITH NOCHECK
ADD CONSTRAINT fk_pubassignee_assignee_id FOREIGN KEY (assignee_id)
REFERENCES dbo.assignee (assignee_id)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubexaminer_pub_num')
    ALTER TABLE dbo.publication_examiner DROP CONSTRAINT fk_pubexaminer_pub_num;
GO
ALTER TABLE dbo.publication_examiner
WITH NOCHECK
ADD CONSTRAINT fk_pubexaminer_pub_num FOREIGN KEY (publication_number)
REFERENCES dbo.publication (publication_number)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_pubexaminer_examiner_id')
    ALTER TABLE dbo.publication_examiner DROP CONSTRAINT fk_pubexaminer_examiner_id;
GO
ALTER TABLE dbo.publication_examiner
WITH NOCHECK
ADD CONSTRAINT fk_pubexaminer_examiner_id FOREIGN KEY (examiner_id)
REFERENCES dbo.examiner (examiner_id)
ON DELETE CASCADE ON UPDATE CASCADE;
GO
