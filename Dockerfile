# Install Debian Buster
FROM debian:buster

# Export AUTOINDEX
ENV AUTOINDEX on

# Working Directory
WORKDIR /var/www/html

# Update packages && installations
RUN apt-get update && apt-get upgrade -y	\
	vim										\
	wget									\
	nginx									\
	mariadb-server							\
	php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring 
	
# Install PhpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin

# Install Wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

# SSL Certification
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=FR/ST=Paris/L=Paris/O=42Paris/CN=jfremond" -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

# Change Authorization
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*

# Copy and delete files
COPY ./srcs/init.sh ./
COPY ./srcs/nginx-conf-on ./
COPY ./srcs/nginx-conf-off ./
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin
COPY ./srcs/wp-config.php /var/www/html/wordpress
RUN rm /var/www/html/index.nginx-debian.html

# Run init.sh
CMD bash init.sh