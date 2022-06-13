# List port scanning modules
search portscan

# Set options
show options
# CONCURRENT: number of targets to be scanned simulataneously
# PORTS: Port range to be scanned
# RHOSTS: target or target network to be scanned
# THREADS: number of thread to be used simultaneously; more will be faster

# UDP service identification
scanner/discovery/udp_sweep

# SMB Scans
smb_enumshares
smb_version
