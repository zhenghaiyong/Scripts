#!/bin/bash
# Ubuntu /home
echo -ne "##### 备份Ubuntu /home #####\n"
sudo rsync -vaH --progress --delete --exclude '.gvfs' -e ssh /home root@222.195.149.61:/iplouc/Prof.JiGR/graduate/PhD/2009/郑海永/BackUp/ThinkpadR61/Ubuntu/
echo
# Ubuntu /opt
echo -ne "##### 备份Ubuntu /opt #####\n"
sudo rsync -vaH --progress --delete -e ssh /opt root@222.195.149.61:/iplouc/Prof.JiGR/graduate/PhD/2009/郑海永/BackUp/ThinkpadR61/Ubuntu/
echo
# Windows7 D
echo -ne "##### 备份Windows7 D盘 #####\n"
sudo rsync -vaH --progress --delete -e ssh /media/15B496AC3B9A2FF1/ root@222.195.149.61:/iplouc/Prof.JiGR/graduate/PhD/2009/郑海永/BackUp/ThinkpadR61/Windows7/D/
echo
# Windows7 C:\Users\FlyZhyGG\Desktop
echo -ne "##### 备份Windows7 C:\Users\FlyZhyGG\Desktop #####\n"
sudo rsync -vaH --progress --delete -e ssh /media/D89059C79059AD2E/Users/FlyZhyGG/Desktop root@222.195.149.61:/iplouc/Prof.JiGR/graduate/PhD/2009/郑海永/BackUp/ThinkpadR61/Windows7/C/
echo
# Windows7 C:\Users\FlyZhyGG\Downloads
echo -ne "##### 备份Windows7 C:\Users\FlyZhyGG\Downloads #####\n"
sudo rsync -vaH --progress --delete -e ssh /media/D89059C79059AD2E/Users/FlyZhyGG/Downloads root@222.195.149.61:/iplouc/Prof.JiGR/graduate/PhD/2009/郑海永/BackUp/ThinkpadR61/Windows7/C/
echo
echo -ne "##### 备份结束 #####\n"
