#!/usr/bin/env bash

CWD=`dirname $0`

if [ -z "$DRUPAL_USER" ]; then
    source /vagrant/etc/drupal.inc
fi

if [ -z "$MYSQL_ROOTPASS" ]; then
    source $CWD/../etc/lamp.inc
fi

echo Resetting permissions
if [ ! -d $DRUPAL_TARG ]; then

    sudo find $DRUPAL_TARG -type d -exec chmod 775 {} \;
    sudo find $DRUPAL_TARG -type f -exec chmod 664 {} \;

    sudo chown -R vagrant:vagrant $DRUPAL_TARG /home/vagrant/.drushrc

    sudo mv /var/www /var/www.$$
    sudo ln -sf $DRUPAL_TARG /var/www
fi
