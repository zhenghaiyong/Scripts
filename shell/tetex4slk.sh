#/bin/bash
# This is a simple script for people who want to use CJK package of TeX/LaTeX
# successfully based on SlackWare Linux.
# author: Haiyong Zheng
# website: http://www.flyzhy.org
# For my best lover: Fly(Ruth)
# This is only for SlackWare Linux with tetex 3.0

echo -ne "\t\t Welcome to \\033[0;32mTeX/LaTeX\\033[0;39m of SlackWare Linux\n"
echo 
echo -ne "Installing TeX first ......\n"
# Ask whether you have installed TeTeX for SlackWare or not
echo -ne "Whether you have installed TeTeX for SlackWare or not?\n"
cat << END
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++ teTeX For SlackWare ++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Y : Yes, I have installed teTeX 3.0 for SlackWare Linux
N : No, I didnot install teTeX for SlackWare Linux yet, install now
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
#echo 'export PATH="$PATH:/usr/share/texmf/bin"' >> /etc/profile
#if [ $? -gt 0 ]; then
#	echo -ne "Permission denied. Check if you are root!\n"
#	exit 1
#else
	#. $HOME/.bashrc
#	. /etc/profile
	# Check if there are other users

#fi
# Create /usr/share/texmf-local
mkdir -p /usr/share/texmf-local
mkdir -p /usr/share/texmf-local/source
cd /usr/share/texmf-local/source/

# Converting TTY fonts to Type1 fonts
# Downloading fonts and gbkfonts
wget http://www.flyzhy.org/web/backup/TeX/hanzi.tar.gz && \
wget http://www.flyzhy.org/web/backup/TeX/gbkfonts && \
#wget http://www.flyzhy.org/web/backup/TeX/run.sh
cat << EOF > run_gbkfonts.sh
gbkfonts source/hanzi/simsun.ttf song
gbkfonts source/hanzi/simhei.ttf hei
gbkfonts source/hanzi/simkai.ttf kai
gbkfonts source/hanzi/simfang.ttf fs
gbkfonts source/hanzi/simli.ttf li
gbkfonts source/hanzi/simyou.ttf you
gbkfonts source/hanzi/stfangso.ttf fangsong
gbkfonts source/hanzi/stcaiyun.ttf stcaiyun
gbkfonts source/hanzi/stxihei.ttf stxihei
gbkfonts source/hanzi/stxingka.ttf stxingka
gbkfonts source/hanzi/stxinwei.ttf stxinwei
gbkfonts source/hanzi/stzhongs.ttf stzhongs
gbkfonts source/hanzi/stliti.ttf stliti
gbkfonts source/hanzi/stsong.ttf stsong
gbkfonts source/hanzi/stkaiti.ttf stkaiti
gbkfonts source/hanzi/fzstk.ttf fzstk
gbkfonts source/hanzi/fzytk.ttf fzytk
EOF
if [ $? -gt 0 ]; then
	echo -ne "Can not get fonts from \n"
	echo -ne "http://www.flyzhy.org\n"
	echo -ne "Downloading hanzi.tar.gz Error!\n"
	echo -ne "Please Check your network!\n"
	exit 1
else
	echo -ne "Download done. Next installing Fonts ......\n"
fi
tar xvfz hanzi.tar.gz
chmod +x gbkfonts
cp gbkfonts /usr/local/bin
chmod +x run_gbkfonts.sh
cp run_gbkfonts.sh /usr/share/texmf-local/
cd /usr/share/texmf-local/
./run_gbkfonts.sh
#touch fonts_family_name.txt
#for font in $(ls /usr/share/texmf-local/hanzi/); do
#	gbkfonts ../hanzi/$font ${font%\.*}
#	echo ${font%\.*} >> fonts_family_name.txt
#done
if [ $? -gt 0 ]; then
	echo -ne "Generating Fonts error!\n"
	exit 1
else
	echo -ne "Generate Fonts done.\n"
fi
#cd /usr/share/texmf-local/
#echo "Configurating Fonts ......\n"
#mkdir -p /usr/share/texmf-local/fonts/truetype
#mv /usr/share/texmf-local/source/hanzi/*.ttf /usr/share/texmf-local/fonts/truetype/
#mkdir -p /usr/share/texmf-local/fonts/map/dvips
#cp /usr/share/texmf-local/cjk.map /usr/share/texmf-local/dvips/
#cp /usr/share/texmf-local/cjk.map /usr/share/texmf-local/fonts/map/dvips/
#mkdir -p /usr/share/texmf-local/fonts/map/dvipdfm
#cp /usr/share/texmf-local/dvipdfm/config/*.map /usr/share/texmf-local/fonts/map/dvipdfm/
#mkdir -p /usr/share/texmf-local/fonts/map/pdftex
#cp /usr/share/texmf-local/pdftex/config/*.map /usr/share/texmf-local/fonts/map/pdftex/
#mkdir -p /usr/share/texmf-local/fonts/map/ttf2pk
#cp /usr/share/texmf-local/ttfonts.map /usr/share/texmf-local/fonts/map/ttf2pk/
#mkdir -p /usr/share/texmf-local/fonts/enc/pdftex
#cp -rf /usr/share/texmf-local/dvips/chinese /usr/share/texmf-local/fonts/enc/pdftex/

# Downloading the latest CJK version from
# http://cjk.ffii.org/
cd /usr/share/texmf-local/source/
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
mv cjk-current/texinput/GB/c19song.fd cjk-current/texinput/GB/c19song.fd.CJK
cp -rf cjk-current/texinput/* /usr/share/texmf-local/tex/latex/CJK/
#cp -rf cjk-current/texinput/GB/* /usr/share/texmf-local/tex/latex/CJK/GB/
#
# dvips configuration
echo "Configurating dvips ......\n"
echo "p +cjk.map" >> /usr/share/texmf/dvips/config/config.ps
#
# dvipdfm configuration
echo "Configurating dvipdfm ......\n"
cp /usr/share/texmf-local/cid-x.map /usr/share/texmf-local/dvipdfm/config/
cp /usr/share/texmf/dvipdfm/config/config /usr/share/texmf-local/dvipdfm/config/
echo "f cid-x.map" >> /usr/share/texmf-local/dvipdfm/config/config
#
# pdftex/pdflatex configuration
cp /usr/share/texmf-local/pdftex.cfg /usr/share/texmf-local/pdftex/config/
echo "map +cjk.map" >> /usr/share/texmf-local/pdftex/config/pdftex.cfg
#mv /usr/share/texmf-var/fonts/map/pdftex/updmap/pdftex.map /usr/share/texmf-var/fonts/map/pdftex/updmap/pdftex.map.lnk
#ln -s /usr/share/texmf-local/fonts/map/pdftex/gbksong.map /usr/share/texmf-local/fonts/map/pdftex/pdftex.map
#echo -ne " To use CJK for dvips, dvipdfm, etc. Then modify /usr/share/texmf/web2c/texmf.cnf now\n"
#
#sed -i \
# -e '/^TFMFONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/tfm//@p' \
# -e '/^T1FONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/type1//@p' \
# -e '/^AFMFONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/afm//@p' \
# -e '/^TTFONTS/s@\(.*\)@\1;/usr/share/texmf-local/fonts/type1//@p' \
# /usr/share/texmf/web2c/texmf.cnf
#if [ $? -gt 0 ]; then
#	echo -ne "error occured when modify /usr/share/texmf/web2c/texmf.cnf\n"
#	echo -ne "you should modify it manually by the last reference!\n"
#fi
#
cd /usr/share/texmf-local/
echo "Configurating Fonts ......\n"
mkdir -p /usr/share/texmf-local/fonts/truetype
mv /usr/share/texmf-local/source/hanzi/*.ttf /usr/share/texmf-local/fonts/truetype/
mkdir -p /usr/share/texmf-local/fonts/map/dvips
cp /usr/share/texmf-local/cjk.map /usr/share/texmf-local/dvips/
cp /usr/share/texmf-local/cjk.map /usr/share/texmf-local/fonts/map/dvips/
mkdir -p /usr/share/texmf-local/fonts/map/dvipdfm
cp /usr/share/texmf-local/dvipdfm/config/*.map /usr/share/texmf-local/fonts/map/dvipdfm/
mkdir -p /usr/share/texmf-local/fonts/map/pdftex
cp /usr/share/texmf-local/pdftex/config/*.map /usr/share/texmf-local/fonts/map/pdftex/
mkdir -p /usr/share/texmf-local/fonts/map/ttf2pk
cp /usr/share/texmf-local/ttfonts.map /usr/share/texmf-local/fonts/map/ttf2pk/
mkdir -p /usr/share/texmf-local/fonts/enc/pdftex
cp -rf /usr/share/texmf-local/dvips/chinese /usr/share/texmf-local/fonts/enc/pdftex/
#
echo
echo
echo
echo -ne "update TeX TDS by mktexlsr"
/usr/share/texmf/bin/mktexlsr
#
cat << END
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ Well Done!
+ You can use CJK Now!
+
+ Anything Wrong Please contact me by my E-mail:
+ zhy2111314 AT gmail DOT com
+ Thank you!
+
+ Besides, the following commands for you to refer to:
+ \$latex foo.tex
+ \$xdvi foo.dvi
+ \$dvips foo.dvi
+ \$dvipdfm foo.dvi
+ create foo.dvi foo.ps foo.pdf respectively with CJK
+ Good Luck!^_^
+
+ see 
http://www.flyzhy.org/blog/archives/2006/04/13/T22_24_20/index.html
http://www.flyzhy.org/projects/TeXConfig.html
+ for more details.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END
