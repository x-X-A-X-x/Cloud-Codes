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

<#
Calling parameterized script to provision VM:

.\ProvisionVM.ps1 -resourceGroupName "SampleResourceGroup" `
                  -location "SampleLocation" `
                  -vmName "SampleVM" `
                  -adminUsername "Sampleadminuser" `
                  -adminPassword (ConvertTo-SecureString "SampleP@ssword123" -AsPlainText -Force)
#>