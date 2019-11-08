module load pgi
module load cuda

cd ./1024
sh ./run.sh
cd ..

cd ./2048
sh ./run.sh
cd ..

cd ./4096
sh ./run.sh
cd ..