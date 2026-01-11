#!/bin/bash 

DIR_SCRIPT="$(cd "$(dirname "$0")" && pwd)"
source "$DIR_SCRIPT"/tools.sh

ROOT_LOGIN_PASSIVE=$(cat /etc/ssh/sshd_config | grep ^#PermitRootLogin)
echo "$ROOT_LOGIN_PASSIVE"
ROOT_LOGIN_ACTIVE=$(cat /etc/ssh/sshd_config | grep ^PermitRootLogin)
echo "$ROOT_LOGIN_ACTIVE"
