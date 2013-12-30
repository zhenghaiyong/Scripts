#!/bin/bash
# cron
# backup-config-files.sh
# backup all the configuration files for my GNU/Linux (slackware 10.2)
# by Haiyong Zheng
# website: http://www.flyzhy.org
#
####################
# change directory #
###################
cd /home/flyzhy/backup/config/
#----------------------------------------------------------#
#################
# set variables #
#################
destdir=ConfigFiles
HOME=/home/flyzhy
#----------------------------------------------------------#
##################
# make directory #
##################
# set up the stucture for GNU/Linux
# /boot
mkdir -p ${destdir}/boot
# /etc/X11
mkdir -p ${destdir}/etc/X11
# /etc/fonts
mkdir -p ${destdir}/etc/fonts
# /etc/gtk
mkdir -p ${destdir}/etc/gtk
# /etc/gtk-2.0
mkdir -p ${destdir}/etc/gtk-2.0
# /etc/profile.d
mkdir -p ${destdir}/etc/profile.d
# ${HOME}
mkdir -p ${destdir}${HOME}
#----------------------------------------------------------#
########
# copy #
########
# /boot/
cp /boot/lilo.bmp ${destdir}/boot/
cp /boot/config-2.6.15 ${destdir}/boot/
cp /boot/System.map-2.6.15 ${destdir}/boot/
cp /boot/kernel-2.6.15 ${destdir}/boot/
cp /boot/initrd-800x600-dragon ${destdir}/boot/
cp /boot/vmlinuz-2.6.15 ${destdir}/boot/
# /etc/X11/
cp /etc/X11/xorg.conf ${destdir}/etc/X11/
# /etc/fonts/
cp /etc/fonts/fonts.conf ${destdir}/etc/fonts/
cp /etc/fonts/fonts.dtd ${destdir}/etc/fonts/
# /etc/gtk/
cp /etc/gtk/gtkrc.zh_CN ${destdir}/etc/gtk/
# /etc/gtk-2.0/
cp /etc/gtk-2.0/gtkrc ${destdir}/etc/gtk-2.0/
# /etc/profile.d/
cp /etc/profile.d/lang.sh ${destdir}/etc/profile.d/
# /etc/rc.d/
cp -rf /etc/rc.d ${destdir}/etc/
# /etc/bk2site/
cp -rf /etc/bk2site ${destdir}/etc/
# /etc/squid/
cp -rf /etc/squid ${destdir}/etc/
# /etc/
# global
cp /etc/inittab ${destdir}/etc/
cp /etc/lilo.conf ${destdir}/etc/
cp /etc/fstab ${destdir}/etc/
cp /etc/inetd.conf ${destdir}/etc/
cp /etc/profile ${destdir}/etc/
cp /etc/inputrc ${destdir}/etc/
cp /etc/modules.conf ${destdir}/etc/
cp /etc/modprobe.conf ${destdir}/etc/
cp /etc/ld.so.conf ${destdir}/etc/
#sudo cp /etc/sudoers ${destdir}/etc/
# programs
cp /etc/lftp.conf ${destdir}/etc/
cp /etc/xpdfrc ${destdir}/etc/
cp /etc/wgetrc ${destdir}/etc/
cp /etc/vsftpd.conf ${destdir}/etc/
cp /etc/dict.conf ${destdir}/etc/
cp /etc/dict.conf.sample ${destdir}/etc/
cp /etc/dictd.conf ${destdir}/etc/
cp /etc/dictd.conf.sample ${destdir}/etc/
# ${HOME}/Emacs/
cp ${HOME}/.emacs ${destdir}${HOME}/
cp -rf ${HOME}/Emacs ${destdir}${HOME}/
# ${HOME}/.fvwm/
cp -rf ${HOME}/.fvwm ${destdir}${HOME}/
# ${HOME}/Matlab/
cp -rf ${HOME}/Matlab ${destdir}${HOME}/
# ${HOME}/.torsmos/
cp ${HOME}/.torsmorc ${destdir}${HOME}/
cp -rf ${HOME}/.torsmos ${destdir}${HOME}/
# ${HOME}/.mutt/
cp ${HOME}/.fetchmailrc ${destdir}${HOME}/
cp ${HOME}/.esmtprc ${destdir}${HOME}/
cp -rf ${HOME}/.mutt ${destdir}${HOME}/
cp -rf ${HOME}/.certs ${destdir}${HOME}/
# ${HOME}/scripts/
cp -rf ${HOME}/scripts ${destdir}${HOME}/
# ${HOME}/.gftp/
mkdir -p ${destdir}${HOME}/.gftp
cp ${HOME}/.gftp/bookmarks ${destdir}${HOME}/.gftp/
cp ${HOME}/.gftp/gftprc ${destdir}${HOME}/.gftp/
# ${HOME}/.fonts/
cp -rf ${HOME}/.fonts ${destdir}${HOME}/
# ${HOME}/.mlterm/
cp -rf ${HOME}/.mlterm ${destdir}${HOME}/
# ${HOME}/.texmf-var/
cp -rf ${HOME}/.texmf-var ${destdir}${HOME}/
# ${HOME}/.texmf-config/
cp -rf ${HOME}/.texmf-config ${destdir}${HOME}/
# ${HOME}/
cp ${HOME}/.bash_profile ${destdir}${HOME}/
cp ${HOME}/.bashrc ${destdir}${HOME}/
cp ${HOME}/.inputrc ${destdir}${HOME}/
cp ${HOME}/.xinitrc ${destdir}${HOME}/
cp ${HOME}/.Xresources ${destdir}${HOME}/
cp ${HOME}/.vimrc ${destdir}${HOME}/
cp ${HOME}/.xpdfrc ${destdir}${HOME}/
cp ${HOME}/.lftprc ${destdir}${HOME}/
cp ${HOME}/.bk2siterc ${destdir}${HOME}/
#----------------------------------------------------------#
############
# compress #
############
tar cjvf ${destdir}-`date +%Y%m%d`.tar.bz2 ${destdir}
if [ $? -ne 0 ]; then
    echo -ne "tar error while compressing ...\n"
    exit 2
fi
#----------------------------------------------------------#
################
# delete older #
################
# delete 2 days older backup
find . -name "ConfigFiles*.tar.bz2" -mtime +2 -exec rm {} \;
#----------------------------------------------------------#
# End
