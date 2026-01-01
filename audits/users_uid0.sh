#!/bin/bash 

flag=0
while read line; do 
	user=$(echo "$line" | cut -d: -f1)
	privilege=$(echo "$line" | awk -F: '{print $3}')
	if [ "$privilege" -eq 0 ]; then 
		((flag++))
		echo "⚠️ Privileged account detected: $user"
	fi
done < /etc/passwd

if [ "$flag"==1 ]; then 
	echo "No extra privileged accounts detected."
fi
