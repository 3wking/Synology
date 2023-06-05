# Docker
## Docker命令
#### 拉取镜像
###### 默认
```sh
docker pull <镜像名>
```sh
###### amd64
```sh
docker pull --platform amd64 <镜像名>
```sh
###### arm64
```sh
docker pull --platform arm64 <镜像名>
```sh
#### 容器操作
###### 启动容器
```sh
docker start <容器名>
```
###### 停止容器
```sh
docker stop <容器名>
```
###### 查看所有容器
```sh
docker ps -a
```
###### 查看所有容器ID
```sh
docker ps -a -q
```
###### 查看容器IP
```sh
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
```
## 镜像
##### ubuntu
```sh
docker pull ubuntu
```
##### debian
```sh
docker pull debian
```
## Shell
##### ssh
```sh
curl -k https://raw.iqiq.io/3wking/Synology/main/Docker/ssh.sh | bash
```
