#!/bin/bash

if [ $# != 2 ]; then
	echo -ne "Arguments Error.\n"
	echo -ne "Usage:\n"
	echo -ne "\t$0 <Dir1> <Dir2>\n"
	exit 7

else

sum=0
dir1=$1
dir2=$2
for i in $(find ${dir1} -type f)
do 
	#echo $i
	for j in $(find ${dir2} -type f)
	do 
	#		echo $j
			if cmp -s $i $j
	        	then 
				((sum++))
				echo -ne "${sum}:\t\033[34m $i \033[0m\t=\t\033[41;33m $j \033[0m\n"
			fi 
	done 
done
echo -ne "\n"
echo -ne "\tThe number of files with same content is \033[41;37m ${sum} \033[0m"

fi
