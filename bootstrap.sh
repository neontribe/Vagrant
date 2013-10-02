#!/usr/bin/env bash

apt-get update

# If phpmyadmin does not exist
if [ ! -f /etc/phpmyadmin/config.inc.php ];
then

	# Used debconf-get-selections to find out what questions will be asked
	# This command needs debconf-utils

	# Handy for debugging. clear answers phpmyadmin: echo PURGE | debconf-communicate phpmyadmin

	echo 'phpmyadmin phpmyadmin/dbconfig-install boolean false' | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

	echo 'phpmyadmin phpmyadmin/app-password-confirm password vagrant' | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/mysql/admin-pass password vagrant' | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/password-confirm password vagrant' | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/setup-password password vagrant' | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/database-type select mysql' | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/mysql/app-pass password vagrant' | debconf-set-selections

	echo 'dbconfig-common dbconfig-common/mysql/app-pass password vagrant' | debconf-set-selections
	echo 'dbconfig-common dbconfig-common/mysql/app-pass password' | debconf-set-selections
	echo 'dbconfig-common dbconfig-common/password-confirm password vagrant' | debconf-set-selections
	echo 'dbconfig-common dbconfig-common/app-password-confirm password vagrant' | debconf-set-selections
	echo 'dbconfig-common dbconfig-common/app-password-confirm password vagrant' | debconf-set-selections
	echo 'dbconfig-common dbconfig-common/password-confirm password vagrant' | debconf-set-selections
	
	apt-get -y install phpmyadmin
fi

# do mysql setup
echo mysqlserver.sh

#setup everything else
apt-get install -y apache2 php-pear

sudo a2enmod rewrite
/etc/init.d/apache2 restart

pear channel-discover pear.drush.org
pear install drush/drush
drush > /dev/null

rm -rf /var/www
ln -fs /vagrant /var/www