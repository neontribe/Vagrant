#!/bin/bash

NOW=`date +%s`
THEN=`date -r /var/cache/apt +%s`
ELAPSED=$(($NOW - $THEN))
if [ "$ELAPSED" -gt "604800" ]; then # Only do the apt-get update if it's more than a week old
    sudo apt-get update
fi
