# Reverse Shells
# Setting up a listener
nc -nvlp <PORT_NUMBER>

# Tell netcat this will be a listener
-l

# Request a verbose output
-v

# Tell netcat not to resolve host names or use DNS
-n

# Port specification
-p

# Bind Shell
# Set up listener on target
nc <TARGET_IP> <CHOSEN_PORT>