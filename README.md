# Synology
## DSM7.0 root权限的api
##### 安装api
```sh
sudo curl -k https://raw.fastgit.ixmu.net/3wking/Synology/main/API/install_api.sh | bash
```
##### 调用api
```sh
#preinst
api_url="http://127.0.0.1:1001"
status_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST $api_url)
if [[ $status_code == 200 ]]; then
	dir=$(cd `dirname $0`;pwd)
	privilege="`echo $dir | awk -F '/scripts' '{print $1}'`/conf/privilege"
	ret=$(curl -d "dir=$privilege" -X POST $api_url)
	if [[ $ret != "OK" ]]; then
		echo "<br><p style=\"color:red;\">调用api失败.</p>"
		echo "<p style=\"color:red;\">退出安装.</p>"
		exit 1
	fi
else
	echo "<br><p style=\"color:red;\">未启用api.</p>"
	echo "<p style=\"color:red;\">退出安装.</p>"
	exit 1
	fi
```
##### 开启api
```sh
sudo /usr/syno/bin/Synoapi
```
##### 关闭api
```sh
sudo killall -9 Synoapi
```
##### 删除api
```sh
sudo rm -f /usr/syno/bin/Synoapi
```
##### 查看api进程
```sh
ps aux | grep -w Synoapi | grep -v grep
```
##### 开机自启
```sh
#任务计划
sudo curl -k https://raw.fastgit.ixmu.net/3wking/Synology/main/Shell/api.sh | bash
```

## 其他命令
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