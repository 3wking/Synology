#!/bin/bash
for((i=1;i<=60;i++));do
	echo "运行次数"$i
	Synoapi
	status_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://127.0.0.1:1001")
	if [[ $status_code == 200 ]]; then
		synodsmnotify -t dsm @administrators "API通知" "API启动成功" >/dev/null
		break
	fi
	sleep 10
done
