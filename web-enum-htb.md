# Web Enumeration

## Gobuster

Directory/File Brute Forcing:
```bash
gobuster dir -u http://10.10.10.121/ -w /usr/share/dirb/wordlists/common.txt
```

[HTTP Status Codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)

Install Seclists:
```bash
git clone https://github.com/danielmiessler/SecLists
```
Or:
```bash
sudo apt install seclists -y
```

DNS Subdomain Enumeration:
Add DNS server to the /etc/resolv.conf file. 
```bash
gobuster dns -d inlanefreight.com -w /usr/share/SecLists/Discovery/DNS/namelists.txt
```

## Banner Grabbing/Web Server Headers
```bash
curl -IL https://www.inlanefreight.com
```

Also can use [Eyewitness](https://github.com/FortyNorthSecurity/EyeWitness)

## Whatweb
Extract the version of web servers, supporting frameworks, and applications using whatweb:
```bash
whatweb 10.10.10.10
```
```bash
whatweb --no-errors 10.10.112.10/24
```

<kbd>Ctrl+U</kbd>
for source code

