#!/bin/bash

rm -rf /var/www/html/*
#echo "<?php phpinfo(); ?>" > /var/www/html/index.php
sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.0/apache2/php.ini
sed -i "s/max_execution_time = 30/max_execution_time = 0/" /etc/php/7.0/apache2/php.ini
sed -i 's/^error_reporting = .*/error_reporting = E_WARNING \& ~E_NOTICE \& ~E_DEPRECATED \& ~E_STRICT/' /etc/php/7.0/apache2/php.ini
sed -i "s/log_errors = On/log_errors = Off/" /etc/php/7.0/apache2/php.ini
sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini

sed -i '13 a <Directory /var/www/html>' /etc/apache2/sites-available/000-default.conf
sed -i '14 a Options Indexes FollowSymLinks MultiViews' /etc/apache2/sites-available/000-default.conf
sed -i '15 a AllowOverride All' /etc/apache2/sites-available/000-default.conf
sed -i '16 a Require all granted' /etc/apache2/sites-available/000-default.conf
sed -i '17 a </Directory>' /etc/apache2/sites-available/000-default.conf
