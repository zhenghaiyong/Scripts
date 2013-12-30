#!/usr/bin/env bash
for i in $(/bin/ls --color=auto --classify| /usr/bin/grep /$)
do
	if [ -e ${i}Thumbs.db ]; then
		/usr/bin/rm -f ${i}Thumbs.db
	fi
done
