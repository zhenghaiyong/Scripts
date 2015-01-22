#!/bin/bash
# MacOS /Users/flyzhy/workspace/TeXLive/Wiley/MRT/
echo -ne "##### 同步 MacOS /Users/flyzhy/workspace/TeXLive/Wiley/MRT/ #####\n"
rsync -vaH --progress --delete -e ssh root@222.195.149.61:/iplouc/Prof.JiGR/project/2012-MRT/ /Users/flyzhy/workspace/TeXLive/Wiley/MRT/
echo
echo -ne "##### 同步结束 #####\n"
