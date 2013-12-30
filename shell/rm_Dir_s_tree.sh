#!/bin/bash
for i in $(tree -a -f -i -d|grep '/s$')
do
  rm -rf $i
done
