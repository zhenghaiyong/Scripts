#!/bin/bash
# Extract date&time info by <exif> command and print onto the picture.
if [ $# != 2 ]; then
    echo -ne "Usage: $0 PICTURE PLACE\n"
    exit 7
fi

Picture=$1
place=$2
PictureFormat=${Picture##*.}
PictureName=${Picture%.*}
PictureDatetime="${PictureName}-datetime.${PictureFormat}"
PictureDatetimePlace="${PictureName}-datetimeplace.${PictureFormat}"
datetime=`exif ${Picture}|grep Date|grep Orig|awk -F "|" '{print $2}'`
date=`echo ${datetime}|awk -F " " '{print $1}'|sed 's/:/-/g'`
time=`echo ${datetime}|awk -F " " '{print $2}'`
width=`exif ${Picture}|grep Pixel|grep X|awk -F "|" '{print $2}'`
height=`exif ${Picture}|grep Pixel|grep Y|awk -F "|" '{print $2}'`
textXdatetime=`expr ${width} - 1800`
textYdatetime=`expr ${height} - 50`
textXplace=`expr ${width} - 720`
textYplace=`expr ${height} - 50`

convert -fill yellow -pointsize 140 -draw "text ${textXdatetime},${textYdatetime} '${date} ${time}'" -font "Apple-Garamond-Regular" ${Picture} ${PictureDatetime}
convert -fill yellow -pointsize 130 -draw "text ${textXplace},${textYplace} '${place}'" -font "Adobe-黑体-Std-R" ${PictureDatetime} ${PictureDatetimePlace}
rm -f ${PictureDatetime}