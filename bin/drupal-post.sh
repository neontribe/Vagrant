#!/usr/bin/env bash

CWD=`dirname $0`

if [ -z "$DRUPAL_USER" ]; then
    source $CWD/../etc/drupal.inc
fi

if [ -z "$MYSQL_ROOTPASS" ]; then
    source $CWD/../etc/lamp.inc
fi

if [ -d $DRUPAL_TARG ]; then
    echo Resetting permissions

    sudo find $DRUPAL_TARG -type d -exec chmod 775 {} \;
    sudo find $DRUPAL_TARG -type f -exec chmod 664 {} \;

    sudo chown -R vagrant:vagrant $DRUPAL_TARG /home/vagrant/.drushrc

    sudo mv /var/www /var/www.$$
    sudo ln -sf $DRUPAL_TARG /var/www
fi

drush -r $DRUPAL_TARG -y up

if [ "$1" != "SKIP_PASSEORD" ]; then
    # clean up passwd file
    if [ -f $DRUPAL_PASS_FILE ]; then
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        echo -n ">> Drupal Admin Password is "
        cat $DRUPAL_PASS_FILE
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    fi
fi

rm $DRUPAL_PASS_FILE
