#!/bin/bash
echo -ne 'gsub(4842/,4841);{print $0}'
echo
awk 'gsub(/4842/,4841);{print $0}' test_awk.txt
echo
echo
echo -ne '{gusb{4842/,4841);print $0}'
echo
awk '{gsub(/4842/,4841);print $0}' test_awk.txt
echo
echo
echo -ne 'gsub(/4842/,4841) {print $0}'
echo
awk 'gsub(/4842/,4841) {print $0}' test_awk.txt
