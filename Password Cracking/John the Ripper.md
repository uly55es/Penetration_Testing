# John the Ripper

* Download and Use Hash-Identifier

```bash
wget https://gitlab.com/kalilinux/packages/hash-identifier/-/raw/kali/master/hash-id.py
python3 hash-id.py
```

* Basic Syntax

```bash
john [options] [path to file]
```

* Automatic Cracking

```bash
john --wordlist=[path to wordlist] [path to file]
```

* Format Specific Cracking

```bash
john --format=[format] --wordlist=[path to wordlist] [path to file]
john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt example.txt
```

List All Formats

```bash
john --list=formats
john --list=formats | grep -iF "[hash type]"
```

* /etc/shadow Hashes

```bash
unshadow passwd.txt shadow.txt > passwords.txt
```

* Single Crack Mode

```bash
john --single --format=[format] [path to file]
# Preface hash in file with known username, i.e. mike:1efee03cdcb96d90ad48ccc7b8666033
```
