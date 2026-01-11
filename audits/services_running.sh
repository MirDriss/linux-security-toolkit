#!/bin/bash 

DIR_NAME="$(cd "$(dirname "$0")" && pwd)"
source "$DIR_NAME"/tools.sh
total=$(systemctl list-units --type=service --state=running | grep ".service" | wc -l)

if [ "$total" -lt 30 ]; then
    level="OK"
elif [ "$total" -lt 60 ]; then
    level="WARNING"
else
    level="CRITICAL"
fi
log_level "$level" "Total running services detected: $total"

while read line; do 
	service=$(echo "$line" | awk '{print $1}')
	log_level INFO "Detected service: $service"
done< <(systemctl list-units --type=service --state=running | grep ".service")

