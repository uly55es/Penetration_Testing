# Metasploit multi/handler

tool for catching reverse shells

1. `msfconsole`
2. `use multi/handler`

`options`

Need to set `payload`, `LHOST`, `LPORT`

`set PAYLOAD <payload>`

`set LHOST <listen-address>`

`set LPORT <listen-port>`

start listener

`exploit -j`

multi/handler is intitially backgrounded

`sessions 1`

