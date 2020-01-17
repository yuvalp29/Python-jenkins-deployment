#!/bin/bash

# Just to notice:
# $1 = docker_name
# $2 = registry
# $3 = rep_name
# $4 = commit_id

if [ "$(docker ps -q -f name=$1)" ]; then
    docker stop $1
fi
docker run -it --rm -p 8080:8080 -d --rm --name $1 $2:$3-$4

#docker run -it --rm --name my-first-python-script -v "$PWD":/usr/src/widget_app python:2 python my_script.py