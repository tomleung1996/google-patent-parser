-- ===================================================================
-- 1. 将所有与专利文献直接相关的表连接到 publication 表
-- ===================================================================

-- 专利引用表 -> 专利主表
ALTER TABLE publication_citation
ADD CONSTRAINT fk_pubcite_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE publication_citation
-- ADD CONSTRAINT fk_pubcite_cited_pub_num FOREIGN KEY (cited_publication_number)
-- REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 标题表 -> 专利主表
ALTER TABLE publication_title
ADD CONSTRAINT fk_pubtitle_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 摘要表 -> 专利主表
ALTER TABLE publication_abstract
ADD CONSTRAINT fk_pubabstract_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 权利要求表 -> 专利主表
ALTER TABLE publication_claim
ADD CONSTRAINT fk_pubclaim_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 描述表 -> 专利主表
ALTER TABLE publication_description
ADD CONSTRAINT fk_pubdesc_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 各种分类表 -> 专利主表
ALTER TABLE publication_uspc
ADD CONSTRAINT fk_pubuspc_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_ipc
ADD CONSTRAINT fk_pubipc_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_cpc
ADD CONSTRAINT fk_pubcpc_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_fi
ADD CONSTRAINT fk_pubfi_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_fterm
ADD CONSTRAINT fk_pubfterm_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_locarno
ADD CONSTRAINT fk_publocarno_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 非专利引文表 -> 专利主表
ALTER TABLE publication_non_patent_reference
ADD CONSTRAINT fk_pubnpl_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 优先权要求表 -> 专利主表
ALTER TABLE publication_priority_claim
ADD CONSTRAINT fk_pubprio_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

-- 子母申请关系表 -> 专利主表
ALTER TABLE publication_child
ADD CONSTRAINT fk_pubchild_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_parent
ADD CONSTRAINT fk_pubparent_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;


-- ===================================================================
-- 2. 将关系表连接到对应的实体表（发明人、受让人、审查员）
-- ===================================================================

-- 专利-发明人关系表
ALTER TABLE publication_inventor
ADD CONSTRAINT fk_pubinventor_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_inventor
ADD CONSTRAINT fk_pubinventor_inventor_id FOREIGN KEY (inventor_id)
REFERENCES inventor (inventor_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- 专利-受让人关系表
ALTER TABLE publication_assignee
ADD CONSTRAINT fk_pubassignee_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_assignee
ADD CONSTRAINT fk_pubassignee_assignee_id FOREIGN KEY (assignee_id)
REFERENCES assignee (assignee_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- 专利-审查员关系表
ALTER TABLE publication_examiner
ADD CONSTRAINT fk_pubexaminer_pub_num FOREIGN KEY (publication_number)
REFERENCES publication (publication_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE publication_examiner
ADD CONSTRAINT fk_pubexaminer_examiner_id FOREIGN KEY (examiner_id)
REFERENCES examiner (examiner_id) ON DELETE CASCADE ON UPDATE CASCADE;