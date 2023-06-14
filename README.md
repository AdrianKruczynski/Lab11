# Projekt Docker

Projekt zawiera konfigurację Docker'a służącą do uruchomienia zestawu aplikacji webowej z użyciem NGINX, PHP, MySQL i phpMyAdmin.

## Usługi

### Web
Usługa `web` jest skonfigurowana do uruchamiania serwera NGINX. Dockerfile dla tej usługi znajduje się w folderze `./nginx`. Usługa nasłuchuje na porcie `6666` i jest połączona z sieciami `frontend` i `backend`. Wszystkie pliki HTML są przechowywane w folderze `./html` i są montowane do katalogu `/usr/share/nginx/html` w kontenerze. Usługa ta zależy od usługi `php`.

### PHP
Usługa `php` jest skonfigurowana do uruchamiania interpretera PHP. Dockerfile dla tej usługi znajduje się w folderze `./php`. Wszystkie pliki HTML są montowane do katalogu `/usr/share/nginx/html` w kontenerze. Usługa ta jest połączona tylko z siecią `backend`.

### DB
Usługa `db` jest skonfigurowana do uruchamiania serwera MySQL. Dockerfile dla tej usługi znajduje się w folderze `./mysql`. Zmienna `MYSQL_ROOT_PASSWORD` jest ustawiona na `password`, a zmienna `MYSQL_DATABASE` jest ustawiona na `database`. Zmienna `MYSQL_USER` jest ustawiona na `user`, a zmienna `MYSQL_PASSWORD` jest ustawiona na `password`. Dane bazy danych są przechowywane w woluminie `db_data` i są montowane do katalogu `/var/lib/mysql` w kontenerze. Usługa ta jest połączona tylko z siecią `backend`.

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


