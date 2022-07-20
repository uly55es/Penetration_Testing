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
## Previously Cracked Passwords
Stored in the `hashcat.potfile`. Can be used to create new wordlists of previously cracked passwords:
```bash
cut -d: -f 2- ~/hashcat.potfile
```
## Hashcat-utils
[Hashcat-utils](https://github.com/hashcat/hashcat-utils)

Many utilities that can be useful for advanced password cracking.

### Maskprocessor
[Maskprocessor](https://github.com/hashcat/maskprocessor)

[Usage](https://hashcat.net/wiki/doku.php?id=maskprocessor)

Can be used to create wordlists using a given mask.
```bash
/mp64.bin Welcome?s
```



 
 
