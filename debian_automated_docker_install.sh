#!/bin/bash
echo "======================================"
echo " DOCKER & DOCKER-COMPOSE INSTALLATION "
echo "======================================"
echo ""

echo "install base packages"
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "create directory for docker keyring"
sudo mkdir -p /etc/apt/keyrings

echo "add docker keyring"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "add keyring to apt sources"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "install docker"
sudo apt update && apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "also install docker-compose"
sudo curl -L https://github.com/docker/compose/releases/download/2.24.3/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo " "
echo "==========================================="
echo " DOCKER & DOCKER-COMPOSE INSTALLATION DONE "
echo "==========================================="
echo ""

while true; do
read -p "Do you want to enable running docker without sudo (y/n) " yn
case $yn in 
    [yY] ) echo "ok, adding you to the docker group" ;
        sudo usermod -aG docker ${SUDO_USER};
        break;;
    [nN] ) echo "skipping this step";
        break;;
    * ) echo invalid response;;
esac
done

echo ""
echo "==========================="
echo " DOCKER INSTALLATION READY "
echo "==========================="
echo ""
