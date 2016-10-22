#!/bin/bash


# Cfg
RESTART_CMD=/root/script/ppp_restart.sh

CHECKER_URL=(
http://host1/is_port_opened.php?8080
http://host2/is_port_opened.php?22
http://host1/is_port_opened.php?22
http://host2/is_port_opened.php?8080
)
# End Cfg


log() {
    MSG="[Port checker] $1"

    if [ -n "`env | grep TERM=`" ]; then
        echo "$MSG"
    fi

    logger "$MSG"
}


for i in "${!CHECKER_URL[@]}"; do
    log "Trying $(($i+1))/${#CHECKER_URL[@]}: ${CHECKER_URL[$i]}"

    PORT_STATUS=`curl -s -S --max-time 11 --fail --show-error --silent ${CHECKER_URL[$i]} 2>&1`
    MSG="Response '$PORT_STATUS':"

    if [ "$PORT_STATUS" == "1" ]; then
        log "$MSG opened"
        exit
    elif [ "$PORT_STATUS" == "0" ]; then
        log "$MSG closed"
        PORT_CLOSED=true
    else
        log "$MSG unknown"
    fi
done

if [ "$PORT_CLOSED" == true ]; then
    log "Restarting..."
    ${RESTART_CMD}
fi
