#!/bin/bash
#first, please run "./run-in-docker.sh help" to prepare the env.
#todo check json file

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

mkdir -p Generate/java

docker run --rm -it \
        -w /gen \
        -e GEN_DIR=/gen \
        -e MAVEN_CONFIG=/var/maven/.m2 \
        -u "$(id -u):$(id -g)" \
        -v "${PWD}:/gen" \
        -v "${maven_cache_repo}:/var/maven/.m2/repository" \
        --entrypoint /gen/docker-entrypoint.sh \
        maven:3-jdk-7 generate -l java -o /gen/Generate/java -i "$@"
