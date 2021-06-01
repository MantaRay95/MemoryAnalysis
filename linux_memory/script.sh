# Linux Memory Collector with avml
# Profile detail collecter with LiMe
# Copyright (c) Pavithra Rasanjana - Deltaspike
#
#
# Author:
# Pavithra Rasanjana - pavithra.bulathsinghe@deltaspike.io

echo "Acquiring memory image...."
./avml Details/memory.dmp

echo "Gathering profile info...."
kernel=$(uname -r)
os=$(lsb_release -i -s)

echo "Getting module.ko...."
cd linux
make
cd ../

echo "Getting System.map...."
sudo cp /boot/System.map-$kernel Details/
echo "Getting kernel info...."
echo "Kernel : $kernel" > Details/$kernel-details.txt
echo "OS : $os" >> Details/$kernel-details.txt
echo "Done!!!!"
