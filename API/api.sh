#!/bin/bash
RED_COLOR='\e[1;31m' #红色
GREEN_COLOR='\e[1;32m' #绿色
RES='\e[0m' #尾

#下载路径
Synoapi="https://raw.githubusercontent.com/3wking/Synology/main/API/api.cgi"
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

# 检查
Check() (
	echo -e "\r\n${GREEN_COLOR}正在检查目录...${RES}\r\n"
	api="/usr/syno/synoman/api"
	if [ ! -d $api ]; then
		echo -e "${GREEN_COLOR}创建<${api}>目录.{RES}\r\n"
		sudo mkdir $api
		if [ $? -ne 0 ]; then
			echo -e "${RED_COLOR}创建<${api}>目录失败.${RES}\r\n"
			sudo rm -rf $dir
			exit 1
		fi
		echo -e "${GREEN_COLOR}更改<${api}>目录权限.{RES}\r\n"
		sudo chmod -R 0777 $api
		if [ $? -ne 0 ]; then
			echo -e "${RED_COLOR}更改<${api}>权限失败.${RES}\r\n"
			sudo rm -rf $dir $api
			exit 1
		fi		
	fi
)
	

# 安装
Install() (
	echo -e "\r\n${GREEN_COLOR}安装软件包 ...${RES}\r\n"
	echo -e "${GREEN_COLOR}移动文件.${RES}\r\n"
	sudo mv -f $dir/*.cgi $api/
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}移动文件失败.${RES}\r\n"
		sudo rm -rf $dir $api
		exit 1
	fi
	echo -e "${GREEN_COLOR}更改api权限.${RES}\r\n"
	sudo chmod -R 0777 $api/*.cgi
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}更改权限失败.${RES}\r\n"
		sudo rm -rf $dir $api
		exit 1
	fi
	echo -e "\r\n${GREEN_COLOR}安装完成!${RES}\r\n"
)

Download
if [ $? -eq 0 ]; then
	 Check
else
	exit 1
fi
if [ $? -eq 0 ]; then
	 Install
fi		
