Null Scan
does not set a flag; does not trigger a response
lack of reply indicates port is open or firewall block

`nmap -sN <TARGET>`

Requires root privileges

FIN Scan
Similar to a NULL Scan

`nmap -sF <TARGET>`

Xmas Scan
Sets the FIN, PSH, URG, simultaneously

`nmap -sX <TARGET>`

All are useful when scanning target behind stateless firewall

TCP ACK Scan
Useful when a firewall is in front of target; discover firewall 
rule set and config

`nmap -sA <TARGET>`

Window Scan
might respond with closed; indicates firewall did not block them

`nmap -sW <TARGET>`

Custom Scan

`nmap --scanflags RSTSYNFIN`

IP Spoofing
Need to monitor the network traffic

`nmap -S <SPOOFED_IP> <TARGET>`

-e to specify network interface, -Pn to disable ping

`nmap -e <NET_INTERFACE> -Pn -S <SPOOFED_IP> <TARGET>`

On same subnet, spoof MAC address

`--spoof-mac <SPOOFED_MAC>`

Specify different scan sources

`nmap -D <DECOY1>,<ME>,<DECOY2> <TARGET>`
<RND>

Fragment Packets

`-f`


