#!/bin/bash

if [ -z "$MYSQL_ROOTPASS" ]; then
    source /vagrant/etc/lamp.inc
fi

# MYSQL Server
if [ ! -f /etc/mysql/my.cnf ]; then

    echo Installing mysql

    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOTPASS"
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOTPASS"
    sudo apt-get -y install mysql-server mysql-client

else

    echo Mysql already installed

fi

# Apache
if [ ! -d /etc/apache2 ]; then

    echo Installing apache

    sudo apt-get -y install apache2

    # stop apache
    /etc/init.d/apache2 stop

    # Set up apache to run as vagrant:vagrant
    sed -i -e 's/www-data/vagrant/g' /etc/apache2/envvars

    # Turn allow override/rewrite on
    sed -i -r -e \
        '/Directory \/var\/www\// { n ; n ; s/AllowOverride None/AllowOverride All/ }' \
        /etc/apache2/sites-available/default
    a2enmod rewrite

    # reset ownership of apache
    chown vagrant:vagrant /var/lock/apache2

    # This is a security risk.  It should only ever be used on dev boxes
    echo 'umask 002' >> /etc/apache2/envvars

    /etc/init.d/apache2 start

else

    echo Apache already installed

fi

# PHP
if [ ! -d /etc/php5 ]; then

    echo Installing PHP

    sudo apt-get -y install php5-mysql php5 php5-curl php-pear php5-cli curl php5-sqlite php5-xdebug php-apc libapache2-mod-php5

else

    echo PHP already installed

fi

# PHP My Admin
if [ ! -f /etc/phpmyadmin/config.inc.php ]; then

    echo Installing phpmyadmin

	# Used debconf-get-selections to find out what questions will be asked
	# This command needs debconf-utils

	# Handy for debugging. clear answers phpmyadmin: echo PURGE | debconf-communicate phpmyadmin

	echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

	echo "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/password-confirm password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/setup-password password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/database-type select mysql" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOTPASS" | debconf-set-selections

	echo "dbconfig-common dbconfig-common/mysql/app-pass password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "dbconfig-common dbconfig-common/password-confirm password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "dbconfig-common dbconfig-common/app-password-confirm password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "dbconfig-common dbconfig-common/app-password-confirm password $MYSQL_ROOTPASS" | debconf-set-selections
	echo "dbconfig-common dbconfig-common/password-confirm password $MYSQL_ROOTPASS" | debconf-set-selections
	
	apt-get -y install phpmyadmin

else

    echo PHPMyAdmin already installed

fi

