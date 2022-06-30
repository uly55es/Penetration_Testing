# SMB
## Server Message Block Protocol

Client-server communication protocol used for sharing access to files, printers, serial ports and other resources on a network. Known as a response-request protocol, meaning it transmits messages between the client and server to establish a connection.

Runs on Microsoft Windows OS. Samba, an open source server that supports SMB protocol, is available for Unix.

## Enumeration

### nmap

### enum4linux

Tool used to enumerate SMB shares on both Windows and Linux systems.

[enum4linux Install](https://github.com/portcullislabs/enum4linux)

```bash
enum4linux [options] [ip]
```

```markdown
| Tag |   Functions  |
| --- |   ---------  |
| -U  | get userlist |
| -M  | get machine list |
| -N  | get namelist dump (different from -U and -M) |
| -S  | get sharelist |
| -P  | get password policy information |
| -G  | get group and member list | 
| -a  | all of the above (full basic enumeration) |
```

## Exploitation

Method: misconfiguration

* Method breakdown

- the SMB share location
- the name of an interesting SMB share

* SMBClient

[SMBClient Install](https://www.samba.org/samba/docs/current/man-html/smbclient.1.html)

Remotely access the SMB share:

```bash
smbclient //[IP]/[SHARE]

-U [name] : to specify the user
-p [port] : to specify the port
```

```bash
smbclient //10.10.187.83/profiles -U Anonymous
```
