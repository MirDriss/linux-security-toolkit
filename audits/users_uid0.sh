#!/bin/bash 
DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"
source "$DIR_SCRIPT"/tools.sh
flag=0
total=$(awk -F: '{print $1}' /etc/passwd | wc -l)
log_level INFO "total users detected: $total"

while read line; do 
	user=$(echo "$line" | cut -d: -f1)
	privilege=$(echo "$line" | awk -F: '{print $3}')
	if [ "$privilege" -eq 0 ]; then 
		((flag++))
		log_level WARNING "⚠️ Privileged account detected: $user"
	fi
done < /etc/passwd

if [ "$flag" -eq 1 ]; then 
	log_level OK "No extra privileged accounts detected."
else
	log_level CRITICAL "ALERT: Multiple UID 0 accounts detected. Potential privilege escalation risk."
fi
