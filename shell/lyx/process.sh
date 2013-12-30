#!/bin/bash

if [ $# != 1 ]; then
	echo "USAGE:"
	echo "    $0 FILE"
	exit 7;
fi

file=$1
filename=${1%.txt}
Hu1234="${filename}Hu1234.txt"
Hu1="${filename}Hu1.txt"
Hu2="${filename}Hu2.txt"
Hu3="${filename}Hu3.txt"
Hu4="${filename}Hu4.txt"


cat ${file}|sed 'N;/bmp/s/\n/ /'|awk '{print $1" "$2" "$3" "$4" "$5}' > ${Hu1234} 

awk '{print $1" "$2}' ${Hu1234} > ${Hu1}
awk '{print $1" "$3}' ${Hu1234} > ${Hu2}
awk '{print $1" "$4}' ${Hu1234} > ${Hu3}
awk '{print $1" "$5}' ${Hu1234} > ${Hu4}

HuDIR="Hu"
mkdir ${HuDIR}

cat ${Hu1234} | while read line
do
	ImageName="${line%.bmp*}"
	echo ${line#*bmp } > ${HuDIR}/${ImageName}.txt
done

for i in ${HuDIR}/*.txt
do
	ImageName=${i%.txt}

done

