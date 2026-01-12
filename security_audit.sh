#!/bin/bash

DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"
DIRECTORY="reports"
EXT="txt"
REPORT_FORMAT="${REPORT_FORMAT:="txt"}"
if [ ! -d "$DIRECTORY" ]; then
        mkdir "$DIRECTORY"
fi
ANY_AUDIT=false
RUN_USERS=false
RUN_SERVICES=false
RUN_PORTS=false
FORMET_SET=false
while [[ "$#" -gt 0 ]]
do 
	case "$1" in 
	--ports)
		RUN_PORTS=true
		ANY_AUDIT=true
		shift
		;;
	--users)
		RUN_USERS=true
		ANY_AUDIT=true
		shift
		;;
	--services)
		RUN_SERVICES=true
		ANY_AUDIT=true
		shift
		;;
	--format=txt)
		if [ "$FORMAT_SET" = true ]; then 
			echo "Error: --format specified multiple times"
			exit 1
		fi
		FORMAT_SET=true
		REPORT_FORMAT="txt"
		shift
		;;
	--format=json) 
		if [ "$FORMAT_SET" = true ]; then 
                        echo "Error: --format specified multiple times"
                        exit 1
                fi
                FORMAT_SET=true
		REPORT_FORMAT="json"
		shift
		;;
	--help)
		echo "Usage: sudo ./security_audit.sh [--users] [--ports] [--services]"
            	exit 0
            	;;
	*)
		echo "Option not recongnize : $1"
		exit 1
		;;	
	esac
done
if [ "$ANY_AUDIT" = false ]; then
	RUN_USERS=true
	RUN_SERVICES=true
	RUN_PORTS=true
fi

if [ "$REPORT_FORMAT" = "txt" ]; then 
	EXT="txt"
else 
	EXT="jsonl"
fi
export REPORT_FORMAT
export REPORT_FILE="$DIRECTORY/audit_$(date -I).${EXT}"
source "$DIR_SCRIPT"/audits/tools.sh
check_root
check_dependencies
if [ "$REPORT_FORMAT" = "txt" ]; then 
	echo -e "\n" | tee -a "$REPORT_FILE"
	echo -e "================ LINUX SECURITY AUDIT ================ \n" | tee -a "$REPORT_FILE"
fi
log_level INFO "Audit executed at $(date '+%Y-%m-%d %H:%M:%S') by $(hostname)" 
log_level INFO "------------------------"
log_level INFO "hostname: $(hostname)"
log_level INFO "Date: $(date)"
if [ "$REPORT_FORMAT" = "txt" ]; then 
	echo -e "\n" | tee -a "$REPORT_FILE"
fi
if [ "$RUN_USERS" = true ]; then 
	log_level INFO "--- Users audit ---"  
	"$DIR_SCRIPT"/audits/users_uid0.sh 
	if [ "$REPORT_FORMAT" = "txt" ]; then 
		echo -e "\n" | tee -a "$REPORT_FILE"
	fi
fi
if [ "$RUN_PORTS" = true ]; then 
	log_level INFO "--- Open ports audit ---" 
	"$DIR_SCRIPT"/audits/ports_open.sh
	if [ "$REPORT_FORMAT" = "txt" ]; then 
		echo -e "\n" | tee -a "$REPORT_FILE"
	fi
fi
if [ "$RUN_SERVICES" = true ]; then 
	log_level INFO "--- Running services audit ---"
	"$DIR_SCRIPT"/audits/services_running.sh
	if [ "$REPORT_FORMAT" = "txt" ]; then  
		echo -e "\n" | tee -a "$REPORT_FILE"
	fi
fi

