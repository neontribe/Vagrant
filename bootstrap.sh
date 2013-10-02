#!/usr/bin/env bash

apt-get update

# Apache, Mysql, PHP and PHPMyAdmin
/vagrant/bin/lamp.sh


# if [ ! -f /var/log/databasesetup ];
# then
    # echo "CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY 'drupalpass'" | mysql -uroot -p$MYSQLROOTPASS
    # echo "CREATE DATABASE drupal" | mysql -uroot -p$MYSQLROOTPASS
    # echo "GRANT ALL ON drupal.* TO 'drupaluser'@'localhost'" | mysql -uroot -p$MYSQLROOTPASS
    # echo "flush privileges" | mysql -uroot -p$MYSQLROOTPASS
 
    # touch /var/log/databasesetup

    # if [ -f /vagrant/data/initial.sql ];
    # then
        # mysql -uroot -prootpass wordpress < /vagrant/data/initial.sql
    # fi
# fi

# sudo a2enmod rewrite
# /etc/init.d/apache2 restart

# ./bin/drupal.sh

# rm -rf /var/www
# ln -fs /vagrant /var/www
