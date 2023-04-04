#!/bin/bash
#https://ubuntu.com/tutorials/install-and-configure-wordpress

#Install Dependencies
sudo apt update
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip -y

#Install WordPress
sudo mkdir -p /srv/www #Create dir for wordpress, skip error if exist
sudo chown www-data: /srv/www #make user www-data as owner of folder, in buisness everioment, every instace of wordpress should have separate user and other permissions
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www #Download latest version of wordpress and extract it to /srv/www 

#Configure Apache for WordPress
echo '<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>' > wordpress.conf #Create standard wordpress config
sudo cp -rf wordpress.conf /etc/apache2/sites-available/wordpress.conf #copy and replace if any exist
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload #Enable site, rewrite, Disable default site and reload apache2

#Configure database
sudo mysql -u root -e 'CREATE DATABASE wordpress;'
sudo mysql -u root -e 'CREATE USER wordpress@localhost IDENTIFIED BY "admin123";'
sudo mysql -u root -e 'GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;'
sudo mysql -u root -e 'FLUSH PRIVILEGES;'
#Createing Database, user and giving him permisions
sudo service mysql start

#Configure WordPress to connect to the database
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/admin123/' /srv/www/wordpress/wp-config.php

sudo service mysql restart






