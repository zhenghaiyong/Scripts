#!/bin/bash
# This is a simple script for preparing POS 
# executing on board.
# Author: Haiyong Zheng
# E-mail: flyzhy.org@yahoo.com.cn
# For my best lover: fly
# PosBoard.sh

echo -ne "\t\t Welcome to \\033[0;32mPOS\\033[0;39m Terminal System\n"
echo -ne "\t\t\t executing on \\033[0;32mBoard\\033[0;39m\n"
echo 
# Set up Local Variables
BIN="lcd"
DevMTD="/dev/mtdblock0"
MountU="/mnt"
DataBaseFile="Hzk16s"
#
#
#
# Step 1.
echo -ne "\\033[0;31mStep 1\\033[0;39m: \\033[0;32mU-Disk\\033[0;39m Operation\n"
echo
# Ask for whether you have inserted the U-Disk or not.
echo -ne "\t\\033[0;36mwhether you have inserted U-Disk or not?\\033[0;39m\n"
cat << END
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++ Mounting U-Disk  +++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Y : Yes, I have inserted my U-Disk.
N : No, I am unhappy to do this, I want to quit now.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END
echo -ne "\t\\033[0;32mYour Choice[Y,N]>\\033[0;39m"
read CHOICE
case $CHOICE in
    Y|y) 
	echo -ne "OK, We will mount U-Disk.\n"
	;;
    N|n) 
	echo -ne "Fine, see you!\n"
	exit 0
	;;
esac
echo 
# Checking and Mounting now.
echo -ne "Checking and Mounting atuomatically now ...\n"
echo
fdisk -l
if [ $? -gt 0 ]; then
    echo -ne "Permission denied. Check if you are \\033[0;37mroot\\033[0;39m!\n"
    exit 1
else
    DevU=`fdisk -l|grep '^/dev/sd'|awk '{print $1}'`
    echo -ne "Creating mount point ...\n"
    mount -t vfat ${DevU} ${MountU}
    echo -ne "Displaying U-Disk ...\n"
    ls -l ${MountU}
fi
echo
# Copying lcd and PosBoard.sh now
echo -ne "Copying \\033[0;32mlcd\\033[0;39m and \\033[0;32mPosBoard.sh\\033[0;39m now ...\n"
echo
cp ${MountU}/${BIN} /tmp/
chmod +x /tmp/${BIN}
echo
# Unmounting now.
echo -ne "Unmounting now ...\n"
umount ${MountU}
echo
# Step 2.
echo -ne "\\033[0;31mStep 2\\033[0;39m: \\033[0;32mMTD\\033[0;39m Operation\n"
echo
echo -ne "Creating mount point ...\n"
MountMTD="/tmp/store"
mkdir -p ${MountMTD}
echo -ne "Mounting mtdblock0 ...\n"
mount -t vfat ${DevMTD} ${MountMTD}
echo -ne "Copying DataBase file ...\n"
cp ${MountMTD}/${DataBaseFile} /tmp/
echo
# Step 3.
echo -ne "\\033[0;31mStep 3\\033[0;39m: \\033[0;32mRUN\\033[0;39m Program\n"
/tmp/${BIN}
# End.
