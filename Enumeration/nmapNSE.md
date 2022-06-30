# Nmap Scripting Engine (NSE)

- provides support for scripts using __Lua__
- NSE is a Lua interpreter

`/usr/share/nmap/scripts`

- Can specify to use any group of installed scripts
- Can install other user's scripts

`--script=default`

| Script Category | Description |
| --- | --- |
| `auth` | Authentication related scripts |
| `broadcast` | Discover hosts by sending broadcast messages |
| `brute` | Performs brute-force password auditing against logins |
| `default` | Default scripts, same as `-sC` |
| `discovery` | Retrieve accessible information, such as database tables and DNS names |
| `dos` | Detects servers vulnerable to Denial of Service (DoS) |
| `exploit` | Attempts to exploit various vulnerable services |
| `external` | Checks using a third-party service, such as Geoplugin and Virustotal |
| `fuzzer` | Launches fuzzing attacks |
| `intrusive` | Intrusive scripts such as brute-force attacks and exploitation |
| `malware` | Scans for backdoors |
| `safe` | Safe scripts that won't crash the target |
| `version` | Retrieve service versions |
| `vuln` | Checks for vulnerabilities or exploit vulnerable services |

`sudo nmap -sS -sC <TARGET>`

- Can specify script based on script name

`--script "<SCRIPT-NAME>"`

## Saving Output

- Normal Format

`-oN <FILENAME>`

- Greppable Format

`-oG <FILENAME>`

- XML Format

`-oX <FILENAME>`

-Save all

`-oA <FILENAME>`

	
