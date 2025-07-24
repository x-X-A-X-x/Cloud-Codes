# Variables
resource_group_name="project-alpha-rg"
location="eastus2"
vm_prefix="webserver"

# Array of VM sizes
vm_sizes=("Standard_B1s" "Standard_B2s" "Standard_B4ms")

# Create resource group
az group create --name $resource_group_name --location $location

# Loop through VM sizes and create VMs
for i in "${!vm_sizes[@]}"
do
  vm_name="${vm_prefix}-${i}"
  vm_size=${vm_sizes[$i]}

  echo "Creating VM: $vm_name with size: $vm_size"

  az vm create \
    --resource-group $resource_group_name \
    --name $vm_name \
    --image UbuntuLTS \
    --size $vm_size \
    --admin-username azureuser \
    --generate-ssh-keys
done

# List all VMs in the resource group
echo "Deployed VMs:"
az vm list --resource-group $resource_group_name --query "[].{Name:name, Size:hardwareProfile.vmSize}" -o table
