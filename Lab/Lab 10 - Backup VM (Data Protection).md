# Backup de VM

## Creamos los recursos necesarios por el CLI

1. Resource Group
```powershell
New-AzResourceGroup -Name rg-<nombre-rg> -Location westus
```
    
2. Crear VNet
```
New-AzVirtualNetwork -Name vnet-<nombre-vnet> -ResourceGroupName <nombre-rg> -Location westus -AddressPrefix 10.0.0.0/16
```
    
3. Crear una Subnet
```bash
az network vnet subnet create --resource-group rg-<nombre-rg> --vnet-name vnet-<nombre-vnet> --name subnet-0 --address-prefixes 10.0.0.0/24  
```
    
4. Crear Network Security Group
```powershell
New-AzNetworkSecurityGroup -Name <nombre-nsg> -Location westus -ResourceGroupName <nombre-rg>

```

5. Crear una Virtual machine
```powershell
$pass = ConvertTo-SecureString -String (Read-Host "Ingrese su Pass") -AsPlainText -Force
    
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "AzureUser", $pass
    
az vm image list --offer windows-11 --publisher MicrosoftWindowsDesktop --sku win11pro --location westus --all --output table
    
New-AzVM -Credential $cred -Image MicrosoftWindowsDesktop:windows-11:win11-24h2-pro:latest  -Location westus -Name vm-az104 -OpenPorts 3389 -PublicIpAddressName Ip-vm-az104 -ResourceGroupName rg-az104-clase-08 -SecurityGroupName nsg-az104 -SubnetName subnet-0 -VirtualNetworkName vnet-az104-0
```

6. 
