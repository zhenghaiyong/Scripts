#!/bin/bash
# MacOS ~/research/1-ComputerVision/Saliency
echo -ne "##### 备份MacOS ~/research/1-ComputerVision/Saliency #####\n"
rsync -vaH --progress --delete -e ssh ~/research/1-ComputerVision/Saliency iplouc@222.195.148.225:~/Documents/
echo
echo -ne "##### 备份结束 #####\n"
