service mysql start

# Generate website folder
touch /var/www/html/index.php
echo "<?php phpinfo(); ?>" >> /var/www/html/index.php

# Wordpress Database
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';" | mysql -u root --skip-password

service php7.3-fpm start
service nginx start
bash