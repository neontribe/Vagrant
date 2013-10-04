#!/usr/bin/env bash

source /vagrant/etc/drupal.inc
source /vagrant/etc/lamp.inc

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

echo Checking $DRUPAL_TARG
if [ ! -d $DRUPAL_TARG ]; then

    echo Installing drupal

    echo "  $DRUPAL_TARG does not exist"

    source /vagrant/etc/drupal.inc

    echo "  Creating user and database"
    dbcheck=`mysql -u root -pvagrant --skip-column-names -s -e "show dataBASES LIKE 'drupal'"`
    if [ -z $dbcheck ]; then
        echo "CREATE DATABASE $DRUPAL_DB_NAME" | mysql -uroot -p$MYSQL_ROOTPASS
    fi

    echo "  Creating user"
    if [ -z $dbcheck ]; then
        echo "CREATE USER '$DRUPAL_DB_USER'@'localhost' IDENTIFIED BY '$DRUPAL_DB_PASS'" | mysql -uroot -p$MYSQL_ROOTPASS
        echo "GRANT ALL ON drupal.* TO '$DRUPAL_USER'@'localhost'" | mysql -uroot -p$MYSQL_ROOTPASS
        echo "flush privileges" | mysql -uroot -p$MYSQL_ROOTPASS
    fi

    echo "Fetching drupal"
    sudo /usr/bin/drush -y dl --destination=`dirname $DRUPAL_TARG`
    sudo mv `dirname $DRUPAL_TARG`/drupal-* $DRUPAL_TARG
    echo "Configuring drupal"
    echo sudo drush -y --root=$DRUPAL_TARG site-install standard \
        --db-url=mysql://$DRUPAL_DB_USER:$DRUPAL_DB_PASS@localhost/$DRUPAL_DB_NAME \
        --site-name="$DRUPAL_SITE_NAME" \
        --account-name=$DRUPAL_ADMIN_NAME \
        --account-pass=$DRUPAL_ADMIN_PASS

    sudo find $DRUPAL_TARG -type d -exec chmod 775 {} \;
    sudo find $DRUPAL_TARG -type f -exec chmod 664 {} \;

    sudo chown -R vagrant:vagrant $DRUPAL_TARG /home/vagrant/.drushrc

    sudo mv /var/www /var/www.$$
    sudo ln -sf $DRUPAL_TARG /var/www
fi
