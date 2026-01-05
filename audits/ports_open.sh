#!/bin/bash 

RESET="\033[0m"

total=$(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq | wc -l)
function status_color(){
	if [ "$total" -lt 5 ]; then 
		STATUS="OK"
		COLOR="\033[32m"
	elif [ "$total" -lt 10 ]; then 
		STATUS="WARNING"
		COLOR="\033[33m"
	else
		STATUS="CRITICAL"
		COLOR="\033[31m"
	fi
}
status_color
echo -e "${COLOR}[$STATUS]${RESET} Total ports open detected: $total"
while read port; do 
	echo "Port open detected: $port"
	 ((count++))
done < <(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq)
