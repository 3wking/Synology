#!/bin/bash
time=$(date "+%Y-%m-%d %H:%M:%S")
status_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://localhost:5700")
echo "statusssssssss code $status_code"
if [[ $status_code == 200 ]]; then
    curl -H "Content-Type:application/json" -X POST -d '{"message_type":"private","user_id":"1094890624","message":"123456"}' "http://localhost:5700/send_msg"
