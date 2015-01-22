#!/bin/bash
# MacOS /Users/flyzhy/research/0-HAB/
echo -ne "##### 同步 MacOS /Users/flyzhy/projects/2013-基于生物形态特征的中国海常见有害赤潮藻显微图像识别[国家自然科学基金-61271406]【201301-201612】 #####\n"
rsync -vaH --progress --delete -e ssh /Users/flyzhy/projects/2013-基于生物形态特征的中国海常见有害赤潮藻显微图像识别[国家自然科学基金-61271406]【201301-201612】/ root@222.195.149.61:/iplouc/research/05-基于生物形态特征的中国海常见有害赤潮藻显微图像识别[国家自然科学基金-61271406]【201301-201612】/ 
echo
echo -ne "##### 同步结束 #####\n"
