# Windows Fundamentals

## Connecting via RDP
```bash
xfreerdp /v:<target ip> /u:<user> /p:<password>
```

## OS Info
[Get-WmiObject cmdlet](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject?view=powershell-5.1)
Additional info:
[Info1](https://ss64.com/ps/get-wmiobject.html)
[Info2](https://adamtheautomator.com/get-wmiobject/)
```powershell
Get-WmiObject
```
```powershell
Get-WmiObject -Class win32_OperatingSystem | select Version,BuildNumber
```
Other useful classes:
```powershell
# Get a process listing
Win32_Process

# Get listing of services
Win32_Bios

# Get BIOS information
Win32_Bios

# Parameter to get info about remote computers
ComputerName
```

## OS Structure
The root directory ( also known as the boot partition) is where the operating system is installed.

**Directory Structure of the Boot Partition:**
| Directory | Function |
| --- | --- |
| Perflogs | Can hold Windows performance logs but is empty by default |
| Program Files | On 32-bit systems, all 16-bit and 32-bit programs are installed here. On 64-bit systems, only 64-bit programs are installed here |
| Program Files (x86) | 32-bit and 16-bit  programs are installed here on 64-bit editions of Windows |
| ProgramData | This is a hidden folder that contains data that is essential for certain installed programs to run. This data is accessible by the program no matter what user is running it. |
| Users | This folder contains user profiles for each user that logs onto the system and contains the two folders Public and Default |
| Default | This is the default user profile template for all created users. Whenever a new user is added to the system, their profile is based on the Default profile. |
| Public | this folder is intended for computer users to share files and is accessible to all users by default. This folder is shared over the network by default but requires a valid network account to access. |
| AppData | Per user application data and settings are stored in a hidden user subfolder (i.e., cliff.moore\AppData). Each of these folders contains three subfolders. The Roaming folder contains machine-independent data that should follow the user's profile, such as custom dictionaries. The Local folder is specific to the computer itself and is never synchronized across the network. LocalLow is similar to the Local folder, but it has a lower data integrity level. Therefore it can be used, for example, by a web browser set to protected or safe mode. |
| Windows | The majority of the files required for the Windows operating system are contained here | 
| System, System32, System64 | Contains all DLLs required for the core features of Windows and the Windows API. The operating system searches these folders any time a program asks to load a DLL without specifying an absolute path |
| WinSxS | The Windows Component Store contains a copy of all Windows components, updates, and service packs |

[Tree](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tree) is useful for graphically displaying the directory structure of a path or disk.

Walk though all files in the "C' drive, one screen at a time:
```powershell
tree c:\ /f | more
```
## File System
Pros of FAT32:

    - Device compatibility - it can be used on computers, digital cameras, gaming consoles, smartphones, tablets, and more.
    - Operating system cross-compatibility - It works on all Windows operating systems starting from Windows 95 and is also supported by MacOS and Linux.

Cons of FAT32:

    - Can only be used with files that are less than 4GB.
    - No built-in data protection or file compression features.
    - Must use third-party tools for file encryption.
    
Pros of NTFS:

    - NTFS is reliable and can restore the consistency of the file system in the event of a system failure or power loss.
    - Provides security by allowing us to set granular permissions on both files and folders.
    - Supports very large-sized partitions.
    - Has journaling built-in, meaning that file modifications (addition, modification, deletion) are logged.

Cons of NTFS:

    - Most mobile devices do not support NTFS natively.
    - Older media devices such as TVs and digital cameras do not offer support for NTFS storage devices.

### Permissions
| Permission Type |	Description |
| --- | --- |
| Full Control |	Allows reading, writing, changing, deleting of files/folders. |
| Modify |	Allows reading, writing, and deleting of files/folders. |
| List Folder Contents |	Allows for viewing and listing folders and subfolders as well as executing files. Folders only inherit this permission. |
| Read and Execute |	Allows for viewing and listing files and subfolders as well as executing files. Files and folders inherit this permission. |
| Write |	Allows for adding files to folders and subfolders and writing to a file. |
| Read |	Allows for viewing and listing of folders and subfolders and viewing a file's contents. |
| Traverse Folder |	This allows or denies the ability to move through folders to reach other files or folders. For example, a user may not have permission to list the directory contents or view files in the documents or web apps directory in this example c:\users\bsmith\documents\webapps\backups\backup_02042020.zip but with Traverse Folder permissions applied, they can access the backup archive. |

### Integrity Control Access Control List (icacls)

Can achieve a fine level of granularity over NTFS file permissions in Windows form the command line using the icacls utility.

List out NTFS permissions on a specific directory:
```powershell
# Run within working directory
icacls

# Against a directory not currently in
icacls C:\Windows
```
Inheritance settings:
| Setting | Inheritance |
| --- | --- |
| (CI) | container inheritance |
| (OI) | object inheritance |
| (IO) | inherit only |
| (NP) | do not propagate inherit | 
| (I) | permission inherited from parent container |

Basic access permissions:
| Setting | Permissions | 
| --- | --- |
| F | full access |
| D | delete access |
| N | no access |
| M | modify access |
| RX | read and execute access |
| R | read-only acccess |
| W | write-only access |

Grant full control over a directory:
```powershell
icacls c:\users /grant joe:f
```
[Full List of icacls command line arguments](https://ss64.com/nt/icacls.html)

## NTFS vs. Share Permissions
NTFS and Share permissions are not the same, but often apply to the shared resource:
### Share Permissions
|Permission |	Description|
| --- | --- |
|Full Control |	Users are permitted to perform all actions given by Change and Read permissions as well as change permissions for NTFS files and subfolders|
|Change |	Users are permitted to read, edit, delete and add files and subfolders|
|Read 	|Users are allowed to view file & subfolder contents|

### NTFS Basic Permissions
|Permission |	Description|
| --- | --- |
|Full Control 	|Users are permitted to add, edit, move, delete files & folders as well as change NTFS permissions that apply to all allowed folders|
|Modify |	Users are permitted or denied permissions to view and modify files and folders. This includes adding or deleting files|
|Read & Execute |	Users are permitted or denied permissions to read the contents of files and execute programs|
|List folder contents |	Users are permitted or denied permissions to view a listing of files and subfolders|
|Read |	Users are permitted or denied permissions to read the contents of files|
|Write |	Users are permitted or denied permissions to write changes to a file and add new files to a folder|
|Special Permissions |	A variety of advanced permissions options|

### NTFS Special Permissions
|Permission |	Description|
| --- | --- |
|Full control |	Users are permitted or denied permissions to add, edit, move, delete files & folders as well as change NTFS permissions that apply to all permitted folders|
|Traverse folder / execute file |	Users are permitted or denied permissions to access a subfolder within a directory structure even if the user is denied access to contents at the parent folder level. Users may also permitted or denied permissions to execute programs|
|List folder/read data |	Users are permitted or denied permissions to view files and folders contained in the parent folder. Users can also be permitted to open and view files|
|Read attributes |	Users are permitted or denied permissions to view basic attributes of a file or folder. Examples of basic attributes: system, archive, read-only, and hidden|
|Read extended attributes |	Users are permitted or denied permissions to view extended attributes of a file or folder. Attributes differ depending on the program|
|Create files/write data |	Users are permitted or denied permissions to create files within a folder and make changes to a file|
|Create folders/append data |	Users are permitted or denied permissions to create subfolders within a folder. Data can be added to files but pre-existing content cannot be overwritten|
|Write attributes |	Users are permitted or denied to change file attributes. This permission does not grant access to creating files or folders|
|Write extended attributes |	Users are permitted or denied permissions to change extended attributes on a file or folder. Attributes differ depending on the program|
|Delete subfolders and files |	Users are permitted or denied permissions to delete subfolders and files. Parent folders will not be deleted|
|Delete |	Users are permitted or denied permissions to delete parent folders, subfolders and files.|
|Read permissions |	Users are permitted or denied permissions to read permissions of a folder|
|Change permissions 	|Users are permitted or denied permissions to change permissions of a file or folder|
|Take ownership |	Users are permitted or denied permission to take ownership of a file or folder. The owner of a file has full permissions to change any permissions|

* NOTE: NTFS permissions apply to the system where the folder or files are hosted

## Windows Services and Processes
### Windows Services
Windows services are managed via the Service Control Manager (SCM) system, accessible via the `services.msc` MMC add-in. Provides a GUI interface for interacting with and managing services and displays information about each installed service. Includes service Name, Description, Status, Startup Type, and the user the service runs under.

Also can query and manage services via the command line using `sc.exe` using [Powershell](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7) cmdlets such as `Get-Service`.
```powershell
Get-Service | ? {$_.Status  -eq "Running"} | select -First 2 |fl
```
[Critical System Services](https://docs.microsoft.com/en-us/windows/win32/rstmgr/critical-system-services)

| Service | Description |
| --- | --- |
| smss.exe | Session Manager SubSystem. Responsible for handling sessions on the system |
| csrss.exe | Client Server Runtime Process. The user-mode portion of the Windows subsystem |
| wininit.exe | Starts the Wininit file .ini file that lists all of the changes to be made to Windows when the computer is restarted after installing a program |
| logonui.exe | Used for facilitating user lofin into a PC |
| lsass.exe | Local Security Authentication Server verifies the validity of user logons to a PC or server. It generates the process responsible for authenticating users for the Winlogon service.|
| services.exe | Manages the operation of starting and stopping services |
| winlogon.exe | Responsible for handling the secure attention sequence, loading a user profile on logon , and locking the computer when a screensaver is running. | 
| System | A background system process that runs the Windows kernel |
| svchost.exe with RPCSS | Manages system services that run from dynamic-link libraries (files with the extension .dll) such as "Automatic Updates", "Windows Firewall:, and "Plug and Play". Uses the Remote Procedure Call (RPC) Service (RPCSS) |
| svchost.exe with Dcom/PnP | Manages system services that run from dynamic-link libraries (files with the extension .dll) such as "Automatic Updates," "Windows Firewall," and "Plug and Play." Uses the Distributed Component Object Model (DCOM) and Plug and Play (PnP) services.|

[Windows Components and Key Services](https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_components#Services)

## Local Security Authority Subsystem Service (LSASS)
The process that is responsible for enforcing the security policy on Windows systems. When a user attempts to log on to the system, this process verifies their log on attempt and creates access tokens based on the user's permission levels. LSASS is also responsible for user account password changes. All events associated with this process (logon/logoff attempts, etc.) are logged within the Windows Security Log. LSASS is an extremely high-value target as several tools exist to extract both cleartext and hashed credentials stored in memory by this process.

## Sysinternals Tools
Portable Windows applications that can be used to administer Windows systems

[Sysinternals Tools suite](https://docs.microsoft.com/en-us/sysinternals)

Can be loaded directly from an internet-accessible file share by typing `\\live.sysinternals.com\tools` into a Windows Explorer window. Example:
```powershell
C:\htb> \\live.sysinternals.com\tools\procdump.exe -accepteula
```
### Task Manager
Provides information for running processes, system performance, running services, startup programs, logged-in users/logged-in user processes, and services.

Can be selected by right clicking on the taskbar and selecting `Task Manager`, pressing <kbd>Ctrl+Shift+Esc</kbd>, pressing <kbd>Ctrl+Alt+Del</kbd>, typing `taskmgr` froma cmd or Powershell console.
## Service Permissions

Use `services.msc` to view and manage just about every detail regarding all services. In the recovery tab, some services can be set to run a program after the first failure.

### Examining services using sc
```powershell
sc qc wuauserv
```
`sc qc` command is used to query the service. To query a service on a device on the network:
```powershell
sc //hostname or IP query ServiceName
```
Start and stop services:
```powershell
sc stop wuaserv
sc start wuaserv
```


### Examine service permissions using Powershell
```powershell
Get-ACL -Path HKLM:\System\CurrentControlSet\Services\wuauserv | Format-List
```
Running scripts
```powershell
.\PowerView.ps1;Get-LocalGroup |fl
```
Import powershell script
```powershell
Import-Module .\PowerView.ps1
```
List all loaded modules and their commands
```powershell
Get-Module | select Name,ExportedCommands | fl
```
#### Execution Policy
|Policy |	Description|
| --- | --- |
|AllSigned |	All scripts can run, but a trusted publisher must sign scripts and configuration files. This includes both remote and local scripts. We receive a prompt before running scripts signed by publishers that we have not yet listed as either trusted or untrusted.|
|Bypass |	No scripts or configuration files are blocked, and the user receives no warnings or prompts.|
|Default |	This sets the default execution policy, Restricted for Windows desktop machines and RemoteSigned for Windows servers.|
|RemoteSigned |	Scripts can run but requires a digital signature on scripts that are downloaded from the internet. Digital signatures are not required for scripts that are written locally.|
|Restricted |	This allows individual commands but does not allow scripts to be run. All script file types, including configuration files (.ps1xml), module script files (.psm1), and PowerShell profiles (.ps1) are blocked.|
|Undefined |	No execution policy is set for the current scope. If the execution policy for ALL scopes is set to undefined, then the default execution policy of Restricted will be used.|
|Unrestricted |	This is the default execution policy for non-Windows computers, and it cannot be changed. This policy allows for unsigned scripts to be run but warns the user before running scripts that are not from the local intranet zone.|
```powershell
Get-ExecutionPolicy -List
Set-ExecutionPolicy Bypass -Scope Process
```
## Windows Management Instrumentation
(WMI)

A subset of PowerShell that provides system administrators with powerful tools for system monitoring. Goal is to consolidate device and application management across corporate networks. Made up of the following components:
|Component Name |	Description|
| --- | --- |
|WMI service |	The Windows Management Instrumentation process, which runs automatically at boot and acts as an intermediary between WMI providers, the WMI repository, and managing applications.|
|Managed objects |	Any logical or physical components that can be managed by WMI.|
|WMI providers |	Objects that monitor events/data related to a specific object.|
|Classes |	These are used by the WMI providers to pass data to the WMI service.|
|Methods |	These are attached to classes and allow actions to be performed. For example, methods can be used to start/stop processes on remote machines.|
|WMI repository |	A database that stores all static data related to WMI.|
|CMI Object Manager |	The system that requests data from WMI providers and returns it to the application requesting it.|
|WMI API |	Enables applications to access the WMI infrastructure.|
|WMI Consumer |	Sends queries to objects via the CMI Object Manager.|

Can be run via command prompt:
```powershell
wmic
 
# Commands
wmic /?
```
List info about OS:
```powershell
wmic os list brief
```
[wmic verbs, switches, and adverbs](https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmic)

Use us WMI in Powershell with `Get-WmiObject` [module](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject?view=powershell-5.1)
```powershell
Get-WmiObject -Class Win32_OperatingSystem | select SystemDirectory,BuildNumber,SerialNumber,Version | ft
```
Call the methods of WMI objects with `Invoke-WmiObject` [module](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/invoke-wmimethod?view=powershell-5.1)
```powershell
Invoke-WmiMethod -Path "CIM_DataFile.Name='C:\users\public\spns.csv'" -Name Rename -ArgumentList "C:\Users\Public\kerberoasted_users.csv"
```
## Windows Security

### Security Identifier (SID)
The system automatically generates SIDs. SIDs are string values with different lengths, which are stored in the security database. These are added to the users's access token to identify all actions the user is authorized to take.

A SID consists of the Identifier Authority and the Relative ID (RID). In an AD environment, the SID also includes the domain SID:
```powershell
whoami /user

USER INFORMATION
----------------

User Name           SID
=================== =============================================
ws01\bob S-1-5-21-674899381-4069889467-2080702030-1002
```
```powershell
# SID Pattern
(SID)-(revision level)-(identifier-authority)-(subauthority1)-(subauthority2)-(etc)
```
|Number |	Meaning |	Description|
| --- | --- | --- |
|S| 	SID |	Identifies the string as a SID.|
|1 |	Revision Level |	To date, this has never changed and has always been 1.|
|5 |	Identifier-authority |	A 48-bit string that identifies the authority (the computer or network) that created the SID.|
|21 |	Subauthority1 |	This is a variable number that identifies the user's relation or group described by the SID to the authority that created it. It tells us in what order this authority created the user's account.|
|674899381-4069889467-2080702030 |	Subauthority2 	Tells us which computer (or domain) created the number|
|1002 |	Subauthority3 |	The RID that distinguishes one account from another. Tells us whether this user is a normal user, a guest, an administrator, or part of some other group|

### Security Accounts Manager (SAM) and Access Control Entries (ACE)
SAM grants rights to a network to execute specific processes.

The access rights themselves are managed by Access Control Entries (ACE) in Access Control Lists (ACL). The ACLs contain ACEs that define which users, groups, or processes have access to a file or to execute a process, for example.

The permissions to access a securable object are given by the security descriptor, classified into two types of ACLs: the Discretionary Access Control List (DACL) or System Access Control List (SACL). Every thread and process started or initiated by a user goes through an authorization process. An integral part of this process is access tokens, validated by the Local Security Authority (LSA). In addition to the SID, these access tokens contain other security-relevant information. Understanding these functionalities is an essential part of learning how to use and work around these security mechanisms during the privilege escalation phase.

### User Account Control (UAC)
Confirms any installs to block malware from system. Window pops up to request admin approval of all installs.

[UAC Overview](https://docs.microsoft.com/en-us/windows/security/identity-protection/user-account-control/how-user-account-control-works)

## Registry

The [Registry](https://en.wikipedia.org/wiki/Windows_Registry) is a hierarchal database critical for the operating system. Divided into computer specific and user specific data. Open Registry Editor with `regedit` from command line or Windows search bar.

The tree consists of main folders (root keys) in which subfolders (subkeys) with their entries/files (values) are located. 11 different types of values that can be entered into a subkey.
|Value |	Type|
| --- | --- |
|REG_BINARY |	Binary data in any form.|
|REG_DWORD |	A 32-bit number.|
|REG_DWORD_LITTLE_ENDIAN |	A 32-bit number in little-endian format. Windows is designed to run on little-endian computer architectures. Therefore, this value is defined as REG_DWORD in the Windows header files.|
|REG_DWORD_BIG_ENDIAN |	A 32-bit number in big-endian format. Some UNIX systems support big-endian architectures.|
|REG_EXPAND_SZ |	A null-terminated string that contains unexpanded references to environment variables (for example, "%PATH%"). It will be a Unicode or ANSI string depending on whether you use the Unicode or ANSI functions. To expand the environment variable references, use the ExpandEnvironmentStrings function.|
|REG_LINK |	A null-terminated Unicode string containing the target path of a symbolic link created by calling the RegCreateKeyEx function with|REG_OPTION_CREATE_LINK.|
|REG_MULTI_SZ |	A sequence of null-terminated strings, terminated by an empty string (\0). The following is an example: String1\0String2\0String3\0LastString\0\0 The first \0 terminates the first string, the second to the last \0 terminates the last string, and the final \0 terminates the sequence. Note that the final terminator must be factored into the length of the string.|
|REG_NONE |	No defined value type.|
|REG_QWORD |	A 64-bit number.|
|REG_QWORD_LITTLE_ENDIAN |	A 64-bit number in little-endian format. Windows is designed to run on little-endian computer architectures. Therefore, this value is defined as REG_QWORD in the Windows header files.|
|REG_SZ |	A null-terminated string. This will be either a Unicode or an ANSI string, depending on whether you use the Unicode or ANSI functions.|

- Each folder under Computer is a key
- Root keys all start with HKEY
- A key such as HKEY-LOCAL-MACHINE is abbreviated to HKLM; contains all the settings that are relevant to the local system.
    + This root key contains six subkeys:
        * SAM
        * SECURITY
        * SYSTEM
        * SOFTWARE
        * HARDWARE
        * BCD
    + These are loaded into memeory at boot time (except HARDWARE which is dynamically loaded)
+ The entire system registry is stored in several files in the operating system: `C:\Windows\System32\Config\`

The user spcecific registry hive (HKCU) is stored in the user folder: `C:\Windows\Users\<USERNMAME>\Ntuser.dat`
```powershell
gci -Hidden
```
## Run and RunOnce Keys
Rgistry hives contain a logical group of keys, subkeys, and values to support. 





