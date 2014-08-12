#!/bin/bash
# MacOS /Users/zhenghaiyong/ exclude 'nonsync', 'Documents/Virtual Machines.localized', and '.macports'
echo -ne "##### 备份MacOS /Users/zhenghaiyong/ exclude 'nonsync', 'Documents/Virtual Machines.localized', 'Library', '.cpan', '.macports', '.subversion'. #####\n"
rsync -vaH --progress --delete --exclude 'nonsync' --exclude 'Documents/Virtual Machines.localized' --exclude 'Library' --exclude '.cpan' --exclude '.macports' --exclude '.subversion' -e ssh /Users/zhenghaiyong/ root@222.195.149.61:/iplouc/study/PhD/2009/郑海永/BackUp/MacBookProME866CHA/MacOS/Users/zhenghaiyong/
echo
echo -ne "##### 备份结束 #####\n"
