#!/usr/bin/env bash

if [ ! -f /usr/bin/pear ]; then

    apt-get install -y php-pear

fi

if [ ! -f /usr/bin/drush ]; then

    pear channel-discover pear.drush.org
    drush > /dev/null

fi

if [ ! -d /home/vagrant/drupal ]; then

    /usr/bin/drush dl --destination /home/vagrant/drupal
    drush site-install standard --db-url=mysql://vagrant:vagrant@localhost/vagrant --site-name=Vagrant --account-name=superadmin --account-pass=b191wkm

fi
