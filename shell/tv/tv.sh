#!/bin/bash
#程序：交互播放网络电视脚本v0.1
#作者：dogking (踏雪无痕)
#日期：2007年4月2日
#简介：通过读取你输入的数字选择相应的电视台
#更新：2007年4月2日晚加入频道选择
#更新：2007年4月3日加入录制节目功能
#更新：2007年4月3日加入参量全称支持，加入录制节目保存路径，文件名输入，添加注释
#更新：2007年4月3日将IP地址替换了域名，去掉了解析时间

##############################################################################################
##
## 作者信息
if [ "$1" = "-a" ] || [ "$1" = "-author" ];  then
	echo "交互播放网络电视脚本v0.1-(教育网用户)"
	echo "脚本作者：dogking (踏雪无痕)"
	echo "论坛：http://www.e-fox.cn "
	echo "邮件:zhang2659176@163.com"
	echo "欢迎多提意见^_^"
	exit 1

##############################################################################################
##
## 帮助信息
elif [ "$1" = "-h" ] || [ "$1" = "-help" ];  then
	echo "\$:tv -h  ;查看帮助"
	echo "\$:tv -a ;查看作者信息"
	echo "\$:tv  ;普通模式"
	echo "\$:tv x  ;快速模式，x为频道号"
	echo "\$:tv -l  ;频道列表"
	echo "\$:tv -r x;录制节目x"
	echo "\$:tv -k;终止录制"
	exit 1

##############################################################################################
##
## 频道列表
elif [ "$1" = "-l" ] || [ "$1" = "-list" ];  then
	echo "############################说 明  节目:频道代号############################"
	echo ""
	echo "==OUC=====CCTV1,5,9,10:[1|5|9|10]ouc 凤凰卫视:fhouc 凤凰资讯:zxouc=====OUC=="
	echo "====CCTV1:1...CCTV10:10 (无CCTV4,7) 湖南卫视:hn 凤凰卫视:fh 凤凰资讯:zx====="
	echo "===东方卫视:df 电视剧:ds 新闻频道:xw 英语BBC:bbc 探索发现:ts 音乐之声:yy===="
	echo ""
	echo "##################如果你有什么好的直播网址，请发邮件告诉我##################"
	exit 1

##############################################################################################
##
## 节目录制
elif [ "$1" = "-r" ] || [ "$1" = "-record" ];  then
	echo "############################说 明  节目:频道代号############################"
	echo ""
	echo "==OUC=====CCTV1,5,9,10:[1|5|9|10]ouc 凤凰卫视:fhouc 凤凰资讯:zxouc=====OUC=="
	echo "====CCTV1:1...CCTV10:10 (无CCTV4,7) 湖南卫视:hn 凤凰卫视:fh 凤凰资讯:zx====="
	echo "===东方卫视:df 电视剧:ds 新闻频道:xw 英语BBC:bbc 探索发现:ts 音乐之声:yy===="
	echo ""
	echo "##################如果你有什么好的直播网址，请发邮件告诉我##################"
case $2 in
1)
	r="cctv1"
	;;
1ouc)
	r="cctv1(OUC)"
	;;
2)
	r="cctv2"
	;;
3)
	r="cctv3"
	;;
5)
	r="cctv5"
	;;
5ouc)
	r="cctv5(OUC)"
	;;
6)
	r="cctv6"
	;;
8)
	r="cctv8"
	;;
9)
	r="cctv9"
	;;
9ouc)
	r="cctv9(OUC)"
	;;
10)
	r="cctv10"
	;;
10ouc)
	r="cctv10(OUC)"
	;;
hn)
	r="hntv"
	;;
fh)
	r="fhws"
	;;
fhouc)
	r="fhws(OUC)"
	;;
zx)
	r="fhinfo"
	;;
zxouc)
	r="fhwszx(OUC)"
	;;
df)
	r="dfws"
	;;
ds)
	r="stvtv"
	;;
xw)
	r="tv"
	;;
bbc)
	r="tv1"
	;;
ts)
	r="tv3"
	;;
yy)
	r="radio5"
	;;
*)
	echo "没有你要录制的频道，请输入正确频道名！"
	exit 1
esac
	echo "请输入存储路径……（直接回车为家目录）"
	read p
	echo "请输入文件名……（直接回车为频道名）"
	read n
		if [ "$p" = "" ]; then
			p="$HOME"
		fi
		if [ "$n" = "" ]; then
			n="$r"
		fi
	echo "正在录制 $r 节目……"
	mencoder -quiet mms://202.201.0.200/$r -ovc copy -lavcopts vcodec=mpeg4:vpass=1 -oac copy -o $p/$n.avi < /dev/null &
	exit 1

##############################################################################################
##
## 停止录制
elif [ "$1" = "-k" ] || [ "$1" = "-kill" ];  then
	echo "正在停止录制……"
	killall mencoder
	exit 1

##############################################################################################
##
## 参数形式传入频道
elif [ "$1" != "" ]; then
	jm=$1

##############################################################################################
##
## 读取用户输入频道名
else
	echo "############################说 明  节目:频道代号############################"
	echo "==OUC=====CCTV1,5,9,10:[1|5|9|10]ouc 凤凰卫视:fhouc 凤凰资讯:zxouc=====OUC=="
	echo "====CCTV1:1...CCTV10:10 (无CCTV4,7) 湖南卫视:hn 凤凰卫视:fh 凤凰资讯:zx====="
	echo "===东方卫视:df 电视剧:ds 新闻频道:xw 英语BBC:bbc 探索发现:ts 音乐之声:yy===="
	echo "退出菜单按:q 播放时退出:q "
	echo ""
	echo "请输入频道号："
	read jm	
fi

##############################################################################################
##
## 播放相应频道

case $jm in
1)
	echo "正在播放CCTV1……"
	mplayer mms://202.201.0.200/cctv1
	;;
1ouc)
	echo "正在播放CCTV1(OUC)……"
	mplayer mms://tv1.ouc.edu.cn/cctv1
	;;
2)
	echo "正在播放CCTV2……"
	mplayer mms://202.201.0.200/cctv2
	;;
3)
	echo "正在播放CCTV3……"
	mplayer mms://202.201.0.200/cctv3
	;;
5)
	echo "正在播放CCTV5……"
	mplayer mms://202.201.0.200/cctv5
	;;
5ouc)
	echo "正在播放CCTV5(OUC)……"
	mplayer mms://tv1.ouc.edu.cn/cctv5
	;;
6)
	echo "正在播放CCTV6……"
	mplayer mms://202.201.0.200/cctv6
	;;
8)
	echo "正在播放CCTV8……"
	mplayer mms://202.201.0.200/cctv8
	;;
9)
	echo "正在播放CCTV9……"
	mplayer mms://202.201.0.200/cctv9
	;;
9ouc)
	echo "正在播放CCTV9(OUC)……"
	mplayer mms://tv1.ouc.edu.cn/cctv9
	;;
10)
	echo "正在播放CCTV10……"
	mplayer mms://202.201.0.200/cctv10
	;;
10ouc)
	echo "正在播放CCTV10(OUC)……"
	mplayer mms://tv1.ouc.edu.cn/cctv10
	;;
hn)
	echo "正在播放湖南卫视…"
	mplayer mms://202.201.0.200/hntv
	;;
fh)
	echo "正在播放凤凰卫视…"
	mplayer mms://202.201.0.200/fhws
	;;
fhouc)
	echo "正在播放凤凰卫视中文(OUC)…"
	mplayer mms://tv1.ouc.edu.cn/fhwszw
	;;
zx)
	echo "正在播放凤凰资讯…"
	mplayer mms://202.201.0.200/fhinfo
	;;
zxouc)
	echo "正在播放凤凰卫视资讯(OUC)…"
	mplayer mms://tv1.ouc.edu.cn/fhws
	;;
df)
	echo "正在播放东方卫视…"
	mplayer mms://202.201.0.200/dfws
	;;
ds)
	echo "正在播放上海电视剧频道…"
	mplayer mms://202.201.0.200/stvtv
	;;
xw)
	echo "正在播放新闻频道…"
	mplayer mms://202.201.0.200/tv
	;;
bbc)
	echo "正在播放BBC…"
	mplayer mms://202.201.0.200/tv1
	;;
ts)
	echo "正在播放探索发现…"
	mplayer mms://202.201.0.200/tv3
	;;
yy)
	echo "正在播放音乐之声（广播）…"
	mplayer mms://202.201.0.200/radio5
	;;
q)
	echo "程序退出…"
	exit 1
	;;
*)
	echo "没有你要播放的频道，请输入正确频道名！"
	exit 1
esac