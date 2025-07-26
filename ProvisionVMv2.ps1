# Parameters
param(
    [string]$ResourceGroupName,
    [string]$Location,
    [string]$VMName,
    [string]$VMSize = "Standard_DS1_v2",
    [string]$AdminUsername,
    [string]$AdminPassword
)

# Create a Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

# Define the VM Configuration
$vmConfig = New-AzVMConfig -VMName $VMName -VMSize $VMSize

# Add OS Disk
$vmConfig = Set-AzVMOSDisk -VM $vmConfig -CreateOption FromImage -ManagedDiskId $ManagedDiskId -DiskSizeInGB 127 -Caching ReadWrite

# Add a Network Interface
$nic = New-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Name "$VMName-nic" -Location $Location -SubnetId $subnet.Id
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

# Set the Admin Credentials
$cred = New-Object PSCredential ($AdminUsername, (ConvertTo-SecureString $AdminPassword -AsPlainText -Force))
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows -Credential $cred

# Create the Virtual Machine
New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vmConfig