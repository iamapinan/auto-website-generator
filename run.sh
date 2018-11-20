#!/bin/bash

INPUT=$1
FILE=$2

if [ $INPUT == 'server' ]; then
    for domain in $(cat $FILE); do 
        ./server.sh $domain
    done
fi