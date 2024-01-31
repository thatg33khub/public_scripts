# The script must be located in the project folder, above the stack folders:
# /opt/stacks/create_symlink.sh
# /opt/stacks/bitwarden
# /opt/stacks/portainer
# ...


# Check that the script runs with sudo
if [ "$USER" != "root" ]
then
    echo "Please run this as root or with sudo"
    exit 2
fi

# Choose the command to execute
echo "Choose the command you want to use:"
echo "1 - Start all containers"
echo "2 - Stop all containers"
echo "3 - Restart all containers"
read docker_command;

# Execute the docker compose command
case $docker_command in
    [1] ) echo "ok, starting the containers" ;
        for dir in */; do
        docker compose -f $dir/docker-compose.yml up -d
        done;
        break;;
    [2] ) echo "ok, stopping the containers" ;
        for dir in */; do
        docker compose -f $dir/docker-compose.yml down
        done;
        break;;
    [3] ) echo "ok, restarting the containers" ;
        for dir in */; do
        docker compose -f $dir/docker-compose.yml restart
        done;
        break;;
    * ) echo invalid response;;
esac

echo " "
echo "End of script"
