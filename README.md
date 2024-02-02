# public_scripts

Collection of little scripts that might be of use for people looking to automate stuff.

bashrc_aliases.sh
    Will insert aliases into your bashrc (do not run as sudo)

debian_automated_docker_install.sh 
    Will install docker and docker compose on debian
    Update the compose version if required (variable $VERSION at the top)

mount_network_shares.sh
    Will mount network drives by interactively entering the IP, username and password of the SMB host
    After you enter the variables, the script will fetch the list of available shares on the host and ask if you want to mount them, one by one.

start-stop-restart_all_containers.sh
    Will do what the name says
    Place this script at the root of your docker projects

create_symlink.sh
    Will create symlinks of a source .env file to serve all your compose files (one .env to rule them all)
    Place this script at the root of your docker projects
    Update the path variables ($ENVDIR) at the beginning of the file

docker_full_backup.sh
    Will generate zip files with of your docker projects + databases
    Check variables at the beginning of the file

ubuntu_automated_docker_install.sh
    Will install docker and docker compose on debian
    Update the version if required (variable $VERSION at the top)
