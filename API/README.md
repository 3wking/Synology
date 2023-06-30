# API
##### DSM7.0权限的api
```sh
sudu curl -k https://cdn.jsdelivr.net/gh/3wking/Synology@main/Shell/install_api.sh | bash
```
##### 调用
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
##### 开机自启
```sh
#任务计划
sudo -i curl -k https://cdn.jsdelivr.net/gh/3wking/Synology@main/Shell/api.sh | bash
```
##### 删除api
```sh
rm -f /usr/local/bin/Synoapi
```