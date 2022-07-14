# Powershell

## Table of Contents
- [Summary](#summary)
  + [Full List of Approved Verbs](#full-list-of-approved-verbs)
- [Basic Powershell Commands](#basic-powershell-commands)
  + [Using Get-Help](#using-get-help)
  + [Using Get-Command](#using-get-command)
  + [Object Manipulation](#object-manipulation)
  + [Creating Objects From Previous cmdlets](#creating-objects-from-previous-cmdlets)
  + [Filtering Objects](#filtering-objects)
  + [Sort Object](#sort-object)
- [Examples](#examples)
- [Powershell Scripting](#powershell-scripting)

## Summary

The Windows Scripting Language and shell environment that is built using the .NET Framework. Allows Powershell to execute .NET functions directly form its shell. Powershell commands, or _cmdlets_, are written in .NET. The output of _cmdlets_ are objects.

Normal format of a *cmdlet* is represented using **Verb-Noun*:

`Get-Command`

Common verbs:

> Get, Start, Stop, Read, Write, New, Out

[Full List of Approved Verbs](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7)

***

## Basic Powershell Commands

`Get-Command` and `Get-Help` are your best friends

### Using Get-Help

Displays information about a *cmdlet*:

```powershell
Get-Help <Command-Name>
```
Understand how to exactly use the command:
```powershell
Get-Help <Commmand-Name> -examples
```

### Using Get-Command

Gets all the *cmdlets* installed on the current Computer. Allows for pattern matching:
```powershell
Get-Command <Verb>-*
Get-Command *-<Noun>
Get-Command New-*
```

### Object Manipulation

The output of every *cmdlet* is an object. In order to manipulate the object, need to:

- To pass output to other *cmdlets*
- User specific object *cmdlets* to extract information

The `|` pipe is used to pass output form one *cmdlet* to another. 
As opposed to other shells, Powershell passes an **object** to the next *cmdlet*, instead of passing text or a string. 
An object will contain methods and properties:

- Methods are functions that can be applied to output form the *cmdlet*
- Properties are variables in the output from a *cmdlet*

To view these details, pass the output of a *cmdlet* to the `Get-Member` *cmdlet*:
```powershell
Verb-Noun | Get-Member
Get-Command | Get-Member -MemberType Method
```

### Creating Objects From Previous cmdlets

Can manipulate objects by pulling properties from the output of a cmdlet and creating a new object.
```powershell
Select-Object
```
```powershell
Get-ChildItem | Select-Object -Property Mode, Name
```
Can use flags to select particular information:
- first - gets the first x object
- last - gets the last x object
- unique - shows the unique objects
- skip - skip x objects

### Filtering Objects

Select output objects that match a specific value using `Where-Object`.
```powershell
Verb-Noun | Where-Object -Property PropertyName -operator Value
```
This uses the $_ operator to iterate throug every object passed to the Where-Object cmdlet
```powershell
Verb-Noun | Where-Object {$_.PropertyName -operator Value}
```
`-operator` is a list of the following operators:
- -Contains: if any value in the property calye is an exact match for the specified value
- -EQ: if the property value is the same as the specified value
- -GT: if the value is greater than the specififed value

[Full List of Operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-6)

### Sort Object

Sort output to extract information more efficiently. PIpe to the `Sort-Object` cmdlet
```powershell
Verb-Noun | Sort-Object
```
```powershell
Get-ChildItem | Sort-Object
```
***

## Examples

#### Find a Specific File
```powershell
Get-ChildItem -Path C:\ -Include *interesting-file.txt* -File -Recurse -ErrorAction SilentlyContinue
```
#### Specify Contents of File
```powershell
Get-Content "C:\Program Files\interesting-file.txt.txt"
```
#### How many cmdlets on the system
```powershell
Get-Command | Where-Object -Property CommandType -eq Cmdlet | measure
```
#### Get MD5 Hash of File
```powershell
Get-FileHash | .\interestingfile.txt -Algorithm MD5 | Format-List
```
[Get-FileHash](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-7.2)
#### Get Current Working Directory
```powershell
Get-Location
```
#### Check if Path Exists
```powershell
Test-Path -Path "C:\Users\Administrator\Documents\Passwords"
```
[Test-Path](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2)

#### Make Request to Web Server
```powershell
Invoke-WebRequest
```
#### Decode From Base64
```powershell
certutil -decode "file" outfile.txt
```

***

## Enumeration

#### Enumerate Users
```powershell
Get-LocalUser
```
#### Find User via SID
```powershell
Get-LocalUser -SID S-1-5-21-1394777289-3961777894-1791813945-501
```
#### Check Password Required Value
```powershell
Get-LocalUser | Where-Object -Property PasswordRequired -Match false
```
#### Check Number of Groups
```powershell
Get-LocalGroup | measure
```
#### Get IP Address
```powershell
Get-NetIPAddress
```
#### Check Listening Ports
```powershell
Get-NetTCPConnection | Where-Object -Property State -Match Listen | measure
```
#### List Remote Address for Listening Port
```powershell
Get-NetTCPConnection | Where-Object -Property State -Match Listen
```
#### Check Nember of Patches Applied
```powershell
Get-Hotfix | measure
```
#### Check Date of Patch
```powershell
Get-HotFix -ID KB4023834
```
#### Find File Containing a String
```powershell
Get-ChildItem C:\* -Recurse | Select-String -pattern API_KEY
```
#### List Running Processes
```powershell
Get-Process
```
#### Get Path to Scheduled Task
```powershell
Get-ScheduleTask -TaskName new-sched-task
```
#### Find Owner
```powershell
Get-Acl c:/
```

## Powershell Scripting

[Powershell Language](https://learnxinyminutes.com/docs/powershell/)

[If Statement Operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-6)

#### Port Scanner Script
```powershell
for($i=130; $i -le 140; $i++)(
  Test-NetConnection localhost -Port $i
)
```







