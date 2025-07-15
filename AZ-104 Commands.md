# Comandos Az-104

# Indice

* [General]
* [Resource Groups]
* [Active Directory](#active-directory)
* [Virtual Networks](#virtual-networks)
* [Network Securty Group](#network-securty-group)
* [Disco](#disco)
* [IP Publica](#ip-publica)
* [Network Security Group](#network-security-group)
* [Virtual Machines](#virtual-machines)
* [Utils](#utils) 

# General

- ## Instalar Chocolately

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

- ## Instalar IIS (Windows 11)

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -All
```

- ## Habilitar el ping
```powershell
New-NetFirewallRule -Name AllowPing -DisplayName "Permitir ICMPv4" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow -Enabled True

```
- ## Instalar el modulo de Azure en Powershell local 

```powershell
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
```
- ## Instalar Modulo ActiveDirectory 

```powershell
Install-Module AzureAD -Force
```
- ## Conectarse a Azure desde Powershell local 
```powershell
Connect-AzAccount
```
- ## Obtener Ayuda Comando de Powershell {#obtener-ayuda-comando-de-powershell}
```powershell
Get-Help New-AzDisk   
Get-Help New-AzDisk -Force  
Get-Help New-AzDisk -Example
```
- ## Comandos Powershell en varias lineas {#comandos-powershell-en-varias-lineas}

 Utilizar bactick al final de cada linea \`

---

# Resource Group 

**Powershell**
```powershell
New-AzResourceGroup -Name Demo -Location eastus
```

**Az**
```az
az group create --name Rg-Az104-Clase-Cuatro --location eastus                                                                      
```

## Borrar un Resource Group {#borrar-un-resource-group}

```powershell
 Remove-AzResourceGroup -Name Demo
```

---

# IAC : ARM Templates

## Hacer Deploy de un ARM Template {#hacer-deploy-de-un-arm-template}
**az**
```az
  > az deployment group create --resource-group Rg-Az104-Clase-Dos --template-file ./create-disk-template.json
  > az deployment group create --resource-group Rg-Az104-Clase-Dos --template-file ./create-disk-template.json --parameters diskName="vmdisk_1024GB_SSD_2" location="westus"
```
```powershell
 > New-AzResourceGroupDeployment -ResourceGroupName Rg-Az104-Clase-Dos -TemplateFile ./create-disk-template.json
 > New-AzResourceGroupDeployment -ResourceGroupName Rg-Az104-Clase-Dos -TemplateFile ./create-disk-template.json -diskName vmdisk_1024GB_SSD_5 -location westus
```



---




# Active Directory {#active-directory}

## Listar Usuarios AD {#listar-usuarios-ad}

Get-AzAdUser

## Azure AD \- Crear Usuario {#azure-ad---crear-usuario}

Connect-AzureAD

$PasswordProfile \= New-Object \-TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

$PasswordProfile.Password \= "Pa55w.rd12345"

O bien de una 

 New-Object \-TypeName Microsoft.Open.AzureAD.Model.PasswordProfile "Pa55w.rd1234"

New-AzureADUser \-AccountEnabled $True \-DisplayName "DemoEsteban" \-PasswordProfile $PasswordProfile \-UserPrincipalName "DemoEsteban@estebancalabriagmail.onmicrosoft.com" \-MailNickName "DemoEsteban"

## Listar los Resource Providers {#listar-los-resource-providers}

Get-AzResourceProvider

## Ver Rol RBC Asignado a un usuario {#ver-rol-rbc-asignado-a-un-usuario}

Get-AzRoleAssignment \-SignInName esteban.calabria\_gmail.com\#EXT\#@estebancalabriagmail.onmicrosoft.com

## Asignar un rol a un usuario existente {#asignar-un-rol-a-un-usuario-existente}

New-AzRoleAssignment \-RoleDefinitionName Contributor \-SignInName elon@estebancalabriagmail.onmicrosoft.com \-Scope "/subscriptions/91dc3067-fd7a-4ed3-95eb-8c938f69cbfe"

## Ver la definición de un rol {#ver-la-definición-de-un-rol}

Get-AzRoleDefinition \-Name 'Contributor'  
Get-AzRoleDefinition \-Name 'Contributor' | ConvertTo-Json

## Crear un Rol Por CLI {#crear-un-rol-por-cli}

myVirtualMachineContributor.json

{  
    "Name": "Contributor Maquinas Virtuales 2",  
    "IsCustom": true,  
    "Description": "Contributor Maquinas Virtuales 2",  
    "Actions": \[  
        "Microsoft.Authorization/\*/read",  
        "Microsoft.Compute/availabilitySets/\*",  
        "Microsoft.Compute/locations/\*",

        "Microsoft.Support/\*"  
    \],  
    "NotActions": \[\],  
    "AssignableScopes": \[  
        "/subscriptions/91dc3067-fd7a-4ed3-95eb-8c938f69cbfe"  
    \]  
 }

cls  
New-AzRoleDefinition \-InputFile ./myVirtualMachineContributor.json

## Borrar un Rol Creado {#borrar-un-rol-creado}

Remove-AzRoleDefinition \-Name "DemoNuevoRol"
 

---
# Virtual Networks {#virtual-networks}

## Crear Virtual Networks {#crear-virtual-networks}

 New-AzVirtualNetwork \-Name Vnet-RRHH \-ResourceGroupName Az104-Clase-Cuatro \-Location eastus \-AddressPrefix 10.1.0.0/16

## Crear Subnet {#crear-subnet}

### Powershell {#powershell-1}

$vnet \= Get-AzVirtualNetwork \-Name VNet-RRHH

Add-AzVirtualNetworkSubnetConfig \-Name default \-VirtualNetwork $vnet \-AddressPrefix 10.1.0.0/24  
$vnet | Set-AzVirtualNetwork     
//Set-AzVirtualNetwork \-VirtualNetwork $vnet

### Az {#az-1}

az network vnet subnet create \--resource-group Rg-Az104-Clase-Diez \--vnet-name VNet-Az104-Marvel \--name Subnet-Capitan-America \--address-prefixes 10.0.1.0/24

# 

# Network Securty Group {#network-securty-group}

## Crear Un Network Security Group {#crear-un-network-security-group}

### Powershell {#powershell-2}

New-AzNetworkSecurityGroup \`  
\-Name Nsg-Default \`  
\-Location eastus \`  
\-ResourceGroupName Az104-Clase-Cuatro

### Az {#az-2}

az network nsg create \`  
\--resource-group Rg-Az104-Clase-Diez \`  
\--name Nsg-Gob

## Agregar Regla a un NSG {#agregar-regla-a-un-nsg}

$nsg \= Get-AzNetworkSecurityGroup \-Name NSG-Default \-ResourceGroupName Az104-Clase-Cuatro

Add-AzNetworkSecurityRuleConfig \-Name Allow-Rdp \-Description "Permitir RDP" \-Priority 100 \-Direction inbound \-SourceAddressPrefix \* \-SourcePortRange \* \-DestinationAddressPrefix 10.0.0.4 \-DestinationPortRange 3389 \-NetworkSecurityGroup $nsg \-Protocol tcp \-Access Allow

Set-AzNetworkSecurityGroup \-NetworkSecurityGroup $nsg

# Disco {#disco}

## Crear un Disco para una VM {#crear-un-disco-para-una-vm}

New-AzDisk \-DiskName Disco-1 \-ResourceGroupName Rg-Az104-Clase-Cinco  \-Disk (New-AzDiskConfig \-DiskSizeGB 4 \-OsType Windows \-Sku Premium\_LRS \-Location eastus \-CreateOption Empty)

# IP Publica {#ip-publica}

## Crear Una IP Pública {#crear-una-ip-pública}

New-AzPublicIpAddress \-Name IP-1 \-Location eastus \-ResourceGroupName Rg-Az104-Clase-Cinco \-AllocationMethod Static \-Sku Standard

# Network Security Group {#network-security-group}

## Crear Un Network Security Group {#crear-un-network-security-group-1}

New-AzNetworkSecurityGroup \-Name Nsg-Az104-Clase-Cinco \-Location eastus \-ResourceGroupName Rg-Az104-Clase-Cinco

# 

# Virtual Machines {#virtual-machines}

## Habilitar Ping en una maquina virtual {#habilitar-ping-en-una-maquina-virtual}

netsh advfirewall firewall add rule name="Allow ICMPv4" protocol=icmpv4:8,any dir=in action=allow

## Reiniciar Maquina Virtual {#reiniciar-maquina-virtual}

Restart-Computer

## Listar imagenes de maquinas virtuales {#listar-imagenes-de-maquinas-virtuales}

 az vm image list

## Crear una máquina virtual nueva {#crear-una-máquina-virtual-nueva}

### Default {#default}

New-AzVM \-Name myAz104Vm \-ResourceGroupName Az104-Clase-Dos \-Location eastus \-ImageName Win2016Datacenter

### En una Vnet existente {#en-una-vnet-existente}

New-AzVM \-Name myAz104VMSecundaria \-ResourceGroupName AZ104-Clase-Tres \-Image Win2019DataCenter \-VirtualNetworkName myAz104VNet \-SubnetName uno \-Location eastus

### En un VNet y NSG {#en-un-vnet-y-nsg}

New-AzVM \-Name myAz104VMSecundaria \-ResourceGroupName AZ104-Clase-Tres \-Image Win2019DataCenter \-VirtualNetworkName myAz104VNet \-SubnetName uno \-Location eastus \-SecurityGroupName NSG-Default

### 

### Especificando uncls Usuario y Pass {#especificando-uncls-usuario-y-pass}

#### Crear Credencial {#crear-credencial}

$Credential \= New-Object \-TypeName System.Management.Automation.PSCredential \-ArgumentList "AzureUser", (ConvertTo-SecureString \-String "Pa55w.rd1234" \-AsPlainText \-Force)

$cred \= New-Object \`  
       \-TypeName System.Management.Automation.PSCredential \`  
        ("AzureUser", (ConvertTo-SecureString \-String "Pa55w.rd1234" \-AsPlainText \-Force))    

#### CrearVM {#crearvm}

New-AzVM \`  
\-Name myVm \`  
\-ResourceGroupName SandBox \`  
\-Image Win2019DataCenter \`  
\-Credential $Credential

### Especificar Tamaño VM y Segundo Disco {#especificar-tamaño-vm-y-segundo-disco}

New-AzVM \-Name Vm-RRHh \-ResourceGroupName AZ104-Clase-Cuatro \-Image Win2019DataCenter \-VirtualNetworkName VNet-RRHH \-SubnetName default \-Location eastus \-SecurityGroupName NSG-Default \-DataDiskSizeInGb 64 \-Size Standard\_DS1\_v2  
***Esto crea un segundo disco***

## Reiniciar una VM {#reiniciar-una-vm}

az vm restart \-n myAz104Vm \-g Az104-Clase-Dos

# Utils {#utils}

## Instalar IIS en una maquina {#instalar-iis-en-una-maquina}

Install-WindowsFeature \-name Web-Server \-IncludeManagementTools

## Listar Los trabajos Pendientes {#listar-los-trabajos-pendientes}

Get-Job

### Crear un root certificate {#crear-un-root-certificate}

$cert \= New-SelfSignedCertificate \-Type Custom \-KeySpec Signature \-Subject "CN=P2SRootCert" \-KeyExportPolicy Exportable   
\-HashAlgorithm sha256 \-KeyLength 2048   
\-CertStoreLocation "Cert:\\CurrentUser\\My" \-KeyUsageProperty Sign \-KeyUsage CertSign

New-SelfSignedCertificate \-Type Custom \-DnsName P2SChildCert \-KeySpec Signature \` \-Subject "CN=P2SChildCert" \-KeyExportPolicy Exportable \-HashAlgorithm sha256 \-KeyLength 2048 \-CertStoreLocation "Cert:\\CurrentUser\\My" \-Signer $cert \-TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")  
