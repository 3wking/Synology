#!/bin/bash
#�״�����
if ! ps aux | grep -w mysqld | grep -v grep >/dev/null 2>&1
Synoapi
synodsmnotify -t dsm @administrators "API֪ͨ" "API����" >/dev/null
else
synodsmnotify -t dsm @administrators "API֪ͨ" "API������" >/dev/null
fi
#�����ػ�
while :
do
if ! ps aux | grep -w mysqld | grep -v grep >/dev/null 2>&1
then
Synoapi
synodsmnotify -t dsm @administrators "API֪ͨ" "API����" >/dev/null
fi
sleep 600
done