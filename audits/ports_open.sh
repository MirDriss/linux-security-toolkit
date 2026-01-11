#!/bin/bash 

DIR_AUDIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR_AUDIT"/tools.sh
total=$(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq | wc -l)
if [ "$total" -lt 5 ]; then
    level="OK"
elif [ "$total" -lt 10 ]; then
    level="WARNING"
else
    level="CRITICAL"
fi
log_level "$level" "Total ports open detected: $total"
while read port; do 
	log_level INFO "Port open detected: $port"
done < <(ss -tulnp | tail -n +2 | awk '{print $5}' | awk -F: '{print $NF}' | sort | uniq)
