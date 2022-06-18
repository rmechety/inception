
FROM debian:buster

RUN apt update -y && apt install nginx -y && apt install openssl -y

RUN mkdir -p /etc/nginx/ssl/

# https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html
# openssl req [-newkey rsa:bits] [-x509] [-days n] [-nodes] [-out filename] [-keyout filename] [-subj arg]
RUN openssl req -newkey rsa:2048 -x509 -days 365 -nodes -out /etc/nginx/ssl/localhost.crt -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42Paris/OU=rmechety/CN=rmechety/"

COPY ./config/rmechety /etc/nginx/sites-available/default

ENTRYPOINT ["nginx", "-g", "daemon off;"]