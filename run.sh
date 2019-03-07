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

if [ $INPUT == 'remove' ]; then
    source .env
    for domain in $(cat $FILE); do 
        sudo rm -fr $NGINX_LOG_DIRECTORY/$domain
        sudo rm -fr $HOME_DIRECTORY/$domain
        sudo rm $NGINX_DIRECTORY/sites-available/$domain.conf
        sudo rm $NGINX_DIRECTORY/sites-enabled/$domain.conf
        echo "$domain deleted."
    done

    # Reload nginx
    nginx -s reload
fi