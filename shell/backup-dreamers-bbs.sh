#!/bin/bash
# cron
# backup-dreamers-bbs.sh
# by Haiyong Zheng
# website: http://www.flyzhy.org
#
####################
# change directory #
####################
cd /home/flyzhy/backup/dreamers/
#----------------------------------------------------------#
##########
# backup #
##########
# backup dreamers/bbs/Data/Dreamers_FlyZhy_XuXuemin.asp
/bin/ftp -i -in <<EOF
open 61.156.238.87
user Albert dreamers.com.cn
cd bbs/Data/
get Dreamers_FlyZhy_XuXuemin.asp
EOF
# timestamp the latest backup
/usr/bin/cp Dreamers_FlyZhy_XuXuemin.asp Dreamers_FlyZhy_XuXuemin-`date +%Y%m%d`.asp
#----------------------------------------------------------#
################
# delete older #
################
# delete 3 days older backup
/usr/bin/find . -name "Dreamers_FlyZhy_XuXuemin*.asp" -mtime +3 -exec rm {} \;
#----------------------------------------------------------#
# End