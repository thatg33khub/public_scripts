#!/bin/bash

# The script must be located in the project folder, above the stack folders:
# /opt/stacks/create_symlink.sh
# /opt/stacks/bitwarden
# /opt/stacks/portainer
# ...

# Define location of source .env file
ENVDIR=/some/path

for dir in */; do
    if [ ! -e "$dir/.env" ]; then
        ln -s $ENVDIR/.env $dir/.env
        echo "Link created for $dir"
    fi
done;
