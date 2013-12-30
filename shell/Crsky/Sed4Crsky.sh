#!/bin/bash
# Usage: delete the \ characters and spaces or TABs at the end of a line
#        with the spaces or TABs at the beginning of the following line.
# by Haiyong Zheng
# Email: flyzhy.org@gmail.com
echo -ne "Processing files in the following directory ...\n"
pwd
for i in $(ls)
do
  sed -e :a -e '/\\\ *$/N;s/\\\s*\n\s*//;ta' ${i} > ${i}.tmp
done
if [ $? -gt 0 ]; then
    echo -ne "Something wrong happened, check out pls.\n"
    exit 1
else
    echo -ne "Done.\n"
fi
