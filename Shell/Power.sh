#!/bin/bash
time=$(date "+%Y-%m-%d %H:%M:%S")
for((i=0；i<60；i++));do
	status_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://localhost:5700")
	if [[ $status_code == 200 ]]; then
		curl -H "Content-Type:application/json" -X POST -d '{"message_type":"private","user_id":"1094890624","message":${time}"\n开机"}' "http://localhost:5700/send_msg"
		brwak
	fi
	sleep 10
done
