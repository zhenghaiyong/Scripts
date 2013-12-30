#!/bin/sh
#  -*- Sh -*- 
# 
# change_inet1_link.sh - change the link of /etc/rc.d/rc.inet1.conf.
# 
# Copyright (C) 2007 Haiyong Zheng (flyzhy.org@gmail.com).
# 
# Author          : Haiyong Zheng
# Created On      : Thu Nov 15 13:12:55 2007
# Last Modified By: Haiyong Zheng
# Last Modified On: Sat Nov 17 15:10:45 2007
# Update Count    : 11
# 
# HISTORY
# 
case $1 in
    dhcp)
	sudo ln -sf /etc/rc.d/rc.inet1.conf.dhcp /etc/rc.d/rc.inet1.conf
	;;
    home)
	sudo ln -sf /etc/rc.d/rc.inet1.conf.home /etc/rc.d/rc.inet1.conf
	;;
    qdmedia)
	sudo ln -sf /etc/rc.d/rc.inet1.conf.qdmedia /etc/rc.d/rc.inet1.conf
	;;
    ipl)
        sudo ln -sf /etc/rc.d/rc.inet1.conf.ipl /etc/rc.d/rc.inet1.conf
	sudo cp -f /etc/resolv.conf.work /etc/resolv.conf
	;;
    newstar)
	sudo ln -sf /etc/rc.d/rc.inet1.conf.newstar /etc/rc.d/rc.inet1.conf
	sudo cp -f /etc/resolv.conf.work /etc/resolv.conf
	;;
    *)
	echo -ne "Usage:\n"
	echo -ne "\t$0 dhcp|home|ipl|newstar\n"
	;;
esac
ls -l /etc/rc.d/rc.inet1.conf
