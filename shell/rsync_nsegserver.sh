#!/bin/bash
IP_SERVER=192.168.7.125
#RSYNC_PASSWORD=flyzhy
#export RSYNC_PASSWORD
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/Emacs/ ${IP_SERVER}:/home/flyzhy/Emacs
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/Matlab/ ${IP_SERVER}:/home/flyzhy/Matlab
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/Music/ ${IP_SERVER}:/home/flyzhy/Music
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/Project/ ${IP_SERVER}:/home/flyzhy/Project
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/Software/ ${IP_SERVER}:/home/flyzhy/Software
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/backup/ ${IP_SERVER}:/home/flyzhy/backup
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/bin/ ${IP_SERVER}:/home/flyzhy/bin
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/personal-site/ ${IP_SERVER}:/home/flyzhy/personal-site
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/scripts/ ${IP_SERVER}:/home/flyzhy/scripts
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/Downloads/ ${IP_SERVER}:/home/flyzhy/Downloads
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/FLY/ ${IP_SERVER}:/home/flyzhy/FLY
#FLYZHY#rsync -avlz -e ssh --delete /home/flyzhy/tmp/ ${IP_SERVER}:/home/flyzhy/tmp
sudo rsync -avlz -e ssh --delete /home/ ${IP_SERVER}:/home/flyzhy/BackUp-ThinkPadR61/home
sudo rsync -avlz -e ssh --delete /etc/ ${IP_SERVER}:/home/flyzhy/BackUp-ThinkPadR61/etc
sudo rsync -avlz -e ssh --delete /opt/ ${IP_SERVER}:/home/flyzhy/BackUp-ThinkPadR61/opt
