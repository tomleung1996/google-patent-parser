-- 发明人表
DROP TABLE IF EXISTS inventor;
CREATE TABLE inventor (
    inventor_id BIGINT PRIMARY KEY,
    name TEXT NOT NULL,
    country_code VARCHAR(2)
);

-- 受让人/公司表
DROP TABLE IF EXISTS assignee;
CREATE TABLE assignee (
    assignee_id BIGINT PRIMARY KEY,
    name TEXT NOT NULL,
    country_code VARCHAR(2)
);

-- 审查员表
DROP TABLE IF EXISTS examiner;
CREATE TABLE examiner (
    examiner_id BIGINT PRIMARY KEY,
    name TEXT,
    department TEXT,
    level VARCHAR(32)
);

-- 专利文献主表
DROP TABLE IF EXISTS publication;
CREATE TABLE publication (
    publication_number VARCHAR(32),
    application_number VARCHAR(32),
    country_code VARCHAR(2),
    kind_code VARCHAR(2),
    application_kind VARCHAR(2),
    application_number_formatted VARCHAR(32),
    pct_number VARCHAR(32),
    family_id BIGINT,
    spif_publication_number VARCHAR(32),
    spif_application_number VARCHAR(32),
    publication_date DATE,
    filing_date DATE,
    grant_date DATE,
    priority_date DATE,
    entity_status VARCHAR(20),
    art_unit VARCHAR(20)
);

-- 专利引用表
DROP TABLE IF EXISTS publication_citation;
CREATE TABLE publication_citation (
    publication_number VARCHAR(32),
    cited_publication_number VARCHAR(32),
    type VARCHAR(32),
    category VARCHAR(20)
);

-- 标题表
DROP TABLE IF EXISTS publication_title;
CREATE TABLE publication_title (
    publication_number VARCHAR(32),
    text TEXT,
    language VARCHAR(2),
    truncated BOOLEAN
);

-- 摘要表
DROP TABLE IF EXISTS publication_abstract;
CREATE TABLE publication_abstract (
    publication_number VARCHAR(32),
    text TEXT,
    language VARCHAR(2),
    truncated BOOLEAN
);

-- 权利要求表
DROP TABLE IF EXISTS publication_claim;
CREATE TABLE publication_claim (
    publication_number VARCHAR(32),
    text TEXT,
    language VARCHAR(2),
    truncated BOOLEAN
);

-- 描述表
DROP TABLE IF EXISTS publication_description;
CREATE TABLE publication_description (
    publication_number VARCHAR(32),
    text TEXT,
    language VARCHAR(2),
    truncated BOOLEAN
);

-- USPC 分类表
DROP TABLE IF EXISTS publication_uspc;
CREATE TABLE publication_uspc (
    publication_number VARCHAR(32),
    code VARCHAR(32),
    inventive BOOLEAN,
    first BOOLEAN,
    tree TEXT
);

-- IPC 分类表
DROP TABLE IF EXISTS publication_ipc;
CREATE TABLE publication_ipc (
    publication_number VARCHAR(32),
    code VARCHAR(32),
    inventive BOOLEAN,
    first BOOLEAN,
    tree TEXT
);

-- CPC 分类表
DROP TABLE IF EXISTS publication_cpc;
CREATE TABLE publication_cpc (
    publication_number VARCHAR(32),
    code VARCHAR(32),
    inventive BOOLEAN,
    first BOOLEAN,
    tree TEXT
);

-- FI 分类表
DROP TABLE IF EXISTS publication_fi;
CREATE TABLE publication_fi (
    publication_number VARCHAR(32),
    code VARCHAR(32),
    inventive BOOLEAN,
    first BOOLEAN,
    tree TEXT
);

-- F-term 分类表
DROP TABLE IF EXISTS publication_fterm;
CREATE TABLE publication_fterm (
    publication_number VARCHAR(32),
    code VARCHAR(32),
    inventive BOOLEAN,
    first BOOLEAN,
    tree TEXT
);

-- Locarno 分类表
DROP TABLE IF EXISTS publication_locarno;
CREATE TABLE publication_locarno (
    publication_number VARCHAR(32),
    code VARCHAR(32),
    inventive BOOLEAN,
    first BOOLEAN,
    tree TEXT
);

-- 专利-发明人关系表
DROP TABLE IF EXISTS publication_inventor;
CREATE TABLE publication_inventor (
    publication_number VARCHAR(32),
    inventor_id BIGINT,
    inventor_sequence INT
);

-- 专利-受让人关系表
DROP TABLE IF EXISTS publication_assignee;
CREATE TABLE publication_assignee (
    publication_number VARCHAR(32),
    assignee_id BIGINT,
    assignee_sequence INT
);

-- 专利-审查员关系表
DROP TABLE IF EXISTS publication_examiner;
CREATE TABLE publication_examiner (
    publication_number VARCHAR(32),
    examiner_id BIGINT
);

-- 非专利引文表
DROP TABLE IF EXISTS publication_non_patent_reference;
CREATE TABLE publication_non_patent_reference (
    publication_number VARCHAR(32),
    npl_text TEXT,
    type VARCHAR(32),
    category VARCHAR(20)
);

-- 优先权要求表
DROP TABLE IF EXISTS publication_priority_claim;
CREATE TABLE publication_priority_claim (
    publication_number VARCHAR(32),
    priority_application_number VARCHAR(32),
    filing_date DATE
);

-- 子申请关系表
DROP TABLE IF EXISTS publication_child;
CREATE TABLE publication_child (
    publication_number VARCHAR(32),
    child_application_number VARCHAR(32),
    type VARCHAR(32),
    filing_date DATE
);

-- 母申请关系表
DROP TABLE IF EXISTS publication_parent;
CREATE TABLE publication_parent (
    publication_number VARCHAR(32),
    parent_application_number VARCHAR(64),
    type VARCHAR(32),
    filing_date DATE
);