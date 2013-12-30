#!/bin/bash
# Usage: remove all the suffix .tmp for files of the current directory.
# by Haiyong Zheng
# Email: flyzhy.org@gmail.com
echo -ne "Processing files in the following directory ...\n"
pwd
for i in $(ls *.tmp)
do
  mv ${i} `basename $i .tmp`
done
if [ $? -gt 0 ]; then
    echo -ne "Something wrong happened, check out pls.\n"
    exit 1
else
    echo -ne "Done.\n"
fi