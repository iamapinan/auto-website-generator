#!/bin/bash

#######
# Created by Apinan Woratrakun
# Date 07-03-2019
# License unlicense
#######

INPUT=$1
FILE=$2

if [ $INPUT == 'server' ]; then
    for domain in $(cat $FILE); do 
        ./server.sh $domain
    done

    # Reload nginx
    nginx -s reload
fi