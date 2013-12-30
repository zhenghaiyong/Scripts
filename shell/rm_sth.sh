#!/bin/bash
if [ $# == 1 ]; then
    echo -ne "Deleting FILES including [$1] in the CURRENT directory ...\n\n"
    for i in $(tree -a -f -i | grep "$1")
    do
      echo -ne "Deleting $i\n"
      rm -f $i
    done
elif [ $# == 2 ]; then
    echo -ne "Deleting FILES including [$1] in [$2] directory ...\n"
    for i in $(tree -a -f -i $2 |grep "$1")
    do
      echo -ne "Deleting $i\n"
      rm -f $i
    done    
else
    echo -ne "Arguments Error.\n"
    echo -ne "Usage:\n"
    echo -ne "\t$0 STRING\n"
    echo -ne "\t$0 STRING DIRECTORY\n"
fi
