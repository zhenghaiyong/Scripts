find ~ \( -path ~/.subversion -o -path ~/workspace/www \) -prune -o -name ".DS_Store" -print -exec rm {} \;
find ~ \( -path ~/.subversion -o -path ~/workspace/www \) -prune -o -name "._*" -print -exec rm {} \;
