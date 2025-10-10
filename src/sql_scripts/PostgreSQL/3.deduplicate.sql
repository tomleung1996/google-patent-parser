-- 标题
CREATE TABLE publication_title_deduped AS
SELECT DISTINCT ON (publication_number, language) *
FROM publication_title
ORDER BY publication_number, language;

BEGIN;
DROP TABLE publication_title;
ALTER TABLE publication_title_deduped RENAME TO publication_title;
COMMIT;

-- 摘要
CREATE TABLE publication_abstract_deduped AS
SELECT DISTINCT ON (publication_number, language) *
FROM publication_abstract
ORDER BY publication_number, language;

BEGIN;
DROP TABLE publication_abstract;
ALTER TABLE publication_abstract_deduped RENAME TO publication_abstract;
COMMIT;

-- 权利要求
CREATE TABLE publication_claim_deduped AS
SELECT DISTINCT ON (publication_number, language) *
FROM publication_claim
ORDER BY publication_number, language;

BEGIN;
DROP TABLE publication_claim;
ALTER TABLE publication_claim_deduped RENAME TO publication_claim;
COMMIT;

-- USPC
CREATE TABLE publication_uspc_deduped AS
SELECT DISTINCT ON (publication_number, code) *
FROM publication_uspc
ORDER BY publication_number, code;

BEGIN;
DROP TABLE publication_uspc;
ALTER TABLE publication_uspc_deduped RENAME TO publication_uspc;
COMMIT;

-- IPC
CREATE TABLE publication_ipc_deduped AS
SELECT DISTINCT ON (publication_number, code) *
FROM publication_ipc
ORDER BY publication_number, code;

BEGIN;
DROP TABLE publication_ipc;
ALTER TABLE publication_ipc_deduped RENAME TO publication_ipc;
COMMIT;

-- CPC
CREATE TABLE publication_cpc_deduped AS
SELECT DISTINCT ON (publication_number, code) *
FROM publication_cpc
ORDER BY publication_number, code;

BEGIN;
DROP TABLE publication_cpc;
ALTER TABLE publication_cpc_deduped RENAME TO publication_cpc;
COMMIT;

-- FI
CREATE TABLE publication_fi_deduped AS
SELECT DISTINCT ON (publication_number, code) *
FROM publication_fi
ORDER BY publication_number, code;

BEGIN;
DROP TABLE publication_fi;
ALTER TABLE publication_fi_deduped RENAME TO publication_fi;
COMMIT;

-- fterm
CREATE TABLE publication_fterm_deduped AS
SELECT DISTINCT ON (publication_number, code) *
FROM publication_fterm
ORDER BY publication_number, code;

BEGIN;
DROP TABLE publication_fterm;
ALTER TABLE publication_fterm_deduped RENAME TO publication_fterm;
COMMIT;

-- Locarno
CREATE TABLE publication_locarno_deduped AS
SELECT DISTINCT ON (publication_number, code) *
FROM publication_locarno
ORDER BY publication_number, code;

BEGIN;
DROP TABLE publication_locarno;
ALTER TABLE publication_locarno_deduped RENAME TO publication_locarno;
COMMIT;

-- 专利-发明人关系表
CREATE TABLE publication_inventor_deduped AS
SELECT DISTINCT ON (publication_number, inventor_id) *
FROM publication_inventor
ORDER BY publication_number, inventor_id;

BEGIN;
DROP TABLE publication_inventor;
ALTER TABLE publication_inventor_deduped RENAME TO publication_inventor;
COMMIT;

-- 专利-受让人关系表
CREATE TABLE publication_assignee_deduped AS
SELECT DISTINCT ON (publication_number, assignee_id) *
FROM publication_assignee
ORDER BY publication_number, assignee_id;

BEGIN;
DROP TABLE publication_assignee;
ALTER TABLE publication_assignee_deduped RENAME TO publication_assignee;
COMMIT;

-- 专利-审查员关系表
CREATE TABLE publication_examiner_deduped AS
SELECT DISTINCT ON (publication_number, examiner_id) *
FROM publication_examiner
ORDER BY publication_number, examiner_id;

BEGIN;
DROP TABLE publication_examiner;
ALTER TABLE publication_examiner_deduped RENAME TO publication_examiner;
COMMIT;

-- 子申请关系表
CREATE TABLE publication_child_deduped AS
SELECT DISTINCT ON (publication_number, child_application_number) *
FROM publication_child
ORDER BY publication_number, child_application_number;

BEGIN;
DROP TABLE publication_child;
ALTER TABLE publication_child_deduped RENAME TO publication_child;
COMMIT;

-- 母申请关系表
CREATE TABLE publication_parent_deduped AS
SELECT DISTINCT ON (publication_number, parent_application_number) *
FROM publication_parent
ORDER BY publication_number, parent_application_number;

BEGIN;
DROP TABLE publication_parent;
ALTER TABLE publication_parent_deduped RENAME TO publication_parent;
COMMIT;