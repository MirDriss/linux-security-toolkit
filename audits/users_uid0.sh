#!/bin/bash 

flag=0
total=$(awk -F: '{print $1}' /etc/passwd | wc -l)
echo "total users detected: $total"

while read line; do 
	user=$(echo "$line" | cut -d: -f1)
	privilege=$(echo "$line" | awk -F: '{print $3}')
	if [ "$privilege" -eq 0 ]; then 
		((flag++))
		echo "⚠️ Privileged account detected: $user"
	fi
done < /etc/passwd

if [ "$flag" -eq 1 ]; then 
	echo "No extra privileged accounts detected."
elif [ "$flag" -eq 0 ]; then 
	echo "CRITICAL: No UID 0 account detected. System integrity may be compromised."
else
	echo "ALERT: Multiple UID 0 accounts detected. Potential privilege escalation risk."
fi
