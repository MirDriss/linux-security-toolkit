#!/bin/bash 

total=$(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq | wc -l)
echo "Total ports open detected: $total"
while read port; do 
	echo "Port open detected: $port"
	 ((count++))
done < <(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq)
