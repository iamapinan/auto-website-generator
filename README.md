# Create Domain Statics

### This script will automatics create  
- Domain mapping in nginx
- Folder for website


### Install instructions
- Clone this repos.
- copy `.env-test` to `.env`
- run `sudo chmod +x *.sh`
- add your domain list to domains.txt *one line per domian*
- start by run `./run.sh server domains.txt`

### Options explain
- `./run.sh server [file]`
- `server` to generate server environments data
- `domains.txt` name of file with the list of domains inside.

### Configurations
```
HOME_DIRECTORY=/var/www 
NGINX_DIRECTORY=/etc/nginx
NGINX_LOG_DIRECTORY=/var/log/nginx
PHP_FPM_VERSION=7.0
```

***HOME_DIRECTORY*** your website folder will create into this.  
***NGINX_DIRECTORY*** your nginx configuration for website will create under sites-* folder wihtin this.  
***NGINX_LOG_DIRECTORY*** your website log will create in this.  
***PHP_FPM_VERSION*** for php-fpm version  

### Created by
[Apinan Woratrakun 📮 <apinan@iotech.co.th>](mailto:apinan@iotech.co.th)