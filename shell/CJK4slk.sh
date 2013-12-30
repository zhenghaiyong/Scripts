#/bin/bash
# This is a simple script for people who want to use CJK package of TeX/LaTeX
# successfully based on SlackWare Linux.
# Author: Haiyong Zheng
# E-mail: zhy2111314@yahoo.com.cn
# For my best lover: fly
# This is only for SlackWare Linux

echo -ne "\t\t Welcome to \\033[0;32mTeX/LaTeX\\033[0;39m of SlackWare Linux\n"
echo 
echo -ne "Installing TeX first ......\n"
# Ask whether you have installed TeTeX for SlackWare or not
echo -ne "Whether you have installed TeTeX for SlackWare or not?\n"
cat << END
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++ TeTeX For SlackWare ++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Y : Yes, I have installed TeTeX for SlackWare Linux
N : No, I didnot install TeTeX for SlackWare Linux yet, install now
Q : Quit, I donot want to install anything now
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END

echo -ne "\t\\033[0;32mYour Choice[Y,N,Q]>\\033[0;39m"
read CHOICE
case $CHOICE in
	Y|y) echo -ne "OK, We will continue ......\n"
	;;
	N|n) echo -ne "OK, first installing TeTeX from\n"
	echo -ne "http://slackware.at/data/slack-current\n"
	echo -ne "Downloading ......\n"
	wget http://slackware.at/data/slackware-current/slackware/t/tetex-3.0-i486-1.tgz && \
	wget http://slackware.at/data/slackware-current/slackware/t/tetex-doc-3.0-noarch-1.tgz
	if [ $? -gt 0 ]; then
		echo -ne "Can not get file from \n"
		echo -ne "http://slackware.at/data/slackware-current/slackware/t/\n"
		echo -ne "Download tetex-3.0-i486-1.tgz Error.\n"
		echo -ne "Please Check your network\n"
		exit 1
	else
		echo -ne "Download done. Next installing TeTeX ......\n"
		echo -ne "Makesure you are now root.\n"
	fi
	installpkg tetex-3.0-i486-1.tgz && installpkg tetex-doc-3.0-noarch-1.tgz
	if [ $? -gt 0 ]; then
		echo -ne "Installing tetex-3.0-i486-1.tgz Error.\n"
		echo -ne "Please make sure you are root now\n"
		exit 1
	else
		echo -ne "Installing done.\n"
	fi
	;;
	Q|q) echo -ne "Goodbye!\n"
	exit 0
	;;
esac

# TeTeX can create two directories which are /usr/share/texmf and /usr/share/texmf-var
# First update your PATH
# echo 'export PATH="$PATH:/usr/share/texmf/bin"' >> $HOME/.bashrc
# modify /etc/profile for PATH update
echo 'export PATH="$PATH:/usr/share/texmf/bin"' >> /etc/profile
if [ $? -gt 0 ]; then
	echo -ne "Permission denied. Check if you are root!\n"
	exit 1
else
	#. $HOME/.bashrc
	. /etc/profile
	# Check if there are other users

fi
# Create /usr/share/texmf-local
mkdir -p /usr/share/texmf-local
cd /usr/share/texmf-local

# Converting TTY fonts to Type1 fonts
# Downloading fonts and gbkfonts
wget http://zhy2fly.lysafe.com/web/backup/TeX/hanzi.tar.gz && \
wget http://zhy2fly.lysafe.com/web/backup/TeX/gbkfonts
if [ $? -gt 0 ]; then
	echo -ne "Can not get fonts from \n"
	echo -ne "http://zhy2fly.lysafe.com\n"
	echo -ne "Downloading hanzi.tar.gz Error!\n"
	echo -ne "Please Check your network!\n"
	exit 1
else
	echo -ne "Download done. Next installing Fonts ......\n"
fi
tar xvfz hanzi.tar.gz
mkdir fontsgenerate
chmod +x gbkfonts
mv gbkfonts /usr/local/bin
cd fontsgenerate
touch fonts_family_name.txt
for font in $(ls /usr/share/texmf-local/hanzi/); do
	gbkfonts ../hanzi/$font ${font%\.*}
	echo ${font%\.*} >> fonts_family_name.txt
done
if [ $? -gt 0 ]; then
	echo -ne "Generating Fonts error!\n"
	exit 1
else
	echo -ne "Generate Fonts done.\n"
fi
mv -dpR /usr/share/texmf-local/fontsgenerate/* /usr/share/texmf-local/
cd /usr/share/texmf-local/
rm -rf fontsgenerate hanzi.tar.gz hanzi
echo 
# Downloading the latest CJK version from
# http://cjk.ffii.org/
wget http://cjk.ffii.org/cjk-current.tar.gz
if [ $? -gt 0 ]; then
	echo -ne "Can not get file from \n"
	echo -ne "http://cjk.ffii.org\n"
	echo -ne "Downloading cjk-current.tar.gz error!\n"
	echo -ne "Please Check your network!\n"
	exit 1
else
	echo -ne "Download cjk-current.tar.gz done.\n"
fi
tar xvfz cjk-current.tar.gz
cp -dpR /usr/share/texmf-local/cjk-current/texinput/* /usr/share/texmf-local/tex/latex/CJK/
cp -dpR /usr/share/texmf-local/cjk-current/doc /usr/share/texmf-local/
rm -rf /usr/share/texmf-local/cjk-current /usr/share/texmf-local/cjk-current.tar.gz
echo "p +/usr/share/texmf-local/cjk.map" >> /usr/share/texmf/dvips/config/config.ps
cd /usr/share/texmf-local/
cp cid-x.map dvipdfm/config/
cp pdftex.cfg pdftex/config/
echo -ne " To use CJK for dvips, dvipdfm, etc. Then modify /usr/share/texmf/web2c/texmf.cnf now\n"
sed -i \
 -e '/^TFMFONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/tfm//@p' \
 -e '/^T1FONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/type1//@p' \
 -e '/^AFMFONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/afm//@p' \
 -e '/^TTFONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/type1//@p' \
 /usr/share/texmf/web2c/texmf.cnf
if [ $? -gt 0 ]; then
	echo -ne "error occured when modify /usr/share/texmf/web2c/texmf.cnf\n"
	echo -ne "you should modify it manually by the last reference!\n"
fi
echo
echo
echo
echo -ne "update TeX TDS by mktexlsr"
/usr/share/texmf/bin/mktexlsr

cat << END
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ Well Done!
+ You can use CJK Now!
+ About HowTo use CJK look at the file in
+ /usr/share/texmf-local/doc/
+ named CJK.txt and the family name of the fonts are in
+ /usr/share/texmf-lcoal/fonts_family_name.txt
+ 
+ To use CJK for dvips dvipdfm etc.I have modified 
+ /usr/share/texmf/web2c/texmf.cnf
+ by the following reference:
+
 TFMFONTS = .;{\$TEXMF/fonts,\$VARTEXFONTS}/tfm//;/usr/share/texmf-local/fonts/tfm//
 T1FONTS = .;\$TEXMF/fonts/type1//;/usr/share/texmf-local/fonts/type1//
 AFMFONTS = .;\$TEXMF/fonts/afm//;/usr/share/texmf-local/fonts/afm//
 TTFONTS = .;\$TEXMF/fonts/truetype//;/usr/share/texmf-local/fonts/type1//
+
+ Anything Wrong Please contact me by my E-mail:
+ zhy2111314 AT yahoo DOT com DOT cn
+ Thank you!
+
+ Besides, the following commands for you to refer to:
+ \$latex foo.tex
+ \$xdvi foo.dvi
+ \$dvips foo.dvi
+ \$dvipdfm foo.dvi
+ create foo.dvi foo.ps foo.pdf respectively with CJK
+ Good Luck!^_^
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END
