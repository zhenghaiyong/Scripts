#!/bin/bash
#Written By ZHYFLY
if [ $# != 1 ]; then
    echo -ne "Arguments Error.\n"
    echo -ne "Usage:\n"
    echo -ne "\t$0 DIRECTORY\n"
else
    tree -a -f -i $1 > $1_tree.txt
    sed -n -e "/jpg/p" -e "/bmp/p" -e "/tif/p" $1_tree.txt > $1_imlist.txt
    echo -ne "`cat $1_imlist.txt | wc -l` images will be processed.\n"
    echo -ne "Processing ...\n"
    cat $1_imlist.txt | while read i
    do
      path=$i
      ext=.${i##*.}
      matlab -nosplash -nodesktop -r "culunkuozao_zhy('$path','$ext')"
    done
fi
