#!/bin/bash

set -e

image=liridev/ci-ubuntu:latest

env_vars="-e CC=$CC -e DEBIAN_FRONTEND=noninteractive"
for line in $(env | egrep -e '^(FTP|TRAVIS|CLAZY)'); do
    env_vars="$env_vars -e $line"
done

sudo docker pull $image
sudo docker run --rm -ti -v $(pwd):/home $env_vars --workdir /home $image ./.travis/build.sh
