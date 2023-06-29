#!/bin/bash
#首次启动
if ! ps aux | grep -w mysqld | grep -v grep >/dev/null 2>&1
then
Synoapi
synodsmnotify -t dsm @administrators "API通知" "API启动" >/dev/null
else
synodsmnotify -t dsm @administrators "API通知" "API已启动" >/dev/null
fi
#进程守护
while :
do
if ! ps aux | grep -w mysqld | grep -v grep >/dev/null 2>&1
then
Synoapi
synodsmnotify -t dsm @administrators "API通知" "API启动" >/dev/null
fi
sleep 600
done