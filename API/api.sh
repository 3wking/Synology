#!/bin/sudo /bin/bash
RED_COLOR='\e[1;31m' #红色
GREEN_COLOR='\e[1;32m' #绿色
RES='\e[0m' #尾

#下载路径
Synoapi=""
#创建临时目录
dir=$(mktemp -d) && cd $dir || exit 1
#设置GitHub加速下载
ip_info=$(curl -sk https://ip.cooluc.com)
country_code=$(echo $ip_info | sed -r 's/.*country_code":"([^"]*).*/\1/')
if [ $country_code = "CN" ]; then
	google_status=$(curl -I -4 -m 3 -o /dev/null -s -w %{http_code} http://www.google.com/generate_204)
	if [ ! $google_status = "204" ];then
		mirror="https://github.cooluc.com/"
	fi
fi
#下载
Download() (
	echo -e "\r\n${GREEN_COLOR}下载软件包 ...${RES}\r\n"
	echo -e "${GREEN_COLOR}正在下载 $Synoapi ...${RES}"
	curl --connect-timeout 30 -m 600 -#kLO $mirror$Synoapi
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}下载 $Synoapi 失败.${RES}\r\n"
		rm -rf $dir
		exit 1
	fi
)	

autostart() (
echo -e "${RED_COLOR}写入开机自启动.{RES}\r\n"
usr="/usr/syno/etc.defaults/rc.sysv/Synoapi.sh"
cat >$usr<<EOF
#/bin/bash
nohup /usr/local/bin/Synoapi > /dev/null
EOF
if [ $? -ne 0 ]; then
	echo -e "${RED_COLOR}写入自启动失败.${RES}\r\n"
	rm -rf $dir /usr/local/bin/Synoapi
	exit 1

fi

)


Install() (
	# 安装
	echo -e "\r\n${GREEN_COLOR}安装软件包 ...${RES}\r\n"
	echo -e "${RED_COLOR}移动文件到</usr/local/bin>目录.{RES}\r\n"
	mv Synoapi /usr/local/bin
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}移动文件失败.${RES}\r\n"
		rm -rf $dir
		exit 1
	fi
	echo -e "${RED_COLOR}更改权限0775.{RES}\r\n"
	chmod -R 755 /usr/local/bin/Synoapi
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}更改权限0775.${RES}\r\n"
		rm -rf $dir /usr/local/bin/Synoapi
		exit 1
	fi
	echo -e "${RED_COLOR}启动Synoapi.{RES}\r\n"
	nohup /usr/local/bin/Synoapi > /dev/null &
	rm -rf $dir
	echo -e "\r\n${GREEN_COLOR}安装完成!${RES}\r\n"
)
