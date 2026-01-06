#!/bin/bash 

RESET="\033[0m"
RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"

function get_status_color(){
	local sum="$1"
	local warn="$2"
	local crit="$3"
	if [ "$sum" -lt "$warn" ]; then 
		echo -e "${GREEN}[OK]${RESET}"
	elif [ "$sum" -lt "$crit" ]; then 
		echo -e "${YELLOW}[WARNING]${RESET}"
	else
		echo -e "${RED}[CRITICAL]${RESET}"
	fi
} 
