#!/bin/bash
# backup.sh
# backup all the configuration files for my GNU/Linux
# written by Haiyong Zheng
# website: http://www.flyzhy.org
# email: zhenghaiyong@gmail.com
#
# Usage: backup.sh destidir
#
echo -ne "Usage: $0 destidir\n"
echo

if [ $# -ne 1 ]; then
    echo -ne "Usage: $0 destidir\n"
    exit 1
fi

# test $1=destdir or destdir/
# to make sure $1=destdir


# set up the stucture for GNU/Linux
#
# /boot
mkdir -p ${1}/boot
# /etc/X11
mkdir -p ${1}/etc/X11
# /etc/fonts
mkdir -p ${1}/etc/fonts
# /etc/gtk
mkdir -p ${1}/etc/gtk
# /etc/gtk-2.0
mkdir -p ${1}/etc/gtk-2.0
# /etc/profile.d
mkdir -p ${1}/etc/profile.d
# $HOME
mkdir -p ${1}$HOME
#
echo -ne " successfully made directory:\n"
echo -ne "      ${1}/boot\n"
echo -ne "      ${1}/etc/X11\n"
echo -ne "      ${1}/etc/fonts\n"
echo -ne "      ${1}/etc/gtk\n"
echo -ne "      ${1}/etc/gtk-2.0\n"
echo -ne "      ${1}/etc/profile.d\n"
echo -ne "      ${1}$HOME\n"            
echo
echo
echo
# copy
echo -ne "now getting start the real copy work ...\n"
# /boot/
cp /boot/lilo.bmp ${1}/boot/
cp /boot/config-2.6.15 ${1}/boot/
cp /boot/System.map-2.6.15 ${1}/boot/
cp /boot/kernel-2.6.15 ${1}/boot/
cp /boot/initrd-800x600-dragon ${1}/boot/
cp /boot/vmlinuz-2.6.15 ${1}/boot/
echo -ne "###               files in /boot/:                   ###\n"
echo -ne "#   lilo.bmp config System.map kernel initrd vmlinuz   #\n"
echo
# /etc/X11/
cp /etc/X11/xorg.conf ${1}/etc/X11/
echo -ne "###               files in /etc/X11/                 ###\n"
echo -ne "#                      xorg.conf                       #\n"
echo
# /etc/fonts/
cp /etc/fonts/fonts.conf ${1}/etc/fonts/
cp /etc/fonts/fonts.dtd ${1}/etc/fonts/
echo -ne "###               files in /etc/fonts/               ###\n"
echo -ne "#                 fonts.conf fonts.dtd                 #\n"
echo
# /etc/gtk/
cp /etc/gtk/gtkrc.zh_CN ${1}/etc/gtk/
echo -ne "###               files in /etc/gtk/                 ###\n"
echo -ne "#                    gtkrc.zh_CN                       #\n"
echo
# /etc/gtk-2.0/
cp /etc/gtk-2.0/gtkrc ${1}/etc/gtk-2.0/
echo -ne "###               files in /etc/gtk-2.0/             ###\n"
echo -ne "#                       gtkrc                          #\n"
echo
# /etc/profile.d/
cp /etc/profile.d/lang.sh ${1}/etc/profile.d/
echo -ne "###               files in /etc/profile.d/           ###\n"
echo -ne "#                      lang.sh                         #\n"
echo
# /etc/rc.d/
cp -rf /etc/rc.d ${1}/etc/
echo -ne "###                  /etc/rc.d/                      ###\n"
echo 
# /etc/bk2site/
cp -rf /etc/bk2site ${1}/etc/
echo -ne "###                  /etc/bk2site/                   ###\n"
echo
# /etc/
# global
cp /etc/inittab ${1}/etc/
cp /etc/lilo.conf ${1}/etc/
cp /etc/fstab ${1}/etc/
cp /etc/profile ${1}/etc/
cp /etc/inputrc ${1}/etc/
cp /etc/modules.conf ${1}/etc/
cp /etc/modprobe.conf ${1}/etc/
cp /etc/ld.so.conf ${1}/etc/
#sudo cp /etc/sudoers ${1}/etc/
echo -ne "###               global files in /etc/              ###\n"
echo -ne "# inittab lilo.conf fstab profile inputrc modules.conf #\n"
echo -ne "#               modprobe.conf ld.so.conf               #\n"
#echo -ne "#                        sudoers                       #\n"
# programs
cp /etc/lftp.conf ${1}/etc/
cp /etc/xpdfrc ${1}/etc/
cp /etc/wgetrc ${1}/etc/
cp /etc/vsftpd.conf ${1}/etc/
cp /etc/dict.conf ${1}/etc/
cp /etc/dict.conf.sample ${1}/etc/
cp /etc/dictd.conf ${1}/etc/
cp /etc/dictd.conf.sample ${1}/etc/
echo -ne "###               program files in /etc/             ###\n"
echo -ne "#        lftp.conf xpdfrc wgetrc vsftpd.conf           #\n"
echo -ne "#              dict.conf dict.conf.sample              #\n"
echo -ne "#             dictd.conf dictd.conf.sample             #\n"
echo
# $HOME/Emacs/
cp $HOME/.emacs ${1}$HOME/
cp -rf $HOME/Emacs ${1}$HOME/
echo -ne "###     $HOME/.emacs   $HOME/Emacs/    ###\n"
echo
# $HOME/.fvwm/
cp -rf $HOME/.fvwm ${1}$HOME/
echo -ne "###            $HOME/.fvwm/                   ###\n"
echo
# $HOME/Matlab/
cp -rf $HOME/Matlab ${1}$HOME/
echo -ne "###            $HOME/Matlab                   ###\n"
# $HOME/.torsmos/
cp $HOME/.torsmorc ${1}$HOME/
cp -rf $HOME/.torsmos ${1}$HOME/
echo -ne "###  $HOME/.torsmorc   $HOME/.torsmos ###\n"
echo
# $HOME/.mutt/
#cp $HOME/.muttrc ${1}$HOME/
cp $HOME/.fetchmailrc ${1}$HOME/
cp $HOME/.esmtprc ${1}$HOME/
cp -rf $HOME/.mutt ${1}$HOME/
cp -rf $HOME/.certs ${1}$HOME/
echo -ne "###    $HOME/.certs    $HOME/.mutt    ###\n"
echo -ne "### $HOME/.fetchmailrc $HOME/.esmtprc ###\n"
echo
# $HOME/scripts/
cp -rf $HOME/scripts ${1}$HOME/
echo -ne "###              $HOME/scripts/               ###\n"
echo
# $HOME/.gftp/
mkdir -p ${1}$HOME/.gftp
cp $HOME/.gftp/bookmarks ${1}$HOME/.gftp/
cp $HOME/.gftp/gftprc ${1}$HOME/.gftp/
echo -ne "###              $HOME/.gftp/bookmarks        ###\n"
echo -ne "###              $HOME/.gftp/gftprc           ###\n"
echo
# $HOME/.fonts/
cp -rf $HOME/.fonts ${1}$HOME/
echo -ne "###                $HOME/.fonts/              ###\n"
echo
# $HOME/
cp $HOME/.bash_profile ${1}$HOME/
cp $HOME/.bashrc ${1}$HOME/
cp $HOME/.inputrc ${1}$HOME/
cp $HOME/.xinitrc ${1}$HOME/
cp $HOME/.Xresources ${1}$HOME/
cp $HOME/.vimrc ${1}$HOME/
cp $HOME/.xpdfrc ${1}$HOME/
cp $HOME/.lftprc ${1}$HOME/
cp $HOME/.bk2siterc ${1}$HOME/
echo -ne "###             files in $HOME/               ###\n"
echo -ne "# .bash_profile .bashrc .inputrc .xinitrc .Xresources  #\n"
echo -ne "#          .vimrc .xpdfrc .lftprc .bk2siterc           #\n"
echo
# compress
tar cjvf ${1}`date +%Y%m%d`.tar.bz2 ${1}

if [ $? -ne 0 ]; then
    echo -ne "tar error while compressing ...\n"
    exit 2
fi

echo -ne "### ${1}`date +%Y%m%d`.tar.bz2 ###\n"
du -sh ${1}`date +%Y%m%d`.tar.bz2
# upcompress
cat << EOF
### How To override all the backup configurations ###
# tar xvfj ${1}YYYYMMDD.tar.bz2
# cp -rf ${1}/* /
###                   Thanks                      ###
EOF
