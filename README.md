# Lab11

Projekt zawiera konfigurację Docker'a służącą do uruchomienia zestawu aplikacji webowej z użyciem NGINX, PHP, MySQL i phpMyAdmin.

## Usługi

### Web
Usługa `web` jest skonfigurowana do uruchamiania serwera NGINX. Usługa nasłuchuje na porcie `6666` i jest połączona z sieciami `frontend` i `backend`. Wszystkie pliki HTML są przechowywane w folderze `./html` i są montowane do katalogu `/usr/share/nginx/html` w kontenerze. Usługa ta zależy od usługi `php`.

**DOCKERFILE**

FROM nginx:latest

COPY default.conf /etc/nginx/conf.d/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

### PHP
Usługa `php` jest skonfigurowana do uruchamiania interpretera PHP. Wszystkie pliki HTML są montowane do katalogu `/usr/share/nginx/html` w kontenerze. Usługa ta jest połączona tylko z siecią `backend`.

**DOCKERFILE**

FROM php:fpm

WORKDIR /usr/share/nginx/html

EXPOSE 9000
CMD ["php-fpm"]

### DB
Usługa `db` jest skonfigurowana do uruchamiania serwera MySQL. Zmienna `MYSQL_ROOT_PASSWORD` jest ustawiona na `password`, a zmienna `MYSQL_DATABASE` jest ustawiona na `database`. Zmienna `MYSQL_USER` jest ustawiona na `user`, a zmienna `MYSQL_PASSWORD` jest ustawiona na `password`. Dane bazy danych są przechowywane w woluminie `db_data` i są montowane do katalogu `/var/lib/mysql` w kontenerze. Usługa ta jest połączona tylko z siecią `backend`.

**DOCKERFILE**

FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=test
ENV MYSQL_USER=test
ENV MYSQL_PASSWORD=test

COPY setup.sql /docker-entrypoint-initdb.d/

EXPOSE 3306



### phpMyAdmin
Usługa `phpmyadmin` jest skonfigurowana do uruchamiania phpMyAdmin. Obraz dla tej usługi to `phpmyadmin/phpmyadmin:latest`. Usługa nasłuchuje na porcie `6001`. Zmienna `PMA_HOST` jest ustawiona na `db`, zmienna `PMA_USER` jest ustawiona na `admin`, a zmienna `PMA_PASSWORD` jest ustawiona na `admin`. Usługa ta zależy od usługi `db` i jest połączona tylko z siecią `backend`.

## Sieci
Projekt wykorzystuje dwie sieci:
- `frontend`: używana tylko przez usługę `web`.
- `backend`: używana przez wszystkie usługi.

## Woluminy
Projekt wykorzystuje jeden wolumin:
- `db_data`: służy do przechowywania danych bazy MySQL.

## Uruchomienie
Aby uruchomić ten projekt, należy użyć polecenia `docker-compose up`.


