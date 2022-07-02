# SMTP

## Simple Mail Transfer Protocol

Utilised to handle the sending of emails. In order to send, a protocol pair is required, comporising of SMTP and POP/IMAP. Together, they allow the user to send outgoing mail and retrieve incoming mail.

- Verified who is sending emails through the SMTP server
- Sends the outgoing mail
- If unable to deliver, send the mail back to sender

### smtp_version module - Metasploit

Can also be done via a telnet connection

`VRFY` confirms the number of valid users

`EXPN` reveals the actual address of user's aliases and lists of email (mailing lists)