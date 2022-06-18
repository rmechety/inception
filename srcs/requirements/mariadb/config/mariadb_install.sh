#!/bin/bash

if  [ ! -f "/var/lib/mysql/.mysqlinstalled" ]
then
	echo "##################################################"
	echo "####           Creating Database              ####"
	echo "##################################################"

	# https://www.baeldung.com/linux/envsubst-command
	echo "Creating /var/init_env.sql"
	envsubst < /var/init.sql > /var/init_env.sql
	echo "[+] /var/init_env.sql"

	echo "##################################################"

	# https://bash.cyberciti.biz/guide/Service_command
	echo "SERVICE START"
	service mysql start
	# -D Database to use
	echo "INIT ENV"
	mysql -D mysql < /var/init_env.sql | true
	echo "INIT END"

	echo "##################################################"

	service mysql stop | echo -n ""

	echo "##################################################"

	echo "Creating /var/lib/mysql/.mysqlinstalled"
	touch /var/lib/mysql/.mysqlinstalled
	echo "[+] /var/lib/mysql/.mysqlinstalled"

	echo "##################################################"

	echo "[+] Creating database"
else
	echo "##################################################"
	echo "####        Database already created          ####"
	echo "##################################################"

fi
# https://dev.mysql.com/doc/refman/8.0/en/mysqld-safe.html
echo "Starting Mysql"
exec mysqld_safe