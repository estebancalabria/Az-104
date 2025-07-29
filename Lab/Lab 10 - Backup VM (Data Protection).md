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

5. 
