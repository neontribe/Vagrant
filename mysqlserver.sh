#!/usr/bin/env bash
source config

sudo debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password $MYSQLROOTPASS"
sudo debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password $MYSQLROOTPASS"
sudo apt-get update
sudo apt-get -y install mysql-server-5.5 php5-mysql apache2 php5

if [ ! -f /var/log/databasesetup ];
then
    echo "CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY 'drupalpass'" | mysql -uroot -p$MYSQLROOTPASS
    echo "CREATE DATABASE drupal" | mysql -uroot -p$MYSQLROOTPASS
    echo "GRANT ALL ON drupal.* TO 'drupaluser'@'localhost'" | mysql -uroot -p$MYSQLROOTPASS
    echo "flush privileges" | mysql -uroot -p$MYSQLROOTPASS

    touch /var/log/databasesetup

    if [ -f /vagrant/data/initial.sql ];
    then
        mysql -uroot -prootpass wordpress < /vagrant/data/initial.sql
    fi
fi
