#!/bin/bash
# MacOS ~/website/homepage/publish/
echo -ne "##### 同步 MacOS ~/website/homepage/publish/ #####\n"
rsync -vaH --progress --delete -e ssh ~/website/homepage/publish/ zhenghaiyong@211.64.142.66:~/public/
echo
echo -ne "##### 同步结束 #####\n"
