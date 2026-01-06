#!/bin/bash 

DIR_AUDIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR_AUDIT"/tools.sh
total=$(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq | wc -l)
status=$(get_status_color "$total" 5 10) 
echo -e "$status Total ports open detected: $total"
while read port; do 
	echo "Port open detected: $port"
	 ((count++))
done < <(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq)
