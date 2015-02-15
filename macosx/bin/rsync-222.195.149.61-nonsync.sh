#!/bin/bash
# MacOS ~/nonsync/*/
echo -ne "##### 备份MacOS ~/nonsync/*/  #####\n"
echo
for i in `find ~/nonsync -depth 1 -type d`
do
	rsync -vaH --progress --delete -e ssh $i/ root@222.195.149.61:/iplouc/study/video/${i##*/}/
done
echo
echo -ne "##### 备份结束 #####\n"
