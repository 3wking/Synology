# Synology
##### DSM7.0权限的api
```sh
sudo -i curl -k https://cdn.jsdelivr.net/gh/3wking/Synology@main/Shell/api.sh | bash
```
##### 调用
```sh
#安装前里添加
api_url="http://127.0.0.1:1001"
status_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST $api_url)
if [[ $status_code == 200 ]]; then
	dir=$(cd `dirname $0`;pwd)
	privilege="`echo $dir | awk -F '/scripts' '{print $1}'`/conf/privilege"
	ret=$(curl -d "dir=$privilege" -X POST $api_url)
	if [[ $ret != "OK" ]]; then
		echo "调用api失败"
		exit 1
	fi
else
	echo "未启用api"
	exit 1
fi
```
##### 备份
```sh
curl -k https://cdn.jsdelivr.net/gh/3wking/Synology@main/Shell/backups.sh | bash
```
##### 添加网口
```sh
curl -k https://cdn.jsdelivr.net/gh/3wking/Synology@main/Shell/Network.sh | bash
```
##### 开机通知
```sh
curl -k https://cdn.jsdelivr.net/gh/3wking/Synology@main/Shell/Power.sh | bash
```