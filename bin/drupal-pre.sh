#!/usr/bin/env bash

CWD=`dirname $0`

if [ -z "$DRUPAL_USER" ]; then
    source $CWD/../etc/drupal.inc
fi

if [ -z "$MYSQL_ROOTPASS" ]; then
    source $CWD/../etc/lamp.inc
fi

if [ ! -f /usr/bin/pear ]; then

    echo Installing pear

    sudo apt-get install -y php-pear

fi

if [ ! -f /usr/bin/drush ]; then

    echo Installing drush

    sudo pear channel-discover pear.drush.org
    sudo pear install drush/drush
    sudo drush > /dev/null

fi

echo Checking checking for drupal database
dbcheck=`mysql -u root -pvagrant --skip-column-names -s -e "show dataBASES LIKE 'drupal'"`
if [ -z $dbcheck ]; then

    echo "  Creating user and database"
        echo "CREATE DATABASE $DRUPAL_DB_NAME" | mysql -uroot -p$MYSQL_ROOTPASS
    fi

    echo "  Creating user"
    echo "CREATE USER '$DRUPAL_DB_USER'@'localhost' IDENTIFIED BY '$DRUPAL_DB_PASS'" | mysql -uroot -p$MYSQL_ROOTPASS
    echo "GRANT ALL ON drupal.* TO '$DRUPAL_USER'@'localhost'" | mysql -uroot -p$MYSQL_ROOTPASS
    echo "flush privileges" | mysql -uroot -p$MYSQL_ROOTPASS
fi
