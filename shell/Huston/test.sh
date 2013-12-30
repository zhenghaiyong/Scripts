#!/bin/bash
awk '/HH/,/\/\//{i++;if(/\/\//){a=a"\n111"$0;gsub(/ /,"222",a);print a;a="";i=0}else {if(i==1)a=$0"333\n";else a=a"444"$0};next};1' test.txt
