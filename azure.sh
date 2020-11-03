#!/bin/sh
set -x
sudo apt install -y jq inxi lsscsi
curl -H 'Metadata: true' http://169.254.169.254/metadata/instance?api-version=2020-06-01 2>/dev/null >metadata.json
echo 'VM size:' $(jq -r .compute.vmSize metadata.json)
echo 'VM name:' $(jq -r .compute.name metadata.json)
echo 'VM location:' $(jq -r .compute.location metadata.json)
echo 'Resource group:' $(jq -r .compute.resourceGroupName metadata.json)
echo 'Private ip address:' $(jq -r .network.interface[0].ipv4.ipAddress[0].privateIpAddress metadata.json)
echo 'Public ip address:' $(jq -r .network.interface[0].ipv4.ipAddress[0].publicIpAddress metadata.json)
echo 'CPU model': $(lscpu | sed -nr '/Model name/ s/.*:\s*(.*)/\1/p')

which gcc
gcc --version
which icc
icc --version
which nvcc
nvcc --version

unset SSH_CLIENT
unset SSH_CONNECTION
# https://github.com/SC-Tech-Program/Author-Kit/blob/master/collect_environment.sh
env | sed "s/$USER/USER/g"
lsb_release -a
uname -a
lscpu || cat /proc/cpuinfo
cat /proc/meminfo
inxi -F -c0
lsblk -a
lsscsi -s
module list
nvidia-smi
(lshw -short -quiet -sanitize || lspci) | cat
