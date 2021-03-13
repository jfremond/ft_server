service nginx start
service mysql start
service php7.3-fpm start

# Change authorization
chown -R www-data:www-data *
chmod -R 755 /var/www/*

# Website folder
mkdir /var/www/monsite/ && touch /var/www/monsite/index.php
echo "<?php phpinfo(); ?>" >> /var/www/monsite/index.php

# SSL Certification
mkdir /etc/nginx/ssl
openssl req -newkey -x509 -days 365 -nodes /etc/nginx/ssl/monsite.pem -keyout /etc/nginx/ssl/monsite.key -subj "/C=FR/ST=IDF/L=Paris/O=42Paris/OU=jfremond/CN=monsite"

# Config NGINX
mv ./tmp/nginx-conf /etc/nginx/sites-available/monsite
ln -s /etc/nginx/sites-available/monsite /etc/nginx/sites-enabled/monsite
rm -rf /etc/nginx/sites-enabled/default

# Wordpress Database
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | myqsl -u root --skip-password
echo "update mysql.user set plugin='' where user='root';" | mysql -u root --skip-password

# DL phpmyadmin
mkdir /var/www/monsite/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/monsite/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/monsite/phpmyadmin/config.inc.php

# DL wordpress
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/monsite
mv /tmp/wp-config.php /var/www/monsite/wordpress

bash