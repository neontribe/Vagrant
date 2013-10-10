#!/usr/bin/env bash

CWD=`dirname $0`

if [ -z "$DRUPAL_USER" ]; then
    source /vagrant/etc/drupal.inc
fi

if [ -z "$MYSQL_ROOTPASS" ]; then
    source $CWD/../etc/lamp.inc
fi

if [ -z "$MYSQL_ROOTPASS" ]; then
    source $CWD/../etc/drupal.inc
fi

echo Checking $DRUPAL_TARG
if [ ! -d $DRUPAL_TARG ]; then

    echo Installing drupal

    echo "  $DRUPAL_TARG does not exist"

    echo "Fetching drupal"
    sudo /usr/bin/drush -y dl --destination=`dirname $DRUPAL_TARG`
    sudo mv `dirname $DRUPAL_TARG`/drupal-* $DRUPAL_TARG
    echo "Configuring drupal"
    echo sudo drush -y --root=$DRUPAL_TARG site-install standard \
        --db-url=mysql://$DRUPAL_DB_USER:$DRUPAL_DB_PASS@localhost/$DRUPAL_DB_NAME \
        --site-name="$DRUPAL_SITE_NAME" \
        --account-name=$DRUPAL_ADMIN_NAME \
        --account-pass=$DRUPAL_ADMIN_PASS
fi
