# Automation Runbooks

Opciones como IAC (Infraestructura como codigo)
* ARM Templates
* Bicep Templates
* Terraform Templates
* CLI de powershell
* Con el comando AZ

- ## Pasos:

1. Crear el resource group

```powershell
New-AzResourceGroup -Name "rg-az104-clase-10" -Location 'WestUS'
```
     
2. Crear un Automation Account

3. Crear un Runbook

```powershell
param (
    [string]$ResourceGroupName = "rg-az104-clase-10",
    [string]$VMName = "vm-clase-10"
)

Connect-AzAccount -Identity

Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Force
```

4. Crear un VM

```powershell
New-AzVm -ResourceGroupName "rg-az104-clase-10" -Name "vm-clase-10" -Location 'westUS' -VirtualNetworkName "myVnet" -SubnetName "mySubnet" -SecurityGroupName   "myNetworkSecurityGroup" -PublicIpAddressName "myPublicIpAddress" -PublicIpSku Standard -OpenPorts 80,3389 -Size Standard_D2s_v3
```

5. 

- 
