#!/bin/bash
#首次启动
if ! ps aux | grep -w mysqld | grep -v grep >/dev/null 2>&1
then
Synoapi
echo "启动api"
fi
#进程守护
while :
do
if ! ps aux | grep -w mysqld | grep -v grep >/dev/null 2>&1
then
Synoapi
echo "启动api进程"
fi
sleep 600
done