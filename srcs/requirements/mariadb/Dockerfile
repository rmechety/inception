FROM debian:buster

# gettext for envsubst

RUN apt update -y && apt install mariadb-server mariadb-client gettext-base -y

COPY ./config/server.cnf /etc/mysql/mariadb.conf.d/server.cnf
COPY ./config/mariadb_install.sh /var/.
COPY ./config/init.sql /var/.

CMD ["sh", "/var/mariadb_install.sh" ]