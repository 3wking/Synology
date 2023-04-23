#!/bin/bash
RED_COLOR='\e[1;31m' #红色
GREEN_COLOR='\e[1;32m' #绿色
RES='\e[0m' #尾

#下载路径
Synoapi="https://raw.githubusercontent.com/3wking/Synology/main/API/api.cgi"

#设置GitHub加速下载
ip_info=$(curl -sk https://ip.cooluc.com)
country_code=$(echo $ip_info | sed -r 's/.*country_code":"([^"]*).*/\1/')
if [ $country_code = "CN" ]; then
	google_status=$(curl -I -4 -m 3 -o /dev/null -s -w %{http_code} http://www.google.com/generate_204)
	if [ ! $google_status = "204" ];then
		mirror="https://github.cooluc.com/"
	fi
fi

# 检查
Check() (
	echo -e "\r\n${GREEN_COLOR}正在检查目录...${RES}\r\n"
	dir="/usr/syno/synoman/api"
	if [ ! -d $dir ]; then
		echo -e "${GREEN_COLOR}创建<${dir}>目录.{RES}\r\n"
		sudo mkdir $dir
		if [ $? -ne 0 ]; then
			echo -e "${RED_COLOR}创建<${dir}>目录失败.${RES}\r\n"
			sudo rm -rf $dir
			exit 1
		fi
		echo -e "${GREEN_COLOR}更改<${dir}>目录权限.{RES}\r\n"
		sudo chmod -R 0777 $dir
		if [ $? -ne 0 ]; then
			echo -e "${RED_COLOR}更改<${dir}>权限失败.${RES}\r\n"
			sudo rm -rf $dir
			exit 1
		fi		
	fi
	echo -e "\r\n${GREEN_COLOR}跳转<${dir}>目录${RES}\r\n"
	cd $dir
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}跳转<${dir}>目录失败.${RES}\r\n"
		sudo rm -rf $dir
		exit 1
	fi	
)

#下载
Download() (
	echo -e "\r\n${GREEN_COLOR}下载软件包 ...${RES}\r\n"
	echo -e "${GREEN_COLOR}正在下载 $Synoapi ...${RES}"
	sudo curl --connect-timeout 30 -m 600 -#kLO $mirror$Synoapi
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}下载 $Synoapi 失败.${RES}\r\n"
		rm -rf $dir
		exit 1
	fi
)	

# 安装
Install() (
	echo -e "\r\n${GREEN_COLOR}安装软件包 ...${RES}\r\n"
	echo -e "${GREEN_COLOR}更改api权限.${RES}\r\n"
	sudo chmod -R 0777 $dir/*.cgi
	if [ $? -ne 0 ]; then
		echo -e "${RED_COLOR}更改权限失败.${RES}\r\n"
		sudo rm -rf $dir
		exit 1
	fi
	echo -e "\r\n${GREEN_COLOR}安装完成!${RES}\r\n"
)


Check
if [ $? -eq 0 ]; then
	 Download
else
	exit 1
fi
if [ $? -eq 0 ]; then
	 Install
fi		
