# Passive Recon Command Line Tools

`whois` -> query WHOIS servers
`nslookup` -> query DNS servers
`dig` -> query DNS servers

## WHOIS

- server listens on TCP port 43
- domain registrar is responsible for maintaining the WHOIS records for the domain it is leasing

`whois <DOMAIN_NAME>`

## nslookup

- Stands for Name Server Lookup

`nslookup <DOMAIN_NAME>`
`nslookup <OPTIONS> <DOMAIN_NAME> <SERVER>`

| Query Type | Result |
| --- | --- |
| A | IPv4 Addresses |
| AAAA | IPv6 Addresses |
| CNAME | Canonical Name |
| MX | Mail Servers |
| SOA | Start of Authority |
| TXT | TXT Records |

`nslookup -type=A example.com 8.8.8.8`

## dig

- Domain Information Groper

`dig <DOMAIN_NAME>`
`dig <DOMAIN_NAME> <TYPE>`
`dig @<SERVER> <DOMAIN_NAME> <TYPE>`

`dig @8.8.8.8 example.com MX`

## DNSDumpster

Enumerate subdomains

[DNSDumpster](https://dnsdumpster.com/)

## Shodan.io

[Shodan.io](https://www.shodan.io/)




