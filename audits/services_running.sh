#!/bin/bash 

total=$(systemctl list-units --type=service --state=running | grep ".service" | wc -l)

echo "Total running services detected: $total"

while read line; do 
	service=$(echo "$line" | awk '{print $1}')
	echo "Detected service: $service"
done< <(systemctl list-units --type=service --state=running | grep ".service")

