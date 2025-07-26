param (
    [string]$resourceGroupName,
    [string]$location,
    [string]$vmName,
    [string]$vmSize = "Standard_DS1_v2",
    [string]$adminUsername,
    [securestring]$adminPassword
)

New-AzVM `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -Name $vmName `
    -Size $vmSize `
    -Credential (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword))
