# carrier-grade_NAT_restarter

This is a shell / php scripts for reconnect current internet connection in a case if checking port is closed.

My provider provides internet via PPPoE, but sometimes IPv4 address is from 100.64.0.0/10 network.  
This network is carrier-grade NAT: https://en.wikipedia.org/wiki/Carrier-grade_NAT

Because of this is NAT, all services running at your internet router / host are invisible from internet.

Fortunately, my provider gives a real "white" ip address after some reconnect attempts.

This bunch of scripts is for automatic checks / reconnects:
 - The main script 'port_checker_and_restarter.sh' runs via cron
 - Second script 'is_port_opened.php' hosted somewhere - VDS/VPS/Shared hosting

Main script has list of url where second script hosted. If main script received '0' from second script,
then it means that checked port is closed and main script run reconnect command.
