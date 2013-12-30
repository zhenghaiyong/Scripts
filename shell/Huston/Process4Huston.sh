#!/bin/bash

ARGUMENT=$1
FILENAME=${ARGUMENT%.txt}
FILE=${FILENAME}.txt
FILE_ORIG=${FILENAME}-orig.txt
FILE_DOS2UNIX=${FILENAME}-dos2unix.txt
FILE_MERGE=${FILENAME}-merge.txt
FILE_AWK=${FILENAME}-awk.txt
FILE_SED=${FILENAME}-sed.txt
FILE_OUTPUT=${FILENAME}-output.txt

# backup original file
cp ${FILE} ${FILE_ORIG}

# convert DOS format file to UNIX format file
# DOS text files (newline CR/LF) traditionally have Carriage Return and Line Feed pairs as their newline characters 
# while UNIX text files (newline LF) have the Line Feed as their newline character.
#Windows: CR+LF => \r\n
#UNIX: LF => \n
#MAC: CR => \r
dos2unix ${FILE_ORIG}

# add one blank line to the end of file
echo >> ${FILE_ORIG}

# delete more than one blank lines to one blank line
#uniq ${FILE_ORIG} > ${FILE_MERGE}
cat -s ${FILE_ORIG} > ${FILE_MERGE}

#awk '/HH/,/\/\//{i++;if(/\/\//){a=a"\n111"$0;gsub(/ /,"222",a);print a;a="";i=0}else {if(i==1)a=$0"333\n";else a=a"444"$0};next};1' 1.txt
#1.txt
###I am a
###big
###star
###
###HH
###Do you
###know?
###I will
###kill
###you.
###//

###Hello
###C
###
awk '{i++; if(/^$/) {a=a"\n"$0;print a;a="";i=0} else {if(i==1)a=$0" ";else a=a" "$0}; next};1' ${FILE_MERGE} > ${FILE_AWK}
#'1;' or ';1' <=> {print } 
# '1' <=> "1" which is only a character
# check more about details about AWK "pattern" "action" "{}" and ";"
#/pattern/{/pattern/{action};/pattern/{action};...}

# delete more than one blanks to one blank
sed 's/ \+/ /g' ${FILE_AWK} > ${FILE_OUTPUT}
