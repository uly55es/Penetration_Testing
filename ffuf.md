# ffuf - Fuzz Faster U Fool

## Summary
Tool used for web enumeration, fuzzing, and directory brute forcing.

[Install Guide](https://github.com/ffuf/ffuf#installation)

## Table of Contents
- [Basics](#basics)
- [Finding Pages and Directories](#finding-pages-and-directories)
- [Using Filters](#using-filters)
- [Fuzzing Parameters](#fuzzing-parameters)
- [Finding vhosts and subdomains](#finding-vhosts-and-subdomains)
- [Proxifying ffuf traffic](#proxifying-ffuf-traffic)
- [Other Options](#other-options)
  +  

## Basics

Minimum requirements: `-u` to specify URL, `-w` to specify wordlist.

`FUZZ` - default keyword; tells ffuf where the wordlist entries will be injected.

```bash
ffuf -u http://10.10.155.135/FUZZ -w /usr/share/seclists/Discovery/Web-Content/big.txt
```

Can define custom keyword using `wordlist:KEYWORD`

Example:
```bash
ffuf -u http://10.10.155.135/EXAMPLE -w /usr/share/seclists/Discovery/Web-Content/big.txt:EXAMPLE
```

Help page:
```bash
ffuf -h
```

## Finding Pages and Directories

Can start with generic list for enumeration:
```bash
ffuf -u http://10.10.155.135/FUZZ -w /usr/share/seclists//Discovery/Web-Content/raft-medium-files-lowercase.txt
```
In the interest of efficiency, it can be assumed `index.<extension>` is the default page on most websites; can try common extensions for just the index page.
This can help determine what programming language or languages the site uses.
```bash
/usr/share/seclists/Discovery/Web-Content/web-extensions.txt
```
```bash
ffuf -u http://10.10.155.135/indexFUZZ -w /usr/share/seclists/Discovery/Web-Content/web-extensions.txt
```
Can result in false positives, so we can specify the extensions to add onto the `FUZZ` wordlist:
```bash
ffuf -u http://10.10.155.135/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt -e .php,.txt
```
Fuzzing for directories:
```bash
ffuf -u http://10.10.155.135/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt
```

## Using Filters

Can add filters, such as filtering out HTTP status codes
```bash
# filter code
-fc 403
```
```bash
ffuf -u http://10.10.155.135/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files-lowercase.txt -fc 403
```
Filter out multiple codes:
```bash
# Match code
-mc 200
```
```bash
ffuf -u http://10.10.155.135/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files-lowercase.txt -mc 200
```
Could be beneficial to see what requests the server doesn't handle ( Ex. `-mc 500`).

Can also receive false positives with files beginning with a dot (eg. `.htgroups`,`.php`). While they receive a 403 Forbidden code, they don't actually exist. 
Using `-fc 403` could hide valuable files.

Instead, use a Regex to match all files beginning with `.`:
```bash
ffuf -u http://10.10.155.135/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files-lowercase.txt -fr '/\..*'
```

## Fuzzing Parameters

Discovering a vulnerable parameter could lead to file inclusion, path disclosure, XSS, SQL injection, or even command injection.
```bash
ffuf -u 'http://10.10.227.19/sqli-labs/Less-1/?FUZZ=1' -c -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt -fw 39
```
```bash
ffuf -u 'http://10.10.227.19/sqli-labs/Less-1/?FUZZ=1' -c -w /usr/share/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt -fw 39
```
If a parameter is found accepting integer values, we can then fuzz the values:
```bash
# Read a wordlist form stdout
-w -
```
```bash
# Generate numbers 0-255
ruby -e '(0..255).each{|i| puts i}' | ffuf -u 'http://10.10.227.19/sqli-labs/Less-1/?id=FUZZ' -c -w - -fw 33
```
Can also use ffuf for wordlist-based brute-force attacks, ex. trying passwords on an authentication page:
```bash
# POST method specified with -X, data with -d
# Specify a custom header with -H 'Content-Type: application/x-www-form-urlencoded' (ffuf doesn't set this automatically)
ffuf -u http://10.10.227.19/sqli-labs/Less-11/ -c -w /usr/share/seclists/Passwords/Leaked-Databases/hak5.txt -X POST -d 'uname=Dummy&passwd=FUZZ&submit=Submit' -fs 1435 -H 'Content-Type: application/x-www-form-urlencoded'
```

***

## Finding vhosts and subdomains

Example:
```bash
ffuf -u http://FUZZ.mydomain.com -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```
Some subdomains may not be resolvable by DNS. To try finding private subdomains, we use the HTTP header:
```bash
ffuf -u http://FUZZ.mydomain.com -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -fs 0
```
```bash
ffuf -u http://mydomain.com -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -H 'Host: FUZZ.mydomain.com' -fs 0
```

## Proxifying ffuf traffic

Can send all ffuf traffic through a web proxy (HTTP or SOCK5):
```bash
ffuf -u http://10.10.227.19/ -c -w /usr/share/seclists/Discovery/Web-Content/common.txt -x http://127.0.0.1:8080
```
Send only matches to your proxy for replaying:
```bash
ffuf -u http://10.10.227.19/ -c -w /usr/share/seclists/Discovery/Web-Content/common.txt -replay-proxy http://127.0.0.1:8080
```

## Other Options

### Ignore wordlist comments
```bash
-ic
```
### Save output to markdown file
``` bash
-of md file.md
```
### Re-use raw HTTP request file
```bash
-request
```
