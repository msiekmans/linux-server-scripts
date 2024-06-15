#!/bin/bash

#install git, webserver, php etc.
apt update
apt install git -y
apt install apache2 -y
apt install php libapache2-mod-php -y
apt install php-{gd,imap,xml,json,mbstring,mysql,intl,apcu,zip} -y

#install and setup osTicket
#for ubuntu 22.04 and higher
mkdir osticket
cd osticket
git clone https://github.com/osTicket/osTicket
cd osTicket
php manage.php deploy --setup /var/www/html/osticket

cd /var/www/html/osticket/include
cp ost-sampleconfig.php ost-config.php
chmod 0666 ost-config.php
cd ~

#enable user websites
mkdir -p -v /etc/skel/public_html
a2enmod userdir
echo "Restarting apache2 webserver..."
systemctl restart apache2
