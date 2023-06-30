#!/bin/bash
#首次启动
if ! ps aux | grep -w Synoapi | grep -v grep >/dev/null 2>&1
then
bash Synoapi
echo -e "\e[1;32m启动api\e[0m"
sleep 5s
fi
#进程守护
while :
do
if ! ps aux | grep -w Synoapi | grep -v grep >/dev/null 2>&1
then
bash Synoapi
echo -e "\e[1;32m守护启动api进程\e[0m"
fi
sleep 600
done