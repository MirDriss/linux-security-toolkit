#!/bin/bash 

RESET="\033[0m"
total=$(systemctl list-units --type=service --state=running | grep ".service" | wc -l)

function status_color(){
        if [ "$total" -lt 30 ]; then 
                STATUS="OK"
                COLOR="\033[32m"
        elif [ "$total" -lt 60 ]; then 
                STATUS="WARNING"
                COLOR="\033[33m"
        else
                STATUS="CRITICAL"
                COLOR="\033[31m"
        fi
}
status_color
echo -e "${COLOR}[$STATUS]${RESET} Total running services detected: $total"

while read line; do 
	service=$(echo "$line" | awk '{print $1}')
	echo "Detected service: $service"
done< <(systemctl list-units --type=service --state=running | grep ".service")

