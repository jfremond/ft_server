# Install Debian Buster
FROM debian:buster

# Update packages
RUN apt-get update && apt-get upgrade -y

# Install vim
RUN apt-get -y install vim

# Install wget
RUN apt-get -y install wget

# Install Nginx
RUN apt-get -y install nginx

# Install MariaDB
RUN apt-get -y install mariadb-server

# Install php
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

# Install PhpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin

# Install Wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

# Copy files
COPY ./srcs/init.sh ./
COPY ./srcs/nginx-conf ./tmp/nginx-conf
COPY ./srcs/config.inc.php ./tmp/config.inc.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php

# Run init.sh
CMD bash init.sh