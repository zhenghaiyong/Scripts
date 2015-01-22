#!/bin/bash
# MacOS /Users/flyzhy/research/0-HAB/
echo -ne "##### 同步 MacOS /Users/flyzhy/projects/2013-NSFC/ #####\n"
rsync -vaH --progress --delete -e ssh root@222.195.149.61:/iplouc/Prof.JiGR/project/2013-NSFC/ /Users/flyzhy/projects/2013-NSFC/
echo
echo -ne "##### 同步结束 #####\n"
