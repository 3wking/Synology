# Docker
## Docker命令
#### 镜像操作
###### 搜索镜像
```sh
docker search <image_name>
```
###### 拉取镜像
```sh
docker pull <image_name>
```sh
###### 拉取amd64
```sh
docker pull --platform amd64 <image_name>
```
###### 拉取arm64
```sh
docker pull --platform arm64 <image_name>
```sh
###### 查看镜像
```sh
docker images
```
###### 镜像的详细信息
```sh
docker inspect <image_name>
```
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
curl -k https://cdn.jsdelivr.net/gh/3wking/Synology@main/Docker/ssh.sh | bash
```
