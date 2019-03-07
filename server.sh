#!/bin/bash

###
# Step.
# 1. create directory to /var/www
# 2. add placholder file index.html
# 3. add nginx config file and link
# 4. test nginx and reload
###

source .env
INPUT_DOMAIN=$1
DOMAIN_HOME=$HOME_DIRECTORY/$INPUT_DOMAIN/html
COLOR="\033[01;32m"
# Create home directory
sudo mkdir -p $DOMAIN_HOME
sudo chown -R $FILES_USER:$FILES_GROUP $HOME_DIRECTORY/$INPUT_DOMAIN
TEMPLATE_HTML=$(cat template.html)
CUSTOMER_HTML=$(cat <<EOM
    <li>Upload your web source to <span class="tag">$HOME_DIRECTORY/$INPUT_DOMAIN/html</span></li>
    <li>You can access this page from <span class="tag">$INPUT_DOMAIN, www.$INPUT_DOMAIN</span></li>
EOM
)
# Create placeholder index.html from template
echo "${TEMPLATE_HTML/<!--?-->/$CUSTOMER_HTML}" > $HOME_DIRECTORY/$INPUT_DOMAIN/html/index.html

NGINX_CONF=$(cat <<EOM
# HTTP
server {
    listen $HTTP_PORT;

    # Server Root
    server_name $INPUT_DOMAIN www.$INPUT_DOMAIN;
    root $HOME_DIRECTORY/$INPUT_DOMAIN/html;

    # Logs
    access_log $NGINX_LOG_DIRECTORY/$INPUT_DOMAIN/access.log;
    error_log $NGINX_LOG_DIRECTORY/$INPUT_DOMAIN/error.log;

    # Pretty URLs
    location / {
        index index.htm index.html index.php;
        try_files \$uri \$uri/ /index.php\$is_args$args;
    }

    # PHP FastCGI Proxy
    location ~ \.php\$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
        try_files \$uri \$uri/ =404;
        fastcgi_pass unix:/run/php/php$PHP_FPM_VERSION-fpm.sock;
    }
}
EOM
)

# Create nginx config and symbolic link
echo "$NGINX_CONF" > $NGINX_DIRECTORY/sites-available/$INPUT_DOMAIN.conf
ln -s $NGINX_DIRECTORY/sites-available/$INPUT_DOMAIN.conf $NGINX_DIRECTORY/sites-enabled/$INPUT_DOMAIN.conf

# Create log directory
mkdir -p $NGINX_LOG_DIRECTORY/$INPUT_DOMAIN
echo -e "$COLOR Creating '$INPUT_DOMAIN' at $NGINX_LOG_DIRECTORY/$INPUT_DOMAIN"
echo -e "$COLOR Add '$INPUT_DOMAIN' successfully!"

