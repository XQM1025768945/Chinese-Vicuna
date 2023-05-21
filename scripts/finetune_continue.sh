TOT_CUDA="2,3"
CUDAs=(${TOT_CUDA//,/ })
CUDA_NUM=${#CUDAs[@]}
PORT="12345"

DATA_PATH="sample/instruct/data_sample.jsonl" #"../dataset/instruction/guanaco_non_chat_mini_52K-utf8.json"
OUTPUT_PATH="lora-Vicuna-output"
MODEL_PATH="decapoda-research/llama-7b-hf"
lora_remote_checkpoint="Chinese-Vicuna/Chinese-Vicuna-lora-7b-belle-and-guanaco-11600"
lora_checkpoint="./lora-Vicuna/checkpoint-11600"
from_data_beginning=False # True
TEST_SIZE=1

CUDA_VISIBLE_DEVICES=${TOT_CUDA} torchrun --nproc_per_node=$CUDA_NUM --master_port=$PORT finetune.py \
--data_path $DATA_PATH \
--output_path $OUTPUT_PATH \
--model_path $MODEL_PATH \
--eval_steps 200 \
--save_steps 200 \
--test_size $TEST_SIZE \
--resume_from_checkpoint $lora_checkpoint \
--lora_remote_checkpoint $lora_remote_checkpoint \
--ignore_data_skip $from_data_beginning
