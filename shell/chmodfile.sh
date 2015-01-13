#!/bin/bash

if [ $# != 2 ]; then
	echo -ne "Arguments Error.\n"
	echo -ne "\tUsage:\n"
	echo -ne "\t\t$0 <directory_path> <file_modes_number>\n"
	echo -ne "\tExample:\n"
	echo -ne "\t\t$0 /path/to/dir/ 644\n"
	exit 7
fi

DIR=$1
MODE=$2

IFS=$(echo -en "\n\b")
for i in $(find ${DIR} -type f);
do
    chmod ${MODE} $i
done
IFS=' '
