#!/bin/bash 

DIR_NAME="$(cd "$(dirname "$0")" && pwd)"
source "$DIR_NAME"/tools.sh
total=$(systemctl list-units --type=service --state=running | grep ".service" | wc -l)

STATUS=$(get_status_color "$total" 30 60)
echo -e "$STATUS Total running services detected: $total"

while read line; do 
	service=$(echo "$line" | awk '{print $1}')
	echo "Detected service: $service"
done< <(systemctl list-units --type=service --state=running | grep ".service")

