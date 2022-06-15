# Shell Tips

Ideally after shell, gain access to a user account. 

- SSh keys stored at `/home/<user>/.ssh` in Linux
- Exploits available to write your won account

[Dirty C0w](https://dirtycow.ninja/)

writeable /etc/shadow or /etc/passwd

### Windows

- Passwords can sometimes be in registry
	- VNC servers freqeuently have this

- FileZilla FTP server also leave creds in XML file at `C:\Program Files\FileZilla Server\FileZilla Server.xml` or `C:\xampp\FileZilla Server\FileZilla Server.xml`

Ideally, would obtain shell running SYSTEM user or admin, and add own account:

`net user <username> <password> /add`

`net localgroup administrators <username> /add`

	