# Hashcat

## Table of Contents
- [Summary](#summary)
  + [Hashing](#hashing)
  + [Salt Added](#salt-added)
  + [Identification](#identification)
- [Hashid](#hashid)
  + [Hashid Install](#hashid-install)
  + [Hashid Usage](#hashid-usage)
- [Hashcat Hash Mode Reference](#hashcat-hash-mode-reference)
- 

***

## Summary
A potent and useful tool for performing password cracking attacks against a wide variety of algorithms.

#### Hashing
```bash
echo -n "p@ssw0rd" | md5sum
0f359740bd1cda994f8b55330c86d845
```
#### Salt Added
```bash
echo -n "p@ssw0rd123456" | md5sum
f64c413ca36f5cfe643ddbec4f7d92d0
```
#### Identification
```bash
$6$vb1tLY1qiY$M.1ZCqKtJBxBtZm1gRi8Bbkn39KU0YJW1cuMFzTRANcNKFKR4RmAQVk4rqQQCkaJT6wXqjUkFcA/qNxLyqW.U/
# First field is ID
$1$    : MD5
$2a$   : Blowfish
$2y$   : Blowfish, with correct handling of 8 bit characters
$5$    : SHA256
$6$    : SHA512
# Second field is the salt
# Third field is hash format
```

***

## Hashid
A Python tool, used to detect various kinds of hashes. Can be used to identify over 200 unique hash types.
 
[Full List of Supported Hashes](https://github.com/psypanda/hashID/blob/master/doc/HASHINFO.xlsx)
 
### Hashid Install
Install with  `pip`
```bash
pip install hashid
```
### Hashid Usage
Hash can be supplied as a command-line argument or using a file:
```bash
hashid '$apr1$71850310$gh9m4xcAn3MGxogwX/ztb.'
```
```bash
hashid hashes.txt
```
Can also provide the corresponding `Hashcat` hash mode with `-m`:
```bash
hashid '$DCC2$10240#tom#e4e938d12fe5974dc42a90120bd9c90f' -m
```
### [Hashcat Hash Mode Reference](https://hashcat.net/wiki/doku.php?id=example_hashes)

***

## Hashcat Overview
Download from [website](https://hashcat.net/hashcat/) using `wget` and then decompressed using the `7z` (7-Zip file archiver).
### Help Menu
```bash
hashcat -h
```
### Hashcat Install
```bash
sudo apt install hashcat
```
```bash
# Specify type of attack mode
-a
# Specify hash type
-m
```
| # | Mode |
| --- | --- |
| 0 | Straight |
| 1 | Combination |
| 3 | Brute-force |
| 6 | Hybrid Wordlist+Mask |
| 7 | Hybrid Mask+Wordlist |
### Hashcat - Example Hashes
```bash
hashcat --example-hashes | less
```
### Hashcat - Benchmark
```bash
hashcat -b -m 0
# Run benchmark on all hash modes
hashcat -b
```
### Hashcat - Optimizations
Optimize speed:
| Option | Description |
| --- | --- |
| Optimized Kernels | This is the -0 flag, which means `Enable optimized kernels (limits password length)`. This can take the estimated time from days to hours, so it is always recommended to run with `-0` first and then rerun after without the `-0` if your GPU is idle |
| Workload | This is the `-w` flag; `Enable a specific workload profile`. Default number is `2`, but if you want to use your computer while hashcat is running, set this to `1`. If you plan on the computer only running Hashcat, this can be set to `3`. |
> **NOTE:** The use of `--force` should be avoided. Disables safety checks, muting warnings, and bypoasses problems, which can lead to false positives, false negatives, malfunctions, etc.

***

## Dictionary Attack
### Wordlists
* [SecLists](https://github.com/danielmiessler/SecLists/tree/master/Passwords)
* [CrackStation Password Cracking Dictionary](https://crackstation.net/crackstation-wordlist-password-cracking-dictionary.htm)
```bash
hashcat -a 0 -m <hash type> <hash file> <wordlist>
```
```bash
hashcat -a 0 -m 1400 sha256_hash_example /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```

***

## Combination Attack
Takes in two word lists as input and creates combinations from them. 
```bash
hashcat -a 1 --stdout file1 file2
```
Syntax:
```bash
hashcat -a 1 -m <hash type> <hash file> <wordlist1> <wordlist2>
```
```bash
hashcat -a 1 -m 0 combination_md5 wordlist1 wordlist2
```

***

## Mask Attack
Used to generate words matching a specific pattern. This type of attack is useful when the pasword length or format is known. A mask can be created using static characters, or placeholders:
| Placeholder | Meaning |
| --- | --- |
| ?l | lower-case ASCII letters (a-z) |
| ?u | upper-case ASCII letters (A-Z) |
| ?d | digits (0-9) |
| ?h | 0123456789abcdef |
| ?H | 0123456789ABCDEF |
| ?s | special characters "(«space»!"#$%&'()+,-./:;<=>?@[]^_ |
| ?a | ?l?u?d?s |
| ?b |  0x00 - 0xff |
Can be combined with options `-1` to `-4` which can be used for custom placeholders.

[Custom Charsets](https://hashcat.net/wiki/doku.php?id=mask_attack)
```bash
hashcat -a 3 -m 0 md5_mask_example_hash -1 01 'ILFREIGHT?l?l?l?l?l20?1?d'
```
### Creating MD5 Hashes
```bash
echo -n 'ILFREIGHTabcxy2015' | md5sum | tr -d " -" > md5_mask_example_hash
```

***

## Hybrid Mode
A variation of the combination attack; multiple modes can be used together for a fine-tuned wordlist creation. Useful when you know or have a genreal idea of the organization's password policy or common password syntax.

Attack Mode `6`

Hybrid Attack using Wordlists:
```bash
hashcat -a 6 -m 0 hybrid_hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt '?d?s'
```
Attack mode `7` can be used to prepend characters to words using a given mask. 
```bash
hashcat -a 7 -m 0 hybrid_hash_prefix -1 01 '20?1?d' /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```

***

## Working with Rules
Rule-based attack is the most advanced and complex password cracking mode.

| Function | Description | Input | Output |
| --- | --- | --- | --- |
|l |	Convert all letters to lowercase |	InlaneFreight2020 |	inlanefreight2020 |
| u |	Convert all letters to uppercase |	InlaneFreight2020 |	INLANEFREIGHT2020 |
|c / C |	capitalize / lowercase first letter and invert the rest |	inlaneFreight2020 / Inlanefreight2020 |	Inlanefreight2020 / iNLANEFREIGHT2020 |
|t / TN |	Toggle case : whole word / at position N |	InlaneFreight2020 |	iNLANEfREIGHT2020|
|d / q / zN / ZN |	Duplicate word / all characters / first character / last character |	InlaneFreight2020 |	InlaneFreight2020InlaneFreight2020 / IInnllaanneeFFrreeiigghhtt22002200 / IInlaneFreight2020 / InlaneFreight20200 |
|{ / } |	Rotate word left / right |	InlaneFreight2020 |	nlaneFreight2020I / 0InlaneFreight202|
|^X / $X |	Prepend / Append character X |	InlaneFreight2020 (^! / $! ) 	|!InlaneFreight2020 / InlaneFreight2020!|
|r |	Reverse |	InlaneFreight2020 |	0202thgierFenalnI|

[Complete List of Functions](https://hashcat.net/wiki/doku.php?id=rule_based_attack#implemented_compatible_functions)

[Rejection Rules](https://hashcat.net/wiki/doku.php?id=rule_based_attack#rules_used_to_reject_plains)

> **NOTE:** Reject rules only work with hashcat-legacy or when using the -j or -k with Hashcat

### Rule Creation
#### Rules
```bash
c so0 si1 se3 ss5 sa@ $2 $0 $1 $9
```
The first letter word is capitalized with the c function. Then rule uses the substitute function s to replace o with 0, i with 1, e with 3 and a with @. At the end, the year 2019 is appended to it. Copy the rule to a file so that we can debug it.
#### Create a Rule File
```bash
echo 'so0 si1 se3 ss5 sa@ c $2 $0 $1 $9' > rule.txt
```
#### Store the Password in a File
```bash
echo 'password_ilfreight' > test.txt
```
Rules can be debugged using the "-r" flag to specify the rule, followed by the wordlist.
#### Debugging Rules
```bash
hashcat -r rule.txt test.txt --stdout
```
#### Cracking Passwords using Wordlists and Rules
```bash
hashcat -a 0 -m 100 hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt -r rule.txt
```
#### Default Rules
```bash
ls -l /usr/share/hashcat/rules/

total 2576
-rw-r--r-- 1 root root    933 Jun 19 06:20 best64.rule
-rw-r--r-- 1 root root    633 Jun 19 06:20 combinator.rule
-rw-r--r-- 1 root root 200188 Jun 19 06:20 d3ad0ne.rule
-rw-r--r-- 1 root root 788063 Jun 19 06:20 dive.rule
-rw-r--r-- 1 root root 483425 Jun 19 06:20 generated2.rule
-rw-r--r-- 1 root root  78068 Jun 19 06:20 generated.rule
drwxr-xr-x 1 root root   2804 Jul  9 21:01 hybrid
-rw-r--r-- 1 root root 309439 Jun 19 06:20 Incisive-leetspeak.rule
-rw-r--r-- 1 root root  35280 Jun 19 06:20 InsidePro-HashManager.rule
-rw-r--r-- 1 root root  19478 Jun 19 06:20 InsidePro-PasswordsPro.rule
-rw-r--r-- 1 root root    298 Jun 19 06:20 leetspeak.rule
-rw-r--r-- 1 root root   1280 Jun 19 06:20 oscommerce.rule
-rw-r--r-- 1 root root 301161 Jun 19 06:20 rockyou-30000.rule
-rw-r--r-- 1 root root   1563 Jun 19 06:20 specific.rule
-rw-r--r-- 1 root root  64068 Jun 19 06:20 T0XlC-insert_00-99_1950-2050_toprules_0_F.rule
-rw-r--r-- 1 root root   2027 Jun 19 06:20 T0XlC-insert_space_and_special_0_F.rule
-rw-r--r-- 1 root root  34437 Jun 19 06:20 T0XlC-insert_top_100_passwords_1_G.rule
-rw-r--r-- 1 root root  34813 Jun 19 06:20 T0XlC.rule
-rw-r--r-- 1 root root 104203 Jun 19 06:20 T0XlCv1.rule
-rw-r--r-- 1 root root     45 Jun 19 06:20 toggles1.rule
-rw-r--r-- 1 root root    570 Jun 19 06:20 toggles2.rule
-rw-r--r-- 1 root root   3755 Jun 19 06:20 toggles3.rule
-rw-r--r-- 1 root root  16040 Jun 19 06:20 toggles4.rule
-rw-r--r-- 1 root root  49073 Jun 19 06:20 toggles5.rule
-rw-r--r-- 1 root root  55346 Jun 19 06:20 unix-ninja-leetspeak.rule
```
#### Generate Random Rules
Hashcat provides an option to generate random rules on the fly and apply them to the input wordlist. The following command will generate 1000 random rules and apply them to each word from rockyou.txt by specifying the "-g" flag. There is no certainty to the success rate of this attack as the generated rules are not constant.
```bash
hashcat -a 0 -m 100 -g 1000 hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```
#### Publicly Available Rules
[nsa-rules](https://github.com/NSAKEY/nsa-rules)

[Hob0Rules](https://github.com/praetorian-code/Hob0Rules)

[corporate.rule](https://github.com/HackLikeAPornstar/StratJumbo/blob/master/chap3/corporate.rule)

## Cracking Misc Files & Hashes

### Tools
[JohnTheRipper Tools](https://github.com/magnumripper/JohnTheRipper/tree/bleeding-jumbo/src)

[office2john](https://raw.githubusercontent.com/magnumripper/JohnTheRipper/bleeding-jumbo/run/office2john.py)
```bash
python office2john.py hashcat_Word_example.docx
```
```bash
hashcat -m 9600 office_hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```
[zip2john](https://github.com/magnumripper/JohnTheRipper/blob/bleeding-jumbo/src/zip2john.c)
```bash
# set password for zip
zip --password zippyzippy blueprints.zip dummy.pdf 
```
```bash
zip2john ~/Desktop/HTB/Academy/Cracking\ with\ Hashcat/blueprints.zip
```
```bash
hashcat -a 0 -m 17200 pdf_hash_to_crack /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```
[keepass2john](https://github.com/magnumripper/JohnTheRipper/blob/bleeding-jumbo/src/keepass2john.c)
```bash
python keepass2john.py Master.kdbx 
```
```bash
hashcat -a 0 -m 13400 keepass_hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```
[pdf2john](https://raw.githubusercontent.com/truongkma/ctf-tools/master/John/run/pdf2john.py)
```bash
python pdf2john.py inventory.pdf | awk -F":" '{ print $2}'
```
```bash
hashcat -a 0 -m 10500 pdf_hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```

## Cracking WPA/WPA2 Handshakes with Hashcat
Hashcat can be used to successfully crack MIC (4-way handshake) and PMKID (1st packet/handshake)

### Cracking MIC
To perform, need to capture a valid 4-way handshake by sending de-authentication frames to force a client (user) to disconnect from an AP. When the client reauthenticates (usually automatically), the attacker can attempt to sniff out the WPA 4-way handshake without their knowledge. This handshake is a collection of keys exchanged during the authentication process between the client and the associated AP. 
![image](https://user-images.githubusercontent.com/89045912/180088458-3af0a749-b487-4385-aaff-9b7e50d318b2.png)

After successful capture with a tool such as **airodump-ng**, need to convert to a format for Hashcat: `hccapx`. Hashcat hosts online service for this: [cap2hashcat online](https://hashcat.net/cap2hashcat).

For offline: hashcat-utils repo:
```bash
git clone https://github.com/hashcat/hashcat-utils.git
```
```bash
cd hashcat-utils/src
```
```bash
make
```
#### Cap2hccapx Syntax
```bash
./cap2hccapx.bin 
usage: ./cap2hccapx.bin input.cap output.hccapx [filter by essid] [additional network essid:bssid]
```
#### Convert to Crackable File
```bash
./cap2hccapx.bin corp_capture1-01.cap mic_to_crack.hccapx
```
```bash
hashcat -a 0 -m 22000 mic_to_crack.hccapx /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```
### Cracking PMKID
This attack can be performed against wireless networks that use WPA/WPA2-PSK (pre-shared key) and allows us to obtain the PSK being used by the targeted wireless network by attacking the AP directly. The attack does not require deauthentication (deauth) of any users from the target AP. The PMK is the same as in the MIC (4-way handshake) attack but can generally be obtained faster and without interrupting any users.

The Pairwise Master Key Identifier (PMKID) is the AP's unique identifier to keep track of the Pairwise Master Key (PMK) used by the client. The PMKID is located in the 1st packet of the 4-way handshake and can be easier to obtain since it does not require capturing the entire 4-way handshake. PMKID is calculated with HMAC-SHA1 with the PMK (Wireless network password) used as a key, the string "PMK Name," MAC address of the access point, and the MAC address of the station. Below is a visual representation of the PMKID calculation:
![image](https://user-images.githubusercontent.com/89045912/180089715-3596703e-adeb-4475-9e8f-6c9e5c3530cb.png)

Obtain pmkid hash by extracting from .cap file with [hcxpcapngtool](https://github.com/ZerBea/hcxtools)
```bash
hcxpcaptool -z pmkidhash_corp cracking_pmkid.cap 
```
```bash
hashcat -a 0 -m 22000 pmkidhash_corp /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt
```



 
 
