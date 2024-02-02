#!/bin/bash

# SET VARIABLES
$VERSION=v2.24.5

echo "======================================"
echo " INSTALLING DOCKER "
echo "======================================"
echo ""

echo "Add Docker's official GPG key"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "Add the repository to Apt sources"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "install the packages"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo " "
echo "# =============================="
echo "# DOCKER INSTALLED " 
echo " "
echo "# INSTALLING DOCKER COMPOSE "
echo "# =============================="
echo " "

echo "get file"
sudo curl -L "https://github.com/docker/compose/releases/download/$VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "make file executable"
sudo chmod +x /usr/local/bin/docker-compose

echo "check install"
docker-compose --version

echo " "
echo "# =============================="
echo "# END OF SCRIPT "
echo "# =============================="
echo " "
