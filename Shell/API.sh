#!/bin/bash
#首次启动
Synoapi
synodsmnotify -t dsm @administrators "API通知" "API启动成功" >/dev/null
#进程守护
while :
do
if ! ps aux | grep -w mysqld | grep -v grep >/dev/null 2>&1
then
Synoapi
synodsmnotify -t dsm @administrators "API通知" "API启动成功" >/dev/null
fi
sleep 600
done