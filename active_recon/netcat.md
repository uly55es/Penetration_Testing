# Netcat

- Banner grab

`nc <MACHINE_IP> <PORT>`
`GET / HTTP/1.1`
`host: <HOST>`

- Connect to a listening port on another system

`nc -nvlp <PORT>`

| option | meaning |
| --- | --- |
| -l | Listen mode |
| -p | Specify the Port number |
| -n | Numeric only; no resolution of hostname via DNS |
| -v | Verbose output (optional, yet useful to discover bugs) |
| -vv | Very Verbose (optional) |
| -k | Keep listening after client disconnects |

>[!NOTE]
>port numbers less than 1024 require root privileges to listen on

