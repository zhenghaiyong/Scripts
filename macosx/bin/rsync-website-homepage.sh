#!/bin/bash
# MacOS ~/website/homepage/publish/
echo -ne "##### 同步 MacOS ~/website/homepage/publish/ #####\n"
rsync -vaH --progress --delete -e ssh ~/website/homepage/publish/ zhenghaiyong@211.64.142.66:~/public/
#rsync -vaH --progress --delete -e ssh ~/job/Teaching/MOOC/2014fall/ zhenghaiyong@211.64.142.66:/fly/download/mooc/2014fall/
echo
echo -ne "##### 同步结束 #####\n"
