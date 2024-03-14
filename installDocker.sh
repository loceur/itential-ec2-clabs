#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt update -y
apt upgrade -y
apt install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null

# Need AWS cli to grab S3 files
apt install awscli -y


apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

bash -c "$(curl -sL https://get.containerlab.dev)"

cd /home/ubuntu
sudo -u ubuntu git clone https://github.com/loceur/itential-pmlabs.git

# Download the cEOS image and put it in Docker
sudo -u ubuntu aws s3 cp s3://itential-containerlab-images/cEOS64-lab-4.31.2F.tar /home/ubuntu
docker import --change 'VOLUME /mnt/flash' cEOS64-lab-4.31.2F.tar ceos:4.31.2F


echo "All services should be up and ready now.  Go for it!" | wall
