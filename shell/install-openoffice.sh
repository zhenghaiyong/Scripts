#!/bin/bash
# mount -o loop /path/to/OOO-Install.iso /mnt/iso
# mkdir ~/ooo
# cp /mnt/iso/packages/zh-CN/* ~/ooo/
# cd ~/ooo/
for f in `ls *.rpm`; do rpm2targz $f; done
for f in `ls *.rpm`; do rm $f; done
for f in `ls *.tar.gz`; do tar xzf $f; done
for f in `ls *.tar.gz`; do rm $f; done
