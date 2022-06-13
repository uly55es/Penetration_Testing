# Start PostgreSQL database
systemctl start postgresql

# Initialize Metasploit Database
msfdb init

# Launch and check database status
msfconsole
db_status

# Will allow to create workspaces to isolate projects
# List available workspaces 
workspace

# Add a workspace
workspace -a <NAME>

# Delete a workspace
workspace -d <NAME>

# Navigate to workspace
workspace <NAME>

# Available options for workspace command
workspace -h

# Help command will show Database Backend Commands
help

# Run nmap scan; save results to the database
db_nmap
# Reach relevant scan info
hosts
services
# Help with these commands
hosts -h
services -h
# Once stored, can add RHOSTS parameter
hosts -R
# Can search for specific services in the environment
services -S netbios