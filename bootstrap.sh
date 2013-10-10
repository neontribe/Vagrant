#!/usr/bin/env bash

CWD=`dirname $0`

NOW=`date +%s`
THEN=`date -r /var/cache/apt +%s`
ELAPSED=$(($NOW - $THEN))
if [ "$ELAPSED" -gt "604800" ]; then # Only do the apt-get update if it's more than a week old
    sudo apt-get update
fi

# Apache, Mysql, PHP and PHPMyAdmin
echo "Install LAMP"
$CWD/bin/lamp.sh
echo "Install Unix tools"
$CWD/bin/unixtools.sh
echo "Install drupal"
$CWD/bin/drupal-pre.sh
$CWD/bin/drupal.sh
$CWD/bin/drupal-post.sh


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
