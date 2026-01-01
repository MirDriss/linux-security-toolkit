#!/bin/bash 

count=0
while read port; do 
	echo "Port open detected: $port"
	 ((count++))
done < <(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq)

if [ "$count" -eq 0 ]; then 
	echo "No open ports detected."
fi
