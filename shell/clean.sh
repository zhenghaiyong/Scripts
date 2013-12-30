#!/bin/bash
echo
echo -ne "##### 清理孤立软件包 #####\n"
sudo deborphan | xargs sudo apt-get -y remove --purge
echo
echo -ne "##### 清理下载的缓存包 #####\n"
sudo apt-get autoclean && sudo apt-get clean 
echo
echo -ne "##### 清理不再需要的包 #####\n"
sudo apt-get autoremove
echo
echo -ne "##### 结束 #####\n"
