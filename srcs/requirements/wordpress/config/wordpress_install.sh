if  [ ! -f "/var/www/html/.wpinstalled" ];
then
	echo "##################################################"
	echo "####            Create config                 ####"
	echo "##################################################"

	echo "Erasing /var/www/html/wp-config.php"
	rm -rf /var/www/html/wp-config.php
	echo "[+] /var/www/html/wp-config.php"

	echo "##################################################"

	echo "WP create config"
	wp config create --dbname=$DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASSWORD --dbhost="mariadb" --path="/var/www/html/" --allow-root --skip-check
	echo "[+] WP create config"

	echo "##################################################"

	echo "Install WP Core"
	wp core install --url="localhost" --title="Super Site De Rayan Mechety" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path="/var/www/html/" --allow-root
	echo "[+] Install WP Core"

	echo "##################################################"

	echo "WP Create user"
	wp user create $WP_AUTHOR_USER $WP_AUTHOR_EMAIL --role=author --user_pass=$WP_AUTHOR_PASSWORD --allow-root
	echo "[+] WP Create user"

	echo "##################################################"

	echo "Creating /var/lib/mysql/.wpinstalled"
	touch /var/www/html/.wpinstalled
	echo "[+] Creating /var/lib/mysql/.wpinstalled"

	echo "##################################################"

	echo "[+] Create config finished"

	echo "##################################################"

else
	echo "##################################################"
	echo "####         Config already created         ####"
	echo "##################################################"
fi

echo "Starting PHP-FPM"
exec php-fpm7.3 --nodaemonize