# Return hostname of target
hostname

# Print system info about kernel used
uname -a

# Provide information about the target system processes proc filesystem
/proc/version

# Info about the operating system
/etc/issue

# See running processes on Linux system
ps

# View all running processes
ps -A

# View process tree
ps axjf

# Show processes for all users, user that launched it, and processes not attached to terminal
ps aux

# Show environmental variables
env 

# List all commands your user can run using `sudo`
sudo -l

# Show user's privilege level and group membership
id

# Read /etc/passwd file
/etc/passwd

# Condense /etc/passwd to list
cat /etc/passwd | cut -d ":" -f 1
cat /etc/passwd | grep home 

# Look at earlier commands
history

# Info about network interfaces
ifconfig
ip route

# Show all listening ports and established connections
netstat -a

# list TCP or UDP protocols
netstat -at
netstat -au

# List ports in "listening" mode
netstat -l

# List usage stats by protocol
netstat -s

# List connections with the service name and PID info
netstat -tp

# Show interface stats
netstat -i

# Display sockets, Do not resolve names, Display timers
netstat -ano

# find a file nameed in current directory
find . -name example.txt

# find file in home 
find /home -name example.txt

# find the directory named config under /
find / -type d -name config

# find files with 777 permissions
find / -type f -perm 0777

# find executable files
find / -perm a=x

# find all files for user
find /home -user frank

# find files modified in last 10 days
find / -mtime 10

# find files accessed in last 10 days
find / -atime 10

# find files changed in last 60 minutes
find / -cmin -60

# find files accessed in last 60 minutes
find / -amin -60

# find files with a 50 MB size
find / -size 50M

# Find work-writeable folders
find / -writable -type d 2>/dev/null
find / -perm -222 -type d 2>/dev/null
find / -perm -o w -type d 2>/dev/null

# Find dev tools and supported languages
find / -name perl*
find / -name python*
find / -name gcc*

# Find files with the SUID bit
find / -perm -u=s -type f 2>/dev/null

