#!/usr/bin/python
# coding: utf-8
import sys
if len(sys.argv) < 3:
    print '  Usage: '+sys.argv[0]+' URL FORMAT'
    print '    e.g.: '+sys.argv[0]+' http://www.example.com/index.html pdf'
    print '    e.g.: '+sys.argv[0]+' http://www.example.com/index.html pdf dat'
    sys.exit()

import os
if os.path.isfile('readme.txt'):
    os.remove('readme.txt')

fReadme = file('readme.txt','a')
for arg in sys.argv:
    fReadme.write(arg)
    fReadme.write(' ')
fReadme.write('\n\nCheck <url.html> for url you input.')
fReadme.write('\nCheck <download.txt> for files you download.')
fReadme.close()

url = sys.argv[1]
format = sys.argv[2:]

urlpwd = os.path.dirname(url)+'/'

import urllib2
from BeautifulSoup import BeautifulSoup

page = urllib2.urlopen(url)
soup = BeautifulSoup(page)
   
if os.path.isfile('url.html'):
    os.remove('url.html')

fURL = file('url.html','a')
fURL.write(soup.prettify())
fURL.close()

if os.path.isfile('download.txt'):
    os.remove('download.txt')

fDownload = file('download.txt','a')

import re
for DownloadFormat in format:
    for DownloadAHref in soup.findAll('a', href=re.compile (r'.*.+%s$' % DownloadFormat)):
        urlRemote = re.search('^http://',DownloadAHref['href'])
        if urlRemote is None:
            DownloadURL=urlpwd+DownloadAHref['href']
            fDownload.write(DownloadURL)
        else:
            DownloadURL=DownloadAHref['href']
            fDownload.write(DownloadURL)
        fDownload.write('\n')
        os.system('wget -c %s' % DownloadURL)        
        
fDownload.close()
