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
dbcheck=`mysql -u root -pvagrant --skip-column-names -s -e "show DATABASES LIKE '$DRUPAL_DB_NAME'"`
if [ -z $dbcheck ]; then
set -x
    echo "  Creating user and database"
    mysql -uroot -p$MYSQL_ROOTPASS -e "CREATE DATABASE $DRUPAL_DB_NAME"

    echo "  Creating user"
    # Vagrant (double) escapes the quotes in the create user command, so we write out a tempfile and source it.
    TMPFILE=/tmp/createuser.$$
    echo "CREATE USER $DRUPAL_DB_USER@localhost IDENTIFIED BY '$DRUPAL_DB_PASS'" > $TMPFILE
    echo "SOURCE $TMPFILE" | mysql -uroot -p$MYSQL_ROOTPASS
    echo "GRANT ALL ON $DRUPAL_DB_NAME.* TO $DRUPAL_DB_USER@localhost" | mysql -uroot -p$MYSQL_ROOTPASS
    echo "FLUSH PRIVILEGES" | mysql -uroot -p$MYSQL_ROOTPASS
set +x
fi
