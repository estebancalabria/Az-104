<img width="1358" height="2268" alt="image" src="https://github.com/user-attachments/assets/4a90e272-cb49-45a1-bc88-0828ce16a38f" /># Clase Seis - 1 de Octubre del 2026

# Repaso

* Networking
  * Virtual Network
  * Network Secutiry Group (NSG)
  * Creamos VM
    * Conexion por RDP
  * Importarcion del ARM template
  * VNet Peering
  
# Networking

* Hoy queremos instalar un Load Balancer

```mermaid
flowchart TB

    User([👤 User])

    subgraph RG["az104-06-rg6"]

        LB["Load Balancer<br/>az104-lb<br/>az104-lbpip"]

        subgraph VNET["az104-06-vnet1 (10.60.0.0/22)"]

            subgraph S0["Subnet0<br/>10.60.0.0/24"]
                VM0["az104-06-vm0<br/>10.60.0.4"]
            end

            subgraph S1["Subnet1<br/>10.60.1.0/24"]
                VM1["az104-06-vm1<br/>10.60.1.4"]
            end

            Backend["Backend Pool"]

            Backend --- VM0
            Backend --- VM1
        end
    end

    User --> LB
    LB --> Backend

    VM0 <--> VM1
```

## Setup

* Abrimos el CLI
  
* Creamos el RG

```
az group create --name rg-az104-clase-06 --location westus
```

* Crear la VNet

```powershell
New-AzVirtualNetwork -Name Vnet-10.0 -ResourceGroupName rg-az104-clase-06 -Location westus -AddressPrefix 10.0.0.0/16
```

* Crear la SubNet

```bash
 az network vnet subnet create --resource-group rg-Az104-Clase-06 --vnet-name VNet-10.1 --name subnet-10.0.0 --address-prefixes 10.0.0.0/24     
```

* Creo dos VM (con el portal)
    *  El mismo proceso por duplicado
    *  Name: vm-webserver-00  y vm-webserver-01
    *  Las dos en la misma subnet que creamos antes
    
*  Me van a quedar con IP
  *  10.0.0.4
  *  10.0.0.5

*  Tambien se crearon 2 NSG
  *  vm-webserver-00-nsg
  *  vm-webserver-01-nsg

*  Me voy a conectar a las vm y les voy a instalar IIS en ambas
    *  Me conecto a las 2 vm por RDP
    *  Abro powershell
    *  Ejecuto en ambas

```
Install-WindowsFeature -name Web-Server -IncludeManagementTools
```

* Mientras lo instala vamos a tener que habilitar en los NSG el puerto 80 y 443 (x2)

 <img width="770" height="53" alt="image" src="https://github.com/user-attachments/assets/75dfbc81-880b-42f3-b938-e6f8b6ca5f84" />

* Chequear que se puede acceder al IIS desde mi pc local

* Una vez Instalado el IIS rescribimos el archivo del home con un string personal

```
Set-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value "Hola desde webserver--00"
```
> Cambiar Hola desde webserver--01



