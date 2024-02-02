# public_scripts

Collection of little scripts that might be of use for people looking to automate stuff.

### bashrc_aliases.sh
Will insert aliases into your bashrc (do not run as sudo). <br />

### debian_automated_docker_install.sh 
Will install docker and docker compose on debian. <br />
Update the compose version if required (variable $VERSION at the top). <br />

### mount_network_shares.sh
Will mount network drives by interactively entering the IP, username and password of the SMB host. <br />
After you enter the variables, the script will fetch the list of available shares on the host and ask if you want to mount them, one by one. <br />

### start-stop-restart_all_containers.sh
Will do what the name says. <br />
Place this script at the root of your docker projects. <br />

### create_symlink.sh
Will create symlinks of a source .env file to serve all your compose files (one .env to rule them all). <br />
Place this script at the root of your docker projects. <br />
Update the path variables ($ENVDIR) at the beginning of the file. <br />

### docker_full_backup.sh
Will generate zip files with of your docker projects + databases. <br />
Check variables at the beginning of the file. <br />

### ubuntu_automated_docker_install.sh
Will install docker and docker compose on debian. <br />
Update the version if required (variable $VERSION at the top). <br />
