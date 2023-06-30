#!/bin/bash
#首次启动
if ! ps aux | grep -w Synoapi | grep -v grep >/dev/null 2>&1
then
echo -e "\e[1;32m启动api\e[0m"
sudo /usr/syno/bin/Synoapi
sleep 5s
fi
#进程守护
while :
do
if ! ps aux | grep -w Synoapi | grep -v grep >/dev/null 2>&1
then
echo -e "\e[1;32m守护启动api进程\e[0m"
sudo /usr/syno/bin/Synoapi
fi
sleep 600
done