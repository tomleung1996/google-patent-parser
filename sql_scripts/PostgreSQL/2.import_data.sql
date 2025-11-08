-- 先导入最简单的实体表和主表
\copy "data_202409".assignee FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/assignee_harmonized.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(assignee_id, name, country_code))
\copy "data_202409".examiner FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/examiner.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(examiner_id, name, department, level))
\copy "data_202409".inventor FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/inventor_harmonized.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(inventor_id, name, country_code))

\copy "data_202409".publication FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, application_number, country_code, kind_code, application_kind, application_number_formatted, pct_number, family_id, spif_publication_number, spif_application_number, publication_date, filing_date, grant_date, priority_date, entity_status, art_unit))

\copy "data_202409".publication_assignee FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_assignee.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, assignee_id, assignee_sequence))
\copy "data_202409".publication_examiner FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_examiner.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, examiner_id))
\copy "data_202409".publication_inventor FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_inventor.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, inventor_id, inventor_sequence))

\copy "data_202409".publication_ipc FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_ipc.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, code, inventive, first, tree))
\copy "data_202409".publication_cpc FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_cpc.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, code, inventive, first, tree))
\copy "data_202409".publication_uspc FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_uspc.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, code, inventive, first, tree))
\copy "data_202409".publication_fi FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_fi.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, code, inventive, first, tree))
\copy "data_202409".publication_fterm FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_fterm.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, code, inventive, first, tree))
\copy "data_202409".publication_locarno FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_locarno.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, code, inventive, first, tree))

\copy "data_202409".publication_citation FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_citation.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, cited_publication_number, type, category))
\copy "data_202409".publication_non_patent_reference FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_non_patent_reference.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, npl_text, type, category))

\copy "data_202409".publication_child FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_child.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, child_application_number, type, filing_date))
\copy "data_202409".publication_parent FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_parent.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, parent_application_number, type, filing_date))
\copy "data_202409".publication_priority_claim FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_priority_claim.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, priority_application_number, filing_date))

\copy "data_202409".publication_title FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_title.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, text, language, truncated))
\copy "data_202409".publication_abstract FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_abstract.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, text, language, truncated))
\copy "data_202409".publication_claim FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_claim.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, text, language, truncated))
\copy "data_202409".publication_description FROM '/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/publication_description.csv' WITH (FORMAT CSV, HEADER, FORCE_NULL(publication_number, text, language, truncated))