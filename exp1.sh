
number_of_runs=1
result_file=exp1.txt
thread_time_dump_file=thread_time1.txt
number_of_proc=1
batch_size=16
number_of_epochs=1

while getopts n:r: flag
do
    case "${flag}" in
        n) number_of_runs=${OPTARG};;
        r) result_file=${OPTARG};;
    esac
done


for i in $(seq $number_of_runs); do
    BEGIN=$(date)
    echo "begin: $BEGIN" >> results/$result_file
    docker run --env OMP_NUM_THREADS=1 --rm --network=host -v=$(pwd):/root dist_dcgan:latest python -m torch.distributed.launch --nproc_per_node=$number_of_proc --master_addr="172.17.0.1" --master_port=1234 dist_dcgan.py --dataset cifar10 --dataroot ./cifar10 --batch_size $batch_size --num_epochs $number_of_epochs | grep "Epoch 0 took:" >>  results/$thread_time_dump_file
    echo "--------------" >>  results/$thread_time_dump_file
    END=$(date)
    echo "end: $END" >> results/$result_file
done