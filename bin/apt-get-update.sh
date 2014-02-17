#!/bin/bash

cat >/etc/apt/sources.list << EOL
  deb mirror://mirrors.ubuntu.com/mirrors.txt precise main restricted universe multiverse
  deb mirror://mirrors.ubuntu.com/mirrors.txt precise-updates main restricted universe multiverse
  deb mirror://mirrors.ubuntu.com/mirrors.txt precise-backports main restricted universe multiverse
  deb mirror://mirrors.ubuntu.com/mirrors.txt precise-security main restricted universe multiverse
EOL

NOW=`date +%s`
THEN=`date -r /var/cache/apt +%s`
ELAPSED=$(($NOW - $THEN))
if [ "$ELAPSED" -gt "604800" ]; then # Only do the apt-get update if it's more than a week old
    sudo apt-get update
fi
