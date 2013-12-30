#/bin/bash
echo -ne "Chown -R ftp:ftp /home/ftp\n"
chown -R ftp:ftp /home/ftp
echo -ne "Chmod -R a-w /home/ftp\n"
chmod -R a-w /home/ftp
echo -ne "Chmod a+w /home/ftp/incoming\n"
chmod a+w /home/ftp/incoming
echo -ne "ls -lR /home/ftp > /home/ftp/ls-lR\n"
ls -lR /home/ftp > /home/ftp/ls-lR
echo -ne "tree -a -f /home/ftp > /home/ftp/tree.txt\n" 
tree -a -f /home/ftp > /home/ftp/tree.txt
