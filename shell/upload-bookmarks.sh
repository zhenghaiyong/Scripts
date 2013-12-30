#!/bin/bash
# cron
# upload-bookmarks.sh
# by Haiyong Zheng
# website: http://www.flyzhy.org
# email: zhenghaiyong@gmail.com
#
####################
# change directory #
####################
cd /home/flyzhy/personal-site/publish/
#----------------------------------------------------------#
###################
# execute bk2site #
###################
/usr/local/bin/bk2site
#----------------------------------------------------------#
####################
# upload bookmarks #
####################
/usr/bin/cp bookmarks/index.htm bookmarks/index.html
/usr/bin/lftp -f bookmarks/.ftprc-bookmarks
#----------------------------------------------------------#
# End
