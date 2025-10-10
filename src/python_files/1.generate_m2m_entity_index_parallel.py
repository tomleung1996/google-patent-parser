import multiprocessing
import csv
from tqdm import tqdm
import orjson as json
from glob import glob

RAW_DATA_PATH = r'/data/dataset/google_patents_202409_unzip'

INVENTOR_OUTPUT_PATH = r'/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/inventor_harmonized.csv'
ASSIGNEE_OUTPUT_PATH = r'/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/assignee_harmonized.csv'
EXAMINER_OUTPUT_PATH = r'/data/users/liangzhentao/Projects/google-patent-parser/data/output_202409/examiner.csv'

INVENTOR_HEADERS = ['inventor_id', 'name', 'country_code']
ASSIGNEE_HEADERS = ['assignee_id', 'name', 'country_code']
EXAMINER_HEADERS = ['examiner_id', 'name', 'department', 'level']

DELIMITER = '##SEPARATOR##'

# 1. 定义处理单个文件的工作函数
def process_file(file_path):
    """处理单个文件，返回从该文件中提取的三个集合。"""
    local_inventor_set = set()
    local_assignee_set = set()
    local_examiner_set = set()
    
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            try:
                patent = json.loads(line)

                # 使用 set.update 和生成器表达式优化内部循环
                local_inventor_set.update(
                    f"{inv['name']}{DELIMITER}{inv['country_code']}" 
                    for inv in patent.get('inventor_harmonized', [])
                )
                
                local_assignee_set.update(
                    f"{asg['name']}{DELIMITER}{asg['country_code']}" 
                    for asg in patent.get('assignee_harmonized', [])
                )
                
                local_examiner_set.update(
                    f"{ex['name']}{DELIMITER}{ex['department']}{DELIMITER}{ex['level']}" 
                    for ex in patent.get('examiner', [])
                )
            except (json.JSONDecodeError, KeyError) as e:
                # 良好的实践：处理可能的json解析错误或键不存在的错误
                print(f"Skipping line in {file_path} due to error: {e}")
                continue
                
    return local_inventor_set, local_assignee_set, local_examiner_set

# 保存函数
def save_set_to_csv(data_set, output_filename, header):

    print(f"Processing and saving data to {output_filename}...")
    sorted_data = sorted(list(data_set))
    
    with open(output_filename, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f, quoting=csv.QUOTE_ALL)
        writer.writerow(header)

        for entity_id, combined_string in enumerate(sorted_data, start=1):
            parts = combined_string.split(DELIMITER)
            row_to_write = [entity_id] + parts
            writer.writerow(row_to_write)
            
    print(f"Successfully saved {len(sorted_data)} records to {output_filename}.")

# --- 主程序 ---
if __name__ == '__main__':
    raw_jsonl_file_list = sorted(glob(RAW_DATA_PATH + '/*', recursive=True))
    print(f'There are {len(raw_jsonl_file_list)} files to process.')
    print(f'First file name: {raw_jsonl_file_list[0]}')
    print(f'Last file name: {raw_jsonl_file_list[-1]}')

    # 初始化最终的集合
    inventor_harmonized_set = set()
    assignee_harmonized_set = set()
    examiner_set = set()
    
    # 2. 创建进程池，进程数可以根据你的CPU核心数调整
    # os.cpu_count() 可以获取核心数
    num_processes = 48
    print(f"Using {num_processes} processes for parallel execution.")
    
    with multiprocessing.Pool(processes=num_processes) as pool:
        # 3. 使用 imap_unordered 来并行处理文件，并用 tqdm 显示进度条
        # imap_unordered 效率更高，因为它不关心任务完成的顺序
        results = list(tqdm(
            pool.imap_unordered(process_file, raw_jsonl_file_list),
            total=len(raw_jsonl_file_list),
            desc='Processing files in parallel'
        ))

    # 4. 合并所有进程返回的结果
    print("Merging results...")
    for inv_set, assignee_set, exam_set in tqdm(results, desc='Merging sets'):
        inventor_harmonized_set.update(inv_set)
        assignee_harmonized_set.update(assignee_set)
        examiner_set.update(exam_set)
    
    # 保存结果
    save_set_to_csv(inventor_harmonized_set, INVENTOR_OUTPUT_PATH, INVENTOR_HEADERS)
    save_set_to_csv(assignee_harmonized_set, ASSIGNEE_OUTPUT_PATH, ASSIGNEE_HEADERS)
    save_set_to_csv(examiner_set, EXAMINER_OUTPUT_PATH, EXAMINER_HEADERS)
        
    print("Processing complete.")
    print(f"Found {len(inventor_harmonized_set)} unique inventors.")
    print(f"Found {len(assignee_harmonized_set)} unique assignees.")
    print(f"Found {len(examiner_set)} unique examiners.")