#!/bin/bash
# MacOS /Users/zhenghaiyong/research/1-ComputerVision/Saliency
echo -ne "##### 备份MacOS /Users/zhenghaiyong/research/1-ComputerVision/Saliency #####\n"
rsync -vaH --progress --delete -e ssh /Users/zhenghaiyong/research/1-ComputerVision/Saliency iplouc@222.195.148.225:/Users/iplouc/Documents/
echo
echo -ne "##### 备份结束 #####\n"
