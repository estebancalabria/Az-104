# Clase 12 - 27 de Octubre del 2026

# Repaso

* Monitoring
  * Log Analytics workspaces
    * KQL (Kusto Query Language)
      * Operation
  * Ativity Log -> Log Analytics Workspace
    * DCR (Data Collection Rule)
    * AzureActivity
  * Monitor
  * Monitoreo de VMs
    * AMA (Azure Monitor Agent)
  * Alertas
    * Basadas en Logs (Si se apaga una pc)
    * Basadas en Metricas

  ---

  # Data Protection de VM

* Creamos el RG
    * Name : rg-az104-clase-12
   
* Crear una VNet

```
New-AzVirtualNetwork -Name vnet-az104-clase-12  -ResourceGroupName rg-az104-clase-12 -Location westus -AddressPRefix 10.0.0.0/16
```

* Cremos una Subnet

```
az network vnet subnet  create --resource-group rg-az104-clase-12 --vnet-name vnet-az104-clase-12 --name subnet-0 --address-prefixes 10.0.0.0/24
```

* Creamos el NSG

```
New-AzNetworkSecurityGroup -name nsg-az104-clase-12 -Location westus -ResourceGroupName rg-az104-clase-12
```

* Crear la VM
  * Listar las imagenes posibles

```
az vm image list --offer windowsServer
```

> [!NOTE]
> DE aca saco el nombre de la imagen ejemplo : MicrosoftWindowsServer:WindowsServer:2016-datacenter-gensecond:latest

  * Crear el Password

```
$pass = ConvertTo-SecureString -String (Read-Host "Ingrese su Pass") -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "AzureUser", $pass 
```

  * Crear la VM

```
New-AzVm -Credential $cred -Image MicrosoftWindowsServer:WindowsServer:2016-datacenter-gensecond:latest -Location westus -Name vm-clase-12 -OpenPorts 3389 -PublicIPAddressName pip-vm-az104-clase-12 -ResourceGroupName rg-az104-clase-12 -SecurityGroupName nsg-az104-clase-12 -SubnetName subnet-0 -VirtualNetworkName vnet-az104-clase-12
```

* Abrir el puerto 3389 en el NSG

```
 $nsg = Get-AzNetworkSecurityGroup -Name nsg-az104-clase-12    

Add-AzNetworkSecurityRuleConfig -Name Allow-RDP -Description "Permitir RDP" -Priority 100 -Direction inbound -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix 10.0.0.4 -DestinationPort 3389 -NetworkSecurityGroup $nsg -Protocol tcp -Access Allow

Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg          
```

* Me conecto por RDP y creo un archivo de texto en el escritorio de la VM

* Crear el recurso "Recovery Service Vault"

* Vamos a Protected Items -> Backup Items ( o a Getting Started -> Backup)
 * Hacemos el Backup de la VM

* Ir a la vm Backuapeada en Backup Items e Iniciar un backup inicial manual


---
# BEAK
Hasta menos 5
---

* Borro el archivo, recupero la VM y el archivo aparece

---

# Microsoft Foundry

* Los servicios de IA que trae Azure (
