#!/bin/sh
# This is a simple script for preparing POS 
# executing on board.
# Author: Haiyong Zheng
# E-mail: flyzhy.org@yahoo.com.cn
# For my best lover: fly
# PosBoard.sh

echo "   Welcome to POS Terminal System"
echo "      executing on Board"
echo 
# Set up Local Variables
BIN="lcd"
DevU="/dev/sda1"
MountU="/mnt"
DevMTD="/dev/mtdblock0"
MountMTD="/tmp/store"
DataBaseFile="Hzk16s"
#
#
#
# Step 1.
echo "Step 1: U-Disk Operation"
echo
# Ask for whether you have inserted the U-Disk or not.
echo "whether you have inserted U-Disk or not?"
cat << END
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++ Mounting U-Disk  ++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Y : Yes, I have inserted my U-Disk.
N : No, I am unhappy to do this, I want to quit now.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END
echo "Your Choice[Y,N]>"
read CHOICE
case $CHOICE in
    Y|y) 
	echo "OK, We will mount U-Disk."
	;;
    N|n) 
	echo "Fine, see you!"
	exit 0
	;;
esac
echo 
# Checking and Mounting now.
echo "Checking and Mounting atuomatically now ..."
echo
mount -t vfat ${DevU} ${MountU}
echo "Displaying U-Disk ..."
ls -l ${MountU}
echo
# Copying lcd now
echo "Copying lcd now ..."
echo
cp ${MountU}/${BIN} /tmp/
chmod +x /tmp/${BIN}
echo
# Unmounting now.
echo "Unmounting now ..."
umount ${MountU}
echo
# Step 2.
echo "Step 2: MTD Operation"
echo
echo "Creating mount point ..."
mkdir -p ${MountMTD}
echo "Mounting mtdblock0 ..."
mount -t yaffs ${DevMTD} ${MountMTD}
echo "Copying DataBase file ..."
cp ${MountMTD}/${DataBaseFile} /tmp/
echo
# Step 3.
echo "Step 3: Running Program ..."
/tmp/${BIN}
# End.
