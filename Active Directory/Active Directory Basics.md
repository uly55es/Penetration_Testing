# Active Directory Basics

The directory service for Windows Domain Networks. A collection of machines and servers connceted inside of domains, that are a collective part of a bigger forest of domains, that make up the Active Directory network.

### Domain Controllers

A Windows server that has __Active Directory Domain Services (AD DS)__ installed and has been promoted to a domain controller in the forest. Domain controllers are the center of Active Directory.
- holds the AD DS store
- handles authentication and authorization services
- replicate updates form other domain controllers in the forest
- allows admin acces to manage domain resources

### AD DS Data Store

Holds the databases and processes needed to store and manage directory inforamtion such as users, groups, and services. 
- Contains the NTDS.dit - a database that contains all of the information of an Active Directory domain controller as well as password hashes for domain users
- Stored by default in __%SystemRoot%\NTDS__
- accessible only by the domain controller

### The Forest

A collection of one or more domain trees inside of an Active Directory network. Categorizes the parts of the network as a whole.
- Trees - A hierarchy of domains in Active Directory Domain Services
- Domains - Used to group and manage objects
- Organizational Units (OUs) - Containers for groups, computers, users, printers, and other OUs
- Trusts - Allows users to access resources in other domains
- Objects - users, groups, printers, computers, shares
- Domain Services - DNS Server, LLMNR, IPv6
- Domain Schema - Rules for object creation

### Users & Groups

Four types of __users__:
- Domain Admins - control the domains; only ones with access to the domain controller
- Service Accounts - (can be Domain Admins) used for service maintenance, required by Windows for services such as SQL
- Local Administrators - can make changes to local machines as admin; no access to DC
- Domain users - everyday users

__Groups__

- Security Groups - used to specify permissions for a large number of users
- Distribution Groups - used to specify email distribution lists. Less beneficial for attackers, but good got enumeration


* Default Security Groups

| Group | Description |
| --- | --- |
| Domain Controllers | All domain controllers in the domain |
| Domain Guest | All domain guests |
| Domain Users | All domain users |
| Domain Computers | All workstations and servers joined to the domain | 
| Domain Admins | Designated administrators of the domain |
| Enterprise Admins | Designated administrators of the enterprise |
| Schema Admins | Designated administrators of the schema |
| DNS Admins | DNS Administration Group |
| DNS Update Proxy | DNS Clients who are permitted to perform dynamic updates on behalf of some other clients (such as DHCP servers) |
| Allowed RODC Password Replication Group | Members in this group can have their passwords replicated to all read-only domain controllers in the domain |
| Group Policy Creator Owners | Members in this group can modify  group policy  for the domains |
| Denied RODC Password Replication Group | Members in this group cannot have their passwords replicated to any read-only domain controllers in the domain |
| Protected Users | Members of this group are afforded additional protections against authentication security threats [More](http://go.microsoft.com/fwlink/?LinkId=298939) |
| Cert Publishers | Members of this group are permitted to publish  certificates to the directory |
| Read-Only Domain Controllers | Read-Only domain controllers in the domain |
| Enterprise Read-Only Domain Controllers | Read-Only domain controllers in the enterprise |
| Key Admins | Members of this group can perform administrative actions on key objects within the domain |
| Enterprise Key Admins | Can perform administrative actions on key objects within the forest |
| Cloneable Domain Controllers | Members of this group are domain controllers that may be cloned |
| RAS and IAS Servers | Servers in this group can access remote access properties of users |

### Trust & Policies

* Domain Trusts

Mechanisms in place for users in the network to gain access to other resources in the domain. Generally, trust outline the way domains inside a forest communicate to each other.

| Trust Type | Overview |
| --- | --- |
| Directional | direction of the trust flows from a trusting domain to a trusted domain |
| Transitive | trust relationship expands beyond just two domains to include other trusted domains |

**Can sometimes be abused in order to move laterally throughout a network**

* Domain Policies

Dictate how the server operates and what rules it will and will not follow. Instead of permissions (like domain groups) they contain rules. Instead of applying to a group of users, **they apply to the domain as a whole.**

### AD DS & Authentication

The core function of an Active Directory network; allow for management of the domain, security certificates, LDAPs, and more.

* Domain Services

Services that the domain controller provides to the rest of the domain or tree. Default domain services:

| Service | Function |
| --- | --- |
| LDAP | Lightweight Directory Access Protocol; provide communication between applications and directory services |
| Certificate Services | allows the domain controller to create, validate, and revoke public key certificates |
| DNS, LLMNR, NBT-NS | Domain Name Services for identifying IP hostnames |

* Domain Authentication

The most important - and vulnerable - part of Active Directory. Two types:

| Authentication | Function|
| --- | --- |
| Kerberos | The default authentication service for Active Directory uses ticket-granting tickets and service tickets to authenticate users and give users access to other resources across the domain |
| NTLM | default Windows authenticaton protocol uses an excrypted challenge/response protocol

