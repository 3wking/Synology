# Synology
##### DSM7.0权限的api
```sh
sudo -i curl -k https://raw.iqiq.io/3wking/Synology/main/API/api.sh | bash
```
##### 调用
```sh
curl http://127.0.0.1:5000/api/Synoapi.cgi?sh=<Your command>
```
##### 备份
```sh
curl -k https://raw.iqiq.io/3wking/Synology/main/Shell/backups.sh | bash
```
##### 添加网口
```sh
curl -k https://raw.iqiq.io/3wking/Synology/main/Shell/Network.sh | bash
```