#!/bin/bash

echo "#============================================="
echo "# Enter variables and generate credential file"
echo "#============================================="
echo " "

read -p "enter the IP adress of the server: " ipadress
read -p "Enter the username: " usrname
echo "Enter the password:"
stty -echo
read passwd
stty echo

# confirm credentials
while true; do
read -p "Are these credentials correct (y/n) " yn
case $yn in 
    [yY] ) echo "ok, inserting credentials in /etc/.mycredentials" ;
        break;;
    [nN] ) echo exiting...;
        exit;;
    * ) echo invalid response;;
esac
done

# remove existing file before adding new login
rm -f -- /etc/.mycredentials

# add credentials to file
echo "username=${usrname}" > /etc/.mycredentials
echo "password=${passwd}" >> /etc/.mycredentials
echo "credential file created"

echo " "

set -x

#======================================
# Install required packages
# error messages can be ignored
#======================================

sudo apt install -y cifs-utils nfs-common smbclient

#======================================
# Fetch network shares
#======================================

{ set +x; } 2>/dev/null

#echo "smbclient -L $ipadress -U $usrname%$passwd | tail -n +4 | awk '{print '$1'}'"
echo smbclient -L $ipadress -U $usrname%$passwd | tail -n +4 | cut -d' ' -f1 > /mnt/sharelist.txt
smbclient -L $ipadress -U $usrname%$passwd | tail -n +4 | cut -d' ' -f1 > /mnt/sharelist.txt

# loop each Remote folder and ask if it should be mapped

#======================================
# Mount network shares
#======================================

export terminal=$(tty)

while read LINE
do
    while true; do
        read -p "Add the $LINE folder ? (y/n) " yn
        case $yn in 
            [yY]* ) echo "ok, adding the $LINE folder";
                mkdir -p /mnt/$LINE;
                sudo grep -qxF "//$ipadress/$LINE /mnt/$LINE/ cifs credentials=/etc/.mycredentials,iocharset=utf8,uid=1000,gid=1000,noperm 0 0" /etc/fstab || sudo echo "//$ipadress/$LINE /mnt/$LINE/ cifs credentials=/etc/.mycredentials,iocharset=utf8,uid=1000,gid=1000,noperm 0 0" >> /etc/fstab;
                break;;
            [nN]* ) echo "ok, skipping"...;
                break;;
            * ) echo invalid response;;
        esac
    done < $terminal
done < /mnt/sharelist.txt

rm /mnt/sharelist.txt

echo "all entries are ready, mounting drives"
sudo mount -a

echo "#============================================="
echo "# End of script"
echo "#============================================="
