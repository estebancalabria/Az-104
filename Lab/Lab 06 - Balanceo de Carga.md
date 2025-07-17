# Laborarorio Balanceo de Carga

1. Crear un Resource Group

```powershell
az group create --name Rg-Az104-Clase-Cinco --location westus      
```

2. Crearmos una VNet

```powershell
New-AzVirtualNetwork -Name Vnet-RRHH -New-AzVirtualNetwork -Name Vnet-RRHH -ResourceGroupName Az104-Clase-Cuatro -Location eastus -AddressPrefix 10.1.0.0/16
```

3. Crear dos subnets

> Lo hicimos con el portal

4. Crear un NSG

```powershell
 New-AzNetworkSecurityGroup -Name Nsg-Default -Location westus -ResourceGroupName Rg-Az104-Clase-Cinco
```

5.  Crear regla en el NSG para habilitar RDP, HTTP y HTTPS a toda la Virtual Network

Lo hacemos con el portal:  

**RDP**
* Priority : 100
* Name : Allow-MyIpAddress-2-Vnet10.1-RDPInbound
* Port : 3389
* Protocol : TCP
* Source : (Mi Ip Local)
* Destination : 10.1.0.0/16
* Action : Allow
   
**HTTP**
* Priority : 110
* Name : Allow-MyIpAddress-2-vnet10.1-HTTPInbound
* Port : 80
* Protocol : TCP
* Source : (Mi Ip Local)
* Destination : 10.1.0.0/16
* Action : Allow
   
**HTTPS**
* Priority : 120
* Name : Allow-MyIpAddress-2-vnet10.1-HTTPSInbound
* Port : 443
* Protocol : TCP
* Source : (Mi Ip Local)
* Destination : 10.1.0.0/16
* Action : Allow
6. Crear 2 VMs, una en cada Subnet

> Lo creamos por el portal

7. Conectarnos a las virtuales por RDP y habilitar el pint y el IIS

``` powershell
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -All
New-NetFirewallRule -Name AllowPing -DisplayName "Permitir ICMPv4" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow -Enabled True
```
> Verificar que se pueda navegar a localhost

8. Personalizar home del IIS en ambas vm

Modificar el archivo C:\inetpub\wwwroot\iistart

```html
<html>
<body>
  <h1>Hola soy la vm Iron Man</h1>
</body>
</html>
```

9. Verificar acceder al home del IIS tanto desde la VM como desde mi pc LOCAL

10. 
11. 



12. 
13.  

3. 
