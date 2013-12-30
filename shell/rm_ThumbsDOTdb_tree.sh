#!/bin/bash
for i in $(tree -a -f -i|grep 'Thumbs.db')
do
  rm -f $i
done