#!/bin/bash

# Define location of source .env file
ENVDIR=/some/path

for dir in */; do
    if [ ! -e "$dir/.env" ]; then
        ln -s $ENVDIR/.env $dir/.env
        echo "Link created for $dir"
    fi
done;
