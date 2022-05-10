# instruções para execução do treinamento em varias maquinas na AWS

## Criação da imagem base

- Crie uma instancia (ela sera usada para criação da imagem base, não precisa ter alta computação), é necessario que o disco associado a instancia tenha pelo menos 20GB.
- Acesse a instancia criada por SSH e execute os comandos listados no arquivo "docker_setup" para instalar o docker na maquina.
- Execute os comandos em "train_setup" para clonar o repositorio, baixar o dataset do cifar10 e construir a imagem que sera utilizada no treino (a construção da imagem demanda cerca de 17GB de disco).
- Crie a partir dessa maquina uma AMI, essa AMI sera usada para criação das proximas maquinas que efetivamente executaram o treino.

## Realização do treinamento

- Crie N instancias, lembre-se de usar a AMI criada nos passos anteriores. Associe a estas instancias um grupo de segurança que permita o livre acesso entre maquinas na mesma vpc.
- Entre na instancia que sera o nó mestre no treinamento e execute o comando, trocando <IP_MASTER_NODE> pelo ip privado da maquina e <N>  pelo numero de maquinas sendo usadas no treinamento.
``` 
cd Distributed_DCGAN
docker run --env OMP_NUM_THREADS=1 --rm --network=host -p 1234:1234 -v=$(pwd):/root dist_dcgan:latest python -m torch.distributed.launch --nproc_per_node=1 --nnodes=<N> --node_rank=0 --master_addr=<IP_MASTER_NODE> --master_port=1234 dist_dcgan.py --dataset cifar10 --dataroot ./cifar10
``` 

- Entre em cada um das outras Maquinas e execute o seguinte comando, trocando <X> por um numero unico entre os nós ( de 1 até N-1), <N> pelo numero total de maquinas sendo utilizado no treinamento e <IP_MASTER_NODE> pelo ip privado do nó mestre do treinamento.
``` 
cd Distributed_DCGAN
docker run --env OMP_NUM_THREADS=1 --rm --network=host -v=$(pwd):/root dist_dcgan:latest python -m torch.distributed.launch --nproc_per_node=1 --nnodes=<N>  --node_rank=<X> --master_addr=<IP_MASTER_NODE> --master_port=1234 dist_dcgan.py --dataset cifar10 --dataroot ./cifar10
``` 

Após o comando ser executado em todas as maquinas, o treinamento deve começar e você deve começar a ver logs de execução no stdout.