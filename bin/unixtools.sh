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
