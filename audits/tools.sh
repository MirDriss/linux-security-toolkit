#!/bin/bash 

RESET="\033[0m"
RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
BLUE="\033[34m"
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

function log_level(){
        level="$1"
        message="$2"
        case "$level" in 
                INFO) color="$BLUE" ;;
                OK) color="$GREEN" ;;
                WARNING) color="$YELLOW" ;;
                ALERT|CRITICAL) color="$RED" ;;
                *) color="$RESET" ;;
        esac 
        # Write in the terminal 
        echo -e "${color}[$level] ${RESET}$message " 
	if [ -n "REPORT_FILE" ]; then 
		 # Write in the file 
        	echo "[$level] $message" >> "$REPORT_FILE"
	fi
}
