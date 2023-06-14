FROM php:fpm

WORKDIR /usr/share/nginx/html

EXPOSE 9000
CMD ["php-fpm"]