#!/usr/bin/env bash

# sudo apt-get update

# Apache, Mysql, PHP and PHPMyAdmin
echo "Install LAMP"
/vagrant/bin/lamp.sh
echo "Install Unix tools"
/vagrant/bin/unixtools.sh
echo "Install drupal"
/vagrant/bin/drupal.sh


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


# rm -rf /var/www
# ln -fs /vagrant /var/www
