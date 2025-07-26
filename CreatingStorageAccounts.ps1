# Parameters
param(
    [string]$ResourceGroupName,
    [string]$Location,
    [string]$StorageAccountName,
    [string]$SkuName = "Standard_LRS",
    [string]$Kind = "StorageV2"
)

# Create a Storage Account
$storageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -Location $Location -SkuName $SkuName -Kind $Kind

# Retrieve Storage Account Keys
$keys = Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

# Configure Security Settings
Set-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -EnableHttpsTrafficOnly $true

# Output Storage Account Details
$storageAccountContext = $storageAccount.Context
Write-Output "Storage Account Created: $StorageAccountName"
Write-Output "Primary Key: $($keys[0].Value)"