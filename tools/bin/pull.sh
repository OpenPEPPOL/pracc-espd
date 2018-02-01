#!/bin/sh

FOLDER=$(echo $(dirname $(readlink -f "$0")) | sed "s:/tools/bin::")

if [ $(command -v docker-compose | wc -l) = "1" ]; then
    docker-compose \
        --project-directory $FOLDER \
        -f $FOLDER/docker-compose.yml \
        pull
else
    docker run --rm -i \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v $FOLDER:/src \
        docker/compose:1.18.0 \
        --project-directory $FOLDER \
        -f /src/docker-compose.yml \
        -p vefa-ehf-espd \
        pull
fi
