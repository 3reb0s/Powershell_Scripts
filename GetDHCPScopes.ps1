# Import the DHCP server module
Import-Module DhcpServer

# Define the DHCP server
$dhcpServer = "sys-admdhcp1"

# Get all DHCP scopes from the specified server
$scopes = Get-DhcpServerv4Scope -ComputerName $dhcpServer

# Display the scopes
$scopes | Select-Object ScopeId, Name, StartRange, EndRange
