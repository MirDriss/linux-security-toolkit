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
        echo -e "${color}[$level] ${RESET}$message " | tee -a "$REPORT_FILE"
}

function check_dependencies(){
	local dependencies=("ss" "awk" "systemctl")
	local count=0
	for cmd in "${dependencies[@]}"
	do
		if ! command -v "$cmd" &> "/dev/null"; then  
			log_level CRITICAL "Dependency missing : $cmd"
			((count++))
		fi
	done
	
	if [ "$count" -gt 0 ]; then
		log_level CRITICAL "Please install missing dependencies to run the audit. Aborting."
		exit 1
	fi
	
	log_level OK "All dependencies are satisfied."
}
	

function check_root(){
	if [ "$EUID" -ne 0 ]; then
		log_level CRITICAL "script has to be exectued by the root user"
		exit 1
	fi
	log_level INFO "Running with root privileges."
}
