
Import-Module DhcpServer

$dhcpServer = "SERVERNAME"

$outputPath = "C:\PATH\4\CSV"


$scopes = Get-DhcpServerv4Scope -ComputerName $dhcpServer

$allLeases = @()

# Get all scopes from the DHCP server
$scopes = Get-DhcpServerv4Scope -ComputerName $dhcpServer

# Loop through each scope
foreach ($scope in $scopes) {
    # Initialize variables for pagination
    $start = 0
    $pageSize = 100
    $totalLeases = $pageSize

    # Paginate through lease results until all leases are retrieved
    while ($start -lt $totalLeases) {
        # Get leases for the current scope with pagination
        $scopeLeases = Get-DhcpServerv4Lease -ComputerName $dhcpServer -ScopeId $scope.ScopeId -StartRange $start -EndRange ($start + $pageSize - 1)

        # Add leases to the array
        $allLeases += $scopeLeases

      
        $start += $pageSize

        
        $totalLeases = $scopeLeases.Count
    }
}

# Filter leases based on IP address starting with by IP 
$filteredLeases = $allLeases | Where-Object { $_.IPAddress -like "172.20*" }

# Export filtered leases to CSV file
$filteredLeases | Export-Csv -Path $outputPath -NoTypeInformation

Write-Host "Lease information for IP addresses starting with '172.20' has been exported to $outputPath."