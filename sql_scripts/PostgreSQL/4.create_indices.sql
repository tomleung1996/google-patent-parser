-- 专利文献主表
-- 理由: publication_number 是每份专利文献的唯一官方编号。
ALTER TABLE publication
ADD PRIMARY KEY (publication_number);

-- 标题表
-- 理由: 一份专利文献可能包含多种语言的标题。
-- 首先要将language NULL的变成空字符串
UPDATE publication_title SET language = '' WHERE language IS NULL;
ALTER TABLE publication_title
ADD PRIMARY KEY (publication_number, language);

-- 摘要表
-- 理由: 一份专利文献可能包含多种语言的摘要。
UPDATE publication_abstract SET language = '' WHERE language IS NULL;
ALTER TABLE publication_abstract
ADD PRIMARY KEY (publication_number, language);

-- 权利要求表
-- 理由: 一份专利文献可能包含多种语言的权利要求。
UPDATE publication_claim SET language = '' WHERE language IS NULL;
ALTER TABLE publication_claim
ADD PRIMARY KEY (publication_number, language);

-- 描述表
-- 理由: 一份专利文献可能包含多种语言的描述。
ALTER TABLE publication_description
ADD PRIMARY KEY (publication_number, language);

-- USPC 分类表
-- 理由: 一份专利文献可对应多个 USPC 分类号。
ALTER TABLE publication_uspc
ADD PRIMARY KEY (publication_number, code);

-- IPC 分类表
-- 理由: 一份专利文献可对应多个 IPC 分类号。
ALTER TABLE publication_ipc
ADD PRIMARY KEY (publication_number, code);

-- CPC 分类表
-- 理由: 一份专利文献可对应多个 CPC 分类号。
ALTER TABLE publication_cpc
ADD PRIMARY KEY (publication_number, code);

-- FI 分类表
-- 理由: 一份专利文献可对应多个 FI 分类号。
ALTER TABLE publication_fi
ADD PRIMARY KEY (publication_number, code);

-- F-term 分类表
-- 理由: 一份专利文献可对应多个 F-term 分类号。
ALTER TABLE publication_fterm
ADD PRIMARY KEY (publication_number, code);

-- Locarno 分类表
-- 理由: 一份专利文献可对应多个 Locarno 分类号。
ALTER TABLE publication_locarno
ADD PRIMARY KEY (publication_number, code);

-- 专利引用表
-- 理由: 唯一确定一条引用关系需要“引用的专利”和“被引用的专利”两者。
ALTER TABLE publication_citation
ADD PRIMARY KEY (publication_number, cited_publication_number);

-- 专利-发明人关系表
-- 理由: 一份专利对应一位发明人，这种关系是唯一的。
ALTER TABLE publication_inventor
ADD PRIMARY KEY (publication_number, inventor_id);

-- 专利-受让人关系表
-- 理由: 一份专利对应一位受让人，这种关系是唯一的。
ALTER TABLE publication_assignee
ADD PRIMARY KEY (publication_number, assignee_id);

-- 专利-审查员关系表
-- 理由: 一份专利对应一位审查员，这种关系是唯一的。
ALTER TABLE publication_examiner
ADD PRIMARY KEY (publication_number, examiner_id);

-- 优先权要求表
-- 理由: 一份专利可以有多个优先权，每条优先权由其申请号唯一标识。
ALTER TABLE publication_priority_claim
ADD PRIMARY KEY (publication_number, priority_application_number);

-- 子申请关系表
-- 理由: 一份专利可以有多个子申请，每个子申请由其申请号唯一标识。
ALTER TABLE publication_child
ADD PRIMARY KEY (publication_number, child_application_number);

-- 母申请关系表
-- 理由: 一份专利可以有多个母申请，每个母申请由其申请号唯一标识。
ALTER TABLE publication_parent
ADD PRIMARY KEY (publication_number, parent_application_number);

-- 非专利引文表
CREATE INDEX idx_npr_pubnum ON publication_non_patent_reference(publication_number);





-- 发明人表
-- 理由: 优化按姓名和国家代码查询发明人的速度。
CREATE INDEX idx_inventor_name ON inventor(name);
CREATE INDEX idx_inventor_country_code ON inventor(country_code);

-- 受让人/公司表
-- 理由: 优化按名称和国家代码查询受让人的速度。
CREATE INDEX idx_assignee_name ON assignee(name);
CREATE INDEX idx_assignee_country_code ON assignee(country_code);

-- 专利文献主表
-- 理由: application_number 是另一个唯一标识符，常用于关联。
CREATE INDEX idx_publication_application_number ON publication(application_number);

-- 理由: family_id 是进行专利家族分析的关键字段，必须索引。
CREATE INDEX idx_publication_family_id ON publication(family_id);

-- 理由: 日期字段是筛选和排序的核心，例如查询某个时间段内公开或授权的专利。
CREATE INDEX idx_publication_publication_date ON publication(publication_date);
CREATE INDEX idx_publication_filing_date ON publication(filing_date);
CREATE INDEX idx_publication_grant_date ON publication(grant_date);
CREATE INDEX idx_publication_priority_date ON publication(priority_date);

-- 理由: 优化按国家代码筛选专利。
CREATE INDEX idx_publication_country_code ON publication(country_code);

-- 专利引用表
-- 理由: 极大加速“查询某篇文献被哪些文献引用了”（被引分析）的速度。
CREATE INDEX idx_citation_cited_pub_num ON publication_citation(cited_publication_number);

-- 专利-发明人关系表
-- 理由: 极大加速“查询某个发明人拥有哪些专利”的速度。
CREATE INDEX idx_pub_inventor_inventor_id ON publication_inventor(inventor_id);

-- 专利-受让人关系表
-- 理由: 极大加速“查询某个公司/受让人拥有哪些专利”的速度。
CREATE INDEX idx_pub_assignee_assignee_id ON publication_assignee(assignee_id);

-- 专利-审查员关系表
-- 理由: 加速查询某个审查员审查了哪些专利。
CREATE INDEX idx_pub_examiner_examiner_id ON publication_examiner(examiner_id);

-- 母申请关系表
-- 理由: 加速通过母申请号查找其所有子专利。
CREATE INDEX idx_parent_parent_app_num ON publication_parent(parent_application_number);

-- USPC 分类表
-- 理由: 优化按 USPC 分类号查找所有相关专利的速度。
CREATE INDEX idx_uspc_code ON publication_uspc(code);

-- IPC 分类表
-- 理由: 优化按 IPC 分类号查找所有相关专利的速度。
CREATE INDEX idx_ipc_code ON publication_ipc(code);

-- CPC 分类表
-- 理由: 优化按 CPC 分类号查找所有相关专利的速度。
CREATE INDEX idx_cpc_code ON publication_cpc(code);

-- FI 分类表
-- 理由: 优化按 FI 分类号查找所有相关专利的速度。
CREATE INDEX idx_fi_code ON publication_fi(code);

-- F-term 分类表
-- 理由: 优化按 F-term 分类号查找所有相关专利的速度。
CREATE INDEX idx_fterm_code ON publication_fterm(code);

-- Locarno 分类表
-- 理由: 优化按 Locarno 分类号查找所有相关专利的速度。
CREATE INDEX idx_locarno_code ON publication_locarno(code);