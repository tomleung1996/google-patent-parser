import orjson as json
import csv
from tqdm import tqdm
from glob import glob

DELIMITER = '##SEPARATOR##'

# 定义输入输出
RAW_DATA_PATH = r'/data/dataset/google_patents_202409_unzip'

OUTPUT_BASE_PATH = r'/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/'

INVENTOR_HARMONIZED_PATH = OUTPUT_BASE_PATH + 'inventor_harmonized.csv'
ASSIGNEE_HARMONIZED_PATH = OUTPUT_BASE_PATH + 'assignee_harmonized.csv'
EXAMINER_PATH = OUTPUT_BASE_PATH + 'examiner.csv'

OUTPUT_CONFIG = {
    # 标量字段 (Scalar Fields)
    'publication': {
        'path': OUTPUT_BASE_PATH + 'publication.csv',
        'headers': ['publication_number', 'application_number', 'country_code', 'kind_code', 'application_kind', 'application_number_formatted', 'pct_number', 'family_id', 'spif_publication_number', 'spif_application_number', 'publication_date', 'filing_date', 'grant_date', 'priority_date', 'entity_status', 'art_unit'],
        'json_field': None  # 标量字段直接从根对象提取
    },
    # 一对多字段 (One-to-Many Fields)
    'title': {
        'path': OUTPUT_BASE_PATH + 'publication_title.csv',
        'headers': ['publication_number', 'text', 'language', 'truncated'],
        'json_field': 'title_localized'
    },
    'abstract': {
        'path': OUTPUT_BASE_PATH + 'publication_abstract.csv',
        'headers': ['publication_number', 'text', 'language', 'truncated'],
        'json_field': 'abstract_localized'
    },
    'claims': {
        'path': OUTPUT_BASE_PATH + 'publication_claim.csv',
        'headers': ['publication_number', 'text', 'language', 'truncated'],
        'json_field': 'claims_localized'
    },
    'description': {
        'path': OUTPUT_BASE_PATH + 'publication_description.csv',
        'headers': ['publication_number', 'text', 'language', 'truncated'],
        'json_field': 'description_localized'
    },
    # 分类字段 (Classification Fields) - 结构类似，可以复用逻辑
    'uspc': {'path': OUTPUT_BASE_PATH + 'publication_uspc.csv', 'headers': ['publication_number', 'code', 'inventive', 'first', 'tree'], 'json_field': 'uspc'},
    'ipc': {'path': OUTPUT_BASE_PATH + 'publication_ipc.csv', 'headers': ['publication_number', 'code', 'inventive', 'first', 'tree'], 'json_field': 'ipc'},
    'cpc': {'path': OUTPUT_BASE_PATH + 'publication_cpc.csv', 'headers': ['publication_number', 'code', 'inventive', 'first', 'tree'], 'json_field': 'cpc'},
    'fi': {'path': OUTPUT_BASE_PATH + 'publication_fi.csv', 'headers': ['publication_number', 'code', 'inventive', 'first', 'tree'], 'json_field': 'fi'},
    'fterm': {'path': OUTPUT_BASE_PATH + 'publication_fterm.csv', 'headers': ['publication_number', 'code', 'inventive', 'first', 'tree'], 'json_field': 'fterm'},
    'locarno': {'path': OUTPUT_BASE_PATH + 'publication_locarno.csv', 'headers': ['publication_number', 'code', 'inventive', 'first', 'tree'], 'json_field': 'locarno'},
    # 多对多/复杂关系字段 (Many-to-Many / Complex Relations)
    'inventor_map': {
        'path': OUTPUT_BASE_PATH + 'publication_inventor.csv',
        'headers': ['publication_number', 'inventor_id', 'inventor_sequence'],  # 添加 'sequence'
        'json_field': 'inventor_harmonized'
    },
    'assignee_map': {
        'path': OUTPUT_BASE_PATH + 'publication_assignee.csv',
        'headers': ['publication_number', 'assignee_id', 'assignee_sequence'],  # 添加 'sequence'
        'json_field': 'assignee_harmonized'
    },
    'examiner_map': {
        'path': OUTPUT_BASE_PATH + 'publication_examiner.csv',
        'headers': ['publication_number', 'examiner_id'],
        'json_field': 'examiner'
    },
    'patent_citation': {
        'path': OUTPUT_BASE_PATH + 'publication_citation.csv',
        'headers': ['publication_number', 'cited_publication_number', 'type', 'category'], 
        'json_field': 'citation'
    },
    'non_patent_citation': {
        'path': OUTPUT_BASE_PATH + 'publication_non_patent_reference.csv',
        'headers': ['publication_number', 'npl_text', 'type', 'category'],
        'json_field': 'citation'
    },
    'priority_claim': {
        'path': OUTPUT_BASE_PATH + 'publication_priority_claim.csv',
        'headers': ['publication_number', 'priority_application_number', 'filing_date'],
        'json_field': 'priority_claim'
    },
    'child': {
        'path': OUTPUT_BASE_PATH + 'publication_child.csv',
        'headers': ['publication_number', 'child_application_number', 'type', 'filing_date'], 
        'json_field': 'child'
    },
    'parent': {
        'path': OUTPUT_BASE_PATH + 'publication_parent.csv',
        'headers': ['publication_number', 'parent_application_number', 'type', 'filing_date'], 
        'json_field': 'parent'
    }
}

# 读取inventor、assignee、examiner的ID
inventor_id_dict = {}
with open(INVENTOR_HARMONIZED_PATH, 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    for row in tqdm(reader, desc='Reading inventor ids...'):
        inventor_id_dict[f"{row['name']}{DELIMITER}{row['country_code']}"] = row['inventor_id']

assignee_id_dict = {}
with open(ASSIGNEE_HARMONIZED_PATH, 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    for row in tqdm(reader, desc='Reading assignee ids...'):
        assignee_id_dict[f"{row['name']}{DELIMITER}{row['country_code']}"] = row['assignee_id']

examiner_id_dict = {}
with open(EXAMINER_PATH, 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    for row in tqdm(reader, desc='Reading examiner ids...'):
        examiner_id_dict[f"{row['name']}{DELIMITER}{row['department']}{DELIMITER}{row['level']}"] = row['examiner_id']

# 准备输入文件
raw_jsonl_file_list = sorted(glob(RAW_DATA_PATH + '/*', recursive=True))
print(f'There are {len(raw_jsonl_file_list)} files to be processed')
print(f'First file name: {raw_jsonl_file_list[0]}')
print(f'Last file name: {raw_jsonl_file_list[-1]}')

# 准备输出函数
def write_batches(batches, initial_write=False):
    """将所有批处理数据写入对应的CSV文件。"""
    for key, data in batches.items():
        if not data:
            continue
        
        config = OUTPUT_CONFIG[key]
        mode = 'w' if initial_write else 'a'
        
        with open(config['path'], mode, newline='', encoding='utf-8') as f:
            writer = csv.writer(f, quoting=csv.QUOTE_ALL)
            if initial_write:
                writer.writerow(config['headers'])
            writer.writerows(data)

# ==============================================================================
# 核心解析与批量写入循环 (已修改以包含顺序号)
# ==============================================================================
BATCH_SIZE = 100000  # 建议调大批次以提高IO效率

# 使用字典统一管理所有批处理列表
batches = {key: [] for key in OUTPUT_CONFIG.keys()}
is_first_write = True
line_counter = 0

for file in tqdm(raw_jsonl_file_list, desc='Processing files'):
    with open(file, 'r', encoding='utf-8') as f:
        for line in f:
            try:
                patent = json.loads(line)
                pub_num = patent.get('publication_number')
                if not pub_num:
                    continue

                # --- 1. 处理标量字段 (无变化) ---
                # scalar_row = [patent.get(h) for h in OUTPUT_CONFIG['publication']['headers']]
                # 重写，如果遇到date等于0的情况，要将0变成空字符串
                scalar_row = [patent.get(h) if str(patent.get(h)) != '0' else '' if h in ['publication_date', 'filing_date', 'grant_date', 'priority_date'] else patent.get(h) for h in OUTPUT_CONFIG['publication']['headers']]
                batches['publication'].append(scalar_row)

                # --- 2. 处理通用的一对多关系 (无变化) ---
                one_to_many_keys = ['title', 'abstract', 'claims', 'description', 
                                    'uspc', 'ipc', 'cpc', 'fi', 'fterm', 'locarno']
                for key in one_to_many_keys:
                    config = OUTPUT_CONFIG[key]
                    if config['json_field'] in patent:
                        for item in patent[config['json_field']]:
                            if 'tree' in item and isinstance(item.get('tree'), list):
                                item['tree'] = ';'.join(item.get('tree', []))
                            row = [pub_num] + [item.get(h) for h in config['headers'][1:]]
                            batches[key].append(row)
                
                # # --- 3. 处理复杂的多对多关系 ---
                
                # Inventor (*** 已修改 ***)
                if 'inventor_harmonized' in patent:
                    # 使用 enumerate 来获取顺序号 (从0开始)
                    for i, item in enumerate(patent['inventor_harmonized']):
                        lookup_key = f"{item.get('name')}{DELIMITER}{item.get('country_code')}"
                        inventor_id = inventor_id_dict.get(lookup_key)
                        sequence = i + 1
                        if inventor_id:
                            # 在行末尾添加顺序号 i
                            batches['inventor_map'].append([pub_num, inventor_id, sequence])

                # Assignee (*** 已修改 ***)
                if 'assignee_harmonized' in patent:
                    # 使用 enumerate 来获取顺序号 (从0开始)
                    for i, item in enumerate(patent['assignee_harmonized']):
                        lookup_key = f"{item.get('name')}{DELIMITER}{item.get('country_code')}"
                        assignee_id = assignee_id_dict.get(lookup_key)
                        sequence = i + 1
                        if assignee_id:
                            # 在行末尾添加顺序号 i
                            batches['assignee_map'].append([pub_num, assignee_id, sequence])

                # Examiner (无变化)
                if 'examiner' in patent:
                    for item in patent['examiner']:
                        lookup_key = f"{item.get('name')}{DELIMITER}{item.get('department')}{DELIMITER}{item.get('level')}"
                        examiner_id = examiner_id_dict.get(lookup_key)
                        if examiner_id:
                            batches['examiner_map'].append([pub_num, examiner_id])

                # Citation, Priority, Child, Parent 等关系 (无变化)
                if 'citation' in patent:
                    for item in patent['citation']:
                        cited_pub_num = item.get('publication_number')
                        if cited_pub_num:
                            batches['patent_citation'].append([pub_num, cited_pub_num, item.get('type'), item.get('category')])
                        elif item.get('npl_text'):
                            batches['non_patent_citation'].append([pub_num, item.get('npl_text'), item.get('type'), item.get('category')])
                
                if 'priority_claim' in patent:
                    for item in patent['priority_claim']:
                        app_num = item.get('application_number')
                        if app_num:
                            batches['priority_claim'].append([pub_num, app_num, item.get('filing_date') if int(item.get('filing_date')) != 0 else ''])

                if 'child' in patent:
                    for item in patent['child']:
                        app_num = item.get('application_number')
                        if app_num:
                             batches['child'].append([pub_num, app_num, item.get('type'), item.get('filing_date') if int(item.get('filing_date')) != 0 else ''])
                
                if 'parent' in patent:
                    for item in patent['parent']:
                        app_num = item.get('application_number')
                        if app_num:
                             batches['parent'].append([pub_num, app_num, item.get('type'), item.get('filing_date') if int(item.get('filing_date')) != 0 else ''])

                line_counter += 1
                
                # --- 4. 批量写入 (无变化) ---
                if line_counter % BATCH_SIZE == 0:
                    write_batches(batches, initial_write=is_first_write)
                    batches = {key: [] for key in OUTPUT_CONFIG.keys()}
                    is_first_write = False
                    
            except Exception as e:
                print(f"Error processing line: {line_counter}. Error: {e}")
                continue

# --- 5. 处理并写入最后一批剩余的数据 (无变化) ---
write_batches(batches, initial_write=is_first_write)
print("All files processed.")