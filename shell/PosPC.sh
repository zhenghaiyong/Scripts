#!/bin/bash
# This is a simple script for preparing POS 
# executing on PC.
# Author: Haiyong Zheng
# E-mail: flyzhy.org@yahoo.com.cn
# For my best lover: fly
# PosPC.sh

echo -ne "\t\t Welcome to \\033[0;35mPOS\\033[0;39m Terminal System\n"
echo -ne "\t\t\t executing on \\033[0;35mPC\\033[0;39m\n"
echo 
echo
echo
# SetUp Local Variables
BIN="lcd"
#
#
#
# Step 1.
echo -ne "\\033[0;31mStep 1\\033[0;39m: Compiling program --- \\033[0;32mlcd\\033[0;39m\n"
echo
cat << END
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++ Compiling Souce Code +++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END
# Ask for the location of souce code
echo -ne "\t\\033[0;36mthe absolute path to your souce code:\\033[0;39m"
read SourceCodePath
echo
echo ${SourceCodePath}|grep '/$' && SourceCodePath=${SourceCodePath%/}
echo
cd ${SourceCodePath}
make
if [ $? -gt 0 ]; then
    echo -ne "Permission denied. Check if you are \\033[0;37mroot\\033[0;39m!\n"
    exit 1
else
    echo -ne "Compile done successfully!\n"
fi
chmod +x ${SourceCodePath}/${BIN}
echo
# Step 2.
echo -ne "\\033[0;31mStep 2\\033[0;39m: \\033[0;32mU-Disk\\033[0;39m Operation\n"
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
fdisk -l | grep '^/dev/sd'
if [ $? -gt 0 ]; then
    echo -ne "Permission denied. Check if you are \\033[0;37mroot\\033[0;39m!\n"
    echo -ne "Or\n"
    echo -ne "You have no U-Disk inserted. Please check the USB port now.\n"
    exit 1
else
    DevU=`fdisk -l|grep '^/dev/sd'|awk '{print $1}'`
    echo -ne "Creating mount point ...\n"
    MountU="/mnt/USB"
    mkdir -p ${MountU}
    mount -t vfat ${DevU} ${MountU}
    echo -ne "Displaying U-Disk ...\n"
    ls -l ${MountU}
fi
echo
# Copying lcd and PosBoard.sh now
echo -ne "Copying \\033[0;32mlcd\\033[0;39m and \\033[0;32mPosBoard.sh\\033[0;39m now ...\n"
echo
cp ${SourceCodePath}/${BIN} ${MountU}
if [ -f ${MountU}/PosBoard.sh ]; then
    chmod +x ${MountU}/PosBoard.sh
else
    if [ -f ${HOME}/PosBoard.sh ]; then
	chmod +x ${HOME}/PosBoard.sh
	cp ${HOME}/PosBoard.sh ${MountU}
    else
	echo -ne "Make sure the file \\033[0;32mPosBoard.sh\\033[0;39m is in your $HOME!"
	exit 0
    fi
fi
echo
# Unmounting now.
echo -ne "Unmounting now ...\n"
umount ${MountU}
echo
# Step 3.
echo -ne "\\033[0;31mStep 2\\033[0;39m: \\033[0;32mMinicom\\033[0;39m Communication\n"
echo
# Ask for whether you are ready to communicate.
echo -ne "\t\\033[0;36mwheter you are ready to communicate or not?\\033[0;39m"
cat << END
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++ Are You Ready?  ++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Y : Yes, the board is ready.
N : No, the board is not ready, quit now.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END
echo -ne "\t\\033[0;32mYour Choice[Y,N]>\\033[0;39m"
read READY
case $READY in
    Y|y) 
	echo -ne "OK, We will set up the communication.\n"
	;;
    N|n) 
	echo -ne "Fine, see you!\n"
	exit 0
	;;
esac
minicom
# End.
