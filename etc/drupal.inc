#!/bin/bash

export DRUPAL_USER=superadmin
export DRUPAL_DB_USER=drupal
export DRUPAL_DB_PASS=drupal
export DRUPAL_DB_NAME=drupal
export DRUPAL_SITE_NAME="Vagrant Drupal"
export DRUPAL_ADMIN_NAME=superadmin
export DRUPAL_TARG=/vagrant/drupal
export DRUPAL_PASS_FILE=$HOME/.drupal_admin_password

if [ "$DRUPAL_ADMIN_PASS" == "" ]; then
    if [ -f $DRUPAL_PASS_FILE ]; then
        export DRUPAL_ADMIN_PASS=`cat $DRUPAL_PASS_FILE`
    else
        DRUPAL_ADMIN_PASS=$(cat /usr/share/dict/words |grep -v "'"|shuf -n1 | tr '[A-Z]' '[a-z]')
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        echo ">> Drupal Admin Password is $DRUPAL_ADMIN_PASS"
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        echo $DRUPAL_ADMIN_PASS>$DRUPAL_PASS_FILE
        export DRUPAL_ADMIN_PASS
    fi
fi

echo ** $DRUPAL_ADMIN_PASS
