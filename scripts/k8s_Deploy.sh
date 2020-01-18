#!/bin/bash

docker image prune -af

kubectl set image deployment/pythonapp docker-python-app=yp29/pythondeploy:pythonapp-base

sleep 30 # waiting before deleteing the unused latest images localy
docker image prune -af

kubectl set image deployment/pythonapp docker-python-app=yp29/pythondeploy:pythonapp-latest

sleep 30 # waiting before deleteing the unused base images localy
docker image prune -af