# Hashcat

[man hashcat](https://manpages.org/hashcat)

## Summary
INCOMPLETE - more to come...

* [Installation](#installation)
* [Basic Commands](#basic-commands)
	* [Example](#example)	
* [Attack Mode](#attack-mode)
	* [Straight/Dictionary Attack](#straight/dictionary-attack)
	* [Combination Attack](#combination-attack)
	* [Brute Force Attack](#brute-force-attack)
		* [Masks and Built-In Charsets](#masks-and-built-in-charsets)		
* [Hash Types](#hash-types)

### Installation 

```bash
apt install cmake build-essential -y
apt install checkinstall git -y
git clone https://github.com/hashcat/hashcat.git
make && make install
```

## Basic Commands

```bash
# Help
hashcat --help

# Identify Hash
hashcat --identify <hash_file>

# Restore session
hashcat --restore
hashcat --restore --session session_name
```

### Example
```bash
hashcat -a 0 -m 100 --session session1 <hash_file> <wordlist>

# Restore if terminated
hashcat --restore --session session1
```

## Attack Mode

| `-a` options | Attack Mode |
| --- | --- |
| `0` | Straight |
| `1` | Combination |
| `3` | Brute-force |
| `6` | Hybrid Wordlist + Mask |
| `7` | Hybrid Mask + Wordlist |
| `9` | Association |

### Straight/Dictionary Attack

```bash
hashcat -a 0 -m 100 --session session1 <hash_file> <wordlist>
```

### Combination Attack

Combines two dictionaries to make passwords

```bash
hashcat -a 1 -m 100 <hash_file> <wordlist1> <wordlist2>
```

Password `admin` in wordlist1 will be combined with `dog` in wordlist2 to create `admindog`

Can append or prepend additional characters

```bash
hashcat -a 1 -m 100 --rule-left='$#' --rule-right='$$' <wordlist1> <wordlist2>
```

### Brute Force Attack

Example - brute force with length of 8:

```bash
hashcat -a 3 -m 100 -O ?u?1?s?d <hash_file> ?1?1?1?1?1?1?1?1
```

Note: `-O` limits password length

#### Mask and Built-in Charsets

| Option | Charset |
| --- | --- |
| ?l | abcdefghijklmnopqrstuvwxyz |
| ?u | ABCDEFGHIJKLMNOPQRSTUVWXYZ |
| ?d | 0123456789 |
| ?h | 0123456789abcdef |
| ?H | 0123456789ABCDEF |
| ?s | <space>!"#$%&'()*+,-./:;<=>?@[]^_`{|}~ |
| ?a | ?l?u?d?s |
| ?b | 0x00 - 0xff |

### Hash Types

| Option | Hash |
| --- | --- |
| 0 | MD5 |
| 10 | md5($pass.$salt) |
| 20 | md5($salt.$pass) |
| 30 | md5(unicode($pass).$salt) |
| 40 | md5($salt.unicode($pass)) |
| 50 | HMAC-MD5 (key | $pass) |
| 60 | HMAC-MD5 (key | $salt) |
| 100 | SHA1 |
| 110 | sha1($pass.$salt) |
| 120 | sha1($salt.$pass) |
| 130 | sha1(unicode($pass).$salt) |
| 140 | sha1($salt.unicode($pass)) |
| 150 | HMAC-SHA1 (key | $pass) |
| 160 | HMAC-SHA1 (key | $salt) |
| 200 | MySQL323 |
| 300 | MySQL4.1/MySQL5 |
| 400 | phpass, MD5(Wordpress), MD5(phpBB3), MD5(Joomla) |
| 500 | md5crypt, MD5(Unix), FreeBSD MD5, Cisco-IOS MD5 |
| 900 | MD4 |
| 1000 | NTLM |
| 1100 | Domain Cached Credentials (DCC), MS Cache |
| 1400 | SHA256 |
| 1410 | sha256($pass.$salt)|
| 1420 | sha256($salt.$pass)|
| 1430 | sha256(unicode($pass).$salt)|
| 1431 | base64(sha256(unicode($pass)))|
| 1440 | sha256($salt.unicode($pass))|
| 1450 | HMAC-SHA256 (key | $pass)|
| 1460 | HMAC-SHA256 (key | $salt)|
| 1600 | md5apr1, MD5(APR), Apache MD5|
| 1700 | SHA512|
| 1710 | sha512($pass.$salt)|
| 1720 | sha512($salt.$pass)|
| 1730 | sha512(unicode($pass).$salt)|
| 1740 | sha512($salt.unicode($pass))|
| 1750 | HMAC-SHA512 (key | $pass)|
| 1760 | HMAC-SHA512 (key | $salt)|
| 1800 | SHA-512(Unix)|
| 2400 | Cisco-PIX MD5|
| 2410 | Cisco-ASA MD5|
| 2500 | WPA/WPA2|
| 2600 | Double MD5|
| 3200 | bcrypt, Blowfish(OpenBSD)|
| 3300 | MD5(Sun)|
| 3500 | md5(md5(md5($pass)))|
| 3610 | md5(md5($salt).$pass)|
| 3710 | md5($salt.md5($pass))|
| 3720 | md5($pass.md5($salt))|
| 3800 | md5($salt.$pass.$salt)|
| 3910 | md5(md5($pass).md5($salt))|
| 4010 | md5($salt.md5($salt.$pass))|
| 4110 | md5($salt.md5($pass.$salt))|
| 4210 | md5($username.0.$pass)|
| 4300 | md5(strtoupper(md5($pass)))|
| 4400 | md5(sha1($pass))|
| 4500 | Double SHA1|
| 4600 | sha1(sha1(sha1($pass)))|
| 4700 | sha1(md5($pass))|
| 4800 | MD5(Chap), iSCSI CHAP authentication|
| 4900 | sha1($salt.$pass.$salt)|
| 5000 | SHA-3(Keccak)|
| 5100 | Half MD5|
| 5200 | Password Safe SHA-256|
| 5300 | IKE-PSK MD5|
| 5400 | IKE-PSK SHA1|
| 5500 | NetNTLMv1-VANILLA / NetNTLMv1-ESS|
| 5600 | NetNTLMv2|
| 5700 | Cisco-IOS SHA256|
| 5800 | Android PIN|
| 6300 | AIX {smd5}|
| 6400 | AIX {ssha256}|
| 6500 | AIX {ssha512}|
| 6700 | AIX {ssha1}|
| 6900 | GOST, GOST R 34.11-94|
| 7000 | Fortigate (FortiOS)|
| 7100 | OS X v10.8+|
| 7200 | GRUB 2|
| 7300 | IPMI2 RAKP HMAC-SHA1|
| 7400 | sha256crypt, SHA256(Unix)|
| 7900 | Drupal7|
| 8400 | WBB3, Woltlab Burning Board 3|
| 8900 | scrypt|
| 9200 | Cisco $8$|
| 9300 | Cisco $9$|
| 9800 | Radmin2|
| 10000 | Django (PBKDF2-SHA256)|
| 10200 | Cram MD5|
| 10300 | SAP CODVN H (PWDSALTEDHASH) iSSHA-1|
| 11000 | PrestaShop|
| 11100 | PostgreSQL Challenge-Response Authentication (MD5)|
| 11200 | MySQL Challenge-Response Authentication (SHA1)|
| 11400 | SIP digest authentication (MD5)|
| 99999 | Plaintext|

