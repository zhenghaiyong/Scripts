#!/bin/bash
# MacOS /Users/flyzhy/workspace/TeXLive/Elsevier/JASTP/
echo -ne "##### 同步 MacOS /Users/flyzhy/workspace/TeXLive/Elsevier/JASTP/ #####\n"
rsync -vaH --progress --delete -e ssh root@222.195.149.61:/iplouc/Prof.JiGR/project/2012-JASTP/ /Users/flyzhy/workspace/TeXLive/Elsevier/JASTP/
echo
echo -ne "##### 同步结束 #####\n"
