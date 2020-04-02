#!/bin/bash

if [[ $EUID -ne 0 ]];
then
    echo "Please run this script as root."
    exit
fi

echo "This script will forcefully overwrite your existing dnsmasq configurations."
read -p "Are you sure you want to continue? [y/N] " warning

if [[ $warning =~ [yY]* ]]
then
    cp -rf etc/* /etc
fi

