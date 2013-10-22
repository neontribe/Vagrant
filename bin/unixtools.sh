#!/bin/bash

which vim > /dev/null
if [ 1 == "$?" ]; then
    echo Installing vim
    sudo apt-get install -y vim
fi

which screen > /dev/null
if [ 1 == "$?" ]; then
    echo Installing screen
    sudo apt-get install -y screen
fi

which ccze > /dev/null
if [ 1 == "$?" ]; then
    echo Installing ccze
    sudo apt-get install -y ccze
fi

if [ ! -f /etc/dictionaries-common/words ]; then
    echo Installing ispell to pull in wordlists
    sudo apt-get install -y wbritish-small
    sudo /usr/share/debconf/fix_db.pl > /dev/null
    sudo apt-get install -y wbritish-small
fi

which git > /dev/null
if [ 1 == "$?" ]; then
    echo Installing screen
    sudo apt-get install -y git git-flow
fi

which setfacl > /dev/null
if [ 1 == "$?" ]; then
    echo Installing acl
    sudo apt-get install -y acl
fi
