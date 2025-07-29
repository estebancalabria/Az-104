# Backup de VM

## Preparacion del entorno (Con el CLI)

- ### Creamos los recursos necesarios por el CLI

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
    
New-AzVM -Credential $cred -Image MicrosoftWindowsDesktop:windows-11:win11-24h2-pro:latest  -Location westus -Name vm-az104 -OpenPorts 3389 -PublicIpAddressName Ip-vm-az104 -ResourceGroupName <nombre-rg> -SecurityGroupName <nombre-nsg> -SubnetName subnet-0 -VirtualNetworkName vnet-az104-0
```

6. Habilitar el RDP para la VM
```powershell
$nsg = Get-AzNetworkSecurityGroup -Name nsg-az104 -ResourceGroupName rg-az104-clase-08

Add-AzNetworkSecurityRuleConfig -Name Allow-Rdp -Description "Permitir RDP" -Priority 100 -Direction inbound -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix 10.0.0.4 -DestinationPortRange 3389 -NetworkSecurityGroup $nsg -Protocol tcp -Access Allow

Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg
```

7.Conectarnos a la VM por rdp 9desde mi pc)

```bash
>mstsc /v:<IP-PUBLICA-VM>
```

8. Crear en la virtual un archivo

## Crear el servicio de Backup de la VM

1. Crear el Recvery Service Vault con el Portal
2. Configurar el backup para la VM
3. Crear un Storag Account
4. Crear un Log Analitics Worspace
5. Guadar la informaicon de Loggin de Backup en el log Analitics Workspace y el Storage Account
6. Borrar algun archivo de la VM
7. Detener la VM
8. Restaurar VM a un punto anterior
9. Ver que el archivo que habiamos borrado vuelve a aparecer
