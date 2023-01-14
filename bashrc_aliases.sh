#!/bin/bash

# The script will add the following commands if they do not already exist in the .bashrc file

# package managers
grep -qxF "alias dnf='sudo dnf'" ~/.bashrc || echo "alias dnf='sudo dnf'" >> ~/.bashrc
grep -qxF "alias apt-get='sudo apt-get'" ~/.bashrc || echo "alias apt-get='sudo apt-get'" >> ~/.bashrc
grep -qxF "alias pacman='sudo pacman'" ~/.bashrc || echo "alias pacman='sudo pacman'" >> ~/.bashrc
grep -qxF "alias nala='sudo nala'" ~/.bashrc || echo "alias nala='sudo nala'" >> ~/.bashrc

# system
grep -qxF "alias systemctl='sudo systemctl'" ~/.bashrc || echo "alias systemctl='sudo systemctl'" >> ~/.bashrc
grep -qxF "alias reboot='sudo reboot'" ~/.bashrc || echo "alias reboot='sudo reboot'" >> ~/.bashrc
grep -qxF "alias poweroff='sudo poweroff'" ~/.bashrc || echo "alias poweroff='sudo poweroff'" >> ~/.bashrc

# confirmations
grep -qxF "alias mv='mv -i'" ~/.bashrc || echo "alias mv='mv -i'" >> ~/.bashrc
grep -qxF "alias cp='cp -i'" ~/.bashrc || echo "alias cp='cp -i'" >> ~/.bashrc
grep -qxF "alias rm='rm -i'" ~/.bashrc || echo "alias rm='rm -i'" >> ~/.bashrc

# shortcuts
grep -qxF "alias ll='ls -alhF --color=auto'" ~/.bashrc || echo "alias ll='ls -alhF --color=auto'" >> ~/.bashrc

# docker
grep -qxF "alias docker='sudo docker'" ~/.bashrc || echo "alias docker='sudo docker'" >> ~/.bashrc
grep -qxF "alias docker-compose='sudo docker-compose'" ~/.bashrc || echo "alias docker-compose='sudo docker-compose'" >> ~/.bashrc


