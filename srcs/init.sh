if [[ ${AUTOINDEX} = "on" ]]
then
	cp nginx-conf-on /etc/nginx/sites-available/default
else
	cp nginx-conf-off /etc/nginx/sites-available/default
fi

service mysql start

# Wordpress Database
echo "CREATE DATABASE wordpress;" |mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" |mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" |mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';" |mysql -u root --skip-password

service php7.3-fpm start
service nginx start
#sleep infinity
bash