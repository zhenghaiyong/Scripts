#!/bin/sh
#  -*- Sh -*- 
# 
# rebuild_kernel.sh - 
# 
# Copyright (C) 2007 Haiyong Zheng (flyzhy.org@gmail.com).
# 
# Author          : Haiyong Zheng
# Created On      : Tue Nov 13 12:10:56 2007
# Last Modified By: Haiyong Zheng
# Last Modified On: Tue Nov 13 12:14:49 2007
# Update Count    : 3
# 
# HISTORY
# 
KERNEL=kernel-2.6.23.1-flyzhy
CONFIG=config-2.6.23.1-flyzhy
SYSTEMMAP=System.map-2.6.23.1-flyzhy

cd /usr/src/linux && \
make && make modules_install && \
cp -f /usr/src/linux/arch/i386/boot/bzImage /boot/${KERNEL} && \
cp -f /usr/src/linux/System.map /boot/${SYSTEMMAP} && \
cp -f /usr/src/linux/.config /boot/${CONFIG} && \
lilo

# END
