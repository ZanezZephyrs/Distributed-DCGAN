# copy repo

git clone https://github.com/ZanezZephyrs/Distributed-DCGAN.git

cd Distributed_DCGAN

#download and extract cifar10 dataset
mkdir cifar10 && cd cifar10
wget --no-check-certificate https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
tar -xvf cifar-10-python.tar.gz
cd ..

# run docker build 

docker build -t dist_dcgan .