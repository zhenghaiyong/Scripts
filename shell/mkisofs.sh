#!/bin/sh
#
# 	This script is a example on how to use mkisofs-CJK. You can even use it
#   to build a Simplified Chinese version of WinPE ISO.
#
#	To use this script, you'd better use the mkisofs-CJK come with CDlinux.
#   You can download it from:
#
#	http://cdlinux.berlios.de/
#
#							-- zxh(imzxh@yahoo.com)

mkisofs -v -R -D -N -l -no-iso-translate -relaxed-filenames \
	-J -joliet-long -jcharset cp936 -ucs-level 3        \
	-V "CDlinux Devel" -A "CDlinux-0.5.3 (2004/03/28)"  \
	-P "Zhao.Home" -p "BenZ@Home"                       \
	-b boot/isolinux/isolinux.bin -c boot/boot.catalog  \
	-no-emul-boot -boot-load-size 4 -boot-info-table    \
	-o /tmp/1.iso .

[ $? -eq 0 ] && exit 0

echo "Hmm, seems you don't have mkisofs-CJK. Let's try plain mkisofs:"
mkisofs -v -R -J -P "Zhao.Home" -p "BenZ@Home"              \
  	-V "CDlinux Devel" -A "CDlinux-0.5.3 (2004/03/28)"  \
	-b boot/isolinux/isolinux.bin -c boot/boot.catalog  \
	-no-emul-boot -boot-load-size 4 -boot-info-table    \
	-o /tmp/1.iso .
