# Clase Cinco - 04 de Agosto de 2026

# Repaso

* Policy
* Azure Resource Manager
  * La pi de Azure
* Infraestructura como Codigo (IaC) 
  * ARM Templates
    * Archivos JSON
  * Bicep Templates
    * Lenguaje propio
    * Extension en vscode
  * El "for" en un template (con el copy)
    * Por si aparecia en el examen
  * Los templates son idempotentes (complementan lo que faltan_
  * Desplegar templates en el CLI
  * Terraform
    * Lenguaje para IaC multi cloude
    * https://developer.hashicorp.com/terraform
* CLI
  * Subir achivos al cli
  * USar el vscode de texto en CLI

---

# Calcular costos Azure

* https://azure.microsoft.com/en-us/pricing/calculator/

---
# Networking


* Primero creamos un Resource Group

```
New-AzResourceGroup -Name rg-az104-clase-04 -Location westus
```

## Virtual Networks

> [!NOTE]
> Las vnet son recursos de infraestructura qeu se definen al principio
> Recomiendo ver el CAF con recomendaciones como estructurar las redes de mi empresa

* Buscar con la abreviacion (vnet) el recurso de Virtual Netrwork
* Vamos a crear una Vnet
  * Cada VNet tiene un rango de IPS
  * Cada VNEt tiene su rango de IPS reservadas para IP Locales
    * 10.0.0.0 - 10.255.255.255
    * 192.168.1.1 - 192.168.255.255
    * Por ejemplo una VNEt pueede tener el rango de de im desde 10.0.0.0 a 10.0.255.255 (Esta la llamo la VNET 0)
    * A su vez por un tema de organizacion y buenas practicas las VNet se dividen en subnets
      * vnet - 10.0.XXX.XXX tiene
        * Subnet 1 - 10.0.0.0 a las 10.0.0.255 (Permite 255 hosts esta subnet)
      * Algunos recursos como el firewall, el bastion van en su propia subbet

* Creamos una VNEt
  * Nombre : vnet-10.0
  * Adress Space : 10.0.0.0 / 16
    * 10.0 (16 bits quedan fijos)
    * Va del 10.0.0.0 al 10.0.255.255
  * Borro la subnet asi la agrego luego

 * Crear dos subnet
   * vnet-10.0-subnet-0
     * 10.0.0.0 / 24
     * De 10.0.0.0 a 10.0.0.255 (256 host)
   * vnet-10.0-subnet-1
     * 10.0.1.0 / 24
     * De 10.0.1.0 a 10.0.1.255 (256 host)

# NSG (Network Security Group)

* Es una especie de firewall donde se define el trafico permitido entre redes internas y con exterior
  * Es una capa de seguridad
  * Es el recurso principal que administra el administrador de azure

* En el buscador de recursos poner la abreviacion nsg y te lleva al recurso "Network Security Group"
* Creamoe el NSG
  * Name : nsg-az104-clase-04

* Para definir las reglas de trafico un NSG se puede asociar con:
  * Una subnet
  * Una NIC (una placa de red)
  * Un ASG (Application Security Group)
 
# Network Watcher

* Esta opcion te permite visualizar tu arquitectura de red
* Tambien tiene un monton de opciones de diagnostico

---
> [NOTE]
> Vamos a exportar el ARM template de lo que hicimos para volver a armar la estructura luego

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {},
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2025-07-01",
            "name": "nsg-az104-clase-04",
            "location": "westus",
            "properties": {
                "securityRules": []
            }
        },
        {
            "type": "Microsoft.Network/virtualNetworks",
            "apiVersion": "2025-07-01",
            "name": "vnet-10.0",
            "location": "westus",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "10.0.0.0/16"
                    ]
                },
                "encryption": {
                    "enabled": false,
                    "enforcement": "AllowUnencrypted"
                },
                "privateEndpointVNetPolicies": "Disabled",
                "subnets": [
                    {
                        "name": "vnet-10.0-subnet-0",
                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.0', 'vnet-10.0-subnet-0')]",
                        "properties": {
                            "addressPrefixes": [
                                "10.0.0.0/24"
                            ],
                            "delegations": [],
                            "privateEndpointNetworkPolicies": "Disabled",
                            "privateLinkServiceNetworkPolicies": "Enabled",
                            "defaultOutboundAccess": false
                        }
                    },
                    {
                        "name": "vnet-10.0-subnet-1",
                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.0', 'vnet-10.0-subnet-1')]",
                        "properties": {
                            "addressPrefixes": [
                                "10.0.1.0/24"
                            ],
                            "delegations": [],
                            "privateEndpointNetworkPolicies": "Disabled",
                            "privateLinkServiceNetworkPolicies": "Enabled",
                            "defaultOutboundAccess": false
                        }
                    }
                ],
                "virtualNetworkPeerings": [],
                "enableDdosProtection": false
            }
        },
        {
            "type": "Microsoft.Network/virtualNetworks/subnets",
            "apiVersion": "2025-07-01",
            "name": "vnet-10.0/vnet-10.0-subnet-0",
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks', 'vnet-10.0')]"
            ],
            "properties": {
                "addressPrefixes": [
                    "10.0.0.0/24"
                ],
                "delegations": [],
                "privateEndpointNetworkPolicies": "Disabled",
                "privateLinkServiceNetworkPolicies": "Enabled",
                "defaultOutboundAccess": false
            }
        },
        {
            "type": "Microsoft.Network/virtualNetworks/subnets",
            "apiVersion": "2025-07-01",
            "name": "vnet-10.0/vnet-10.0-subnet-1",
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks', 'vnet-10.0')]"
            ],
            "properties": {
                "addressPrefixes": [
                    "10.0.1.0/24"
                ],
                "delegations": [],
                "privateEndpointNetworkPolicies": "Disabled",
                "privateLinkServiceNetworkPolicies": "Enabled",
                "defaultOutboundAccess": false
            }
        }
    ]
}
```

---

# Crear una VM

* Vamos a crear una VM pero en estas subnet
 * Busco en recursos con la abreviacion vm
  * Name : vm-az104-1
  * Prestar atencion a la solapa de networking
    * Que la VM quede vinculada a una vnet y subnet de las que habiamos creado antes
    * Que la VM quede asociada al NSG que creamos anteriormente (sino ponemos nada crea uno nuevo solo para la VM)

<img width="531" height="294" alt="image" src="https://github.com/user-attachments/assets/715551cc-64cc-4767-808e-42507d8a285e" />

* Luego que la VM esta creada ir a la VM y luego a netwok Settings
  * Navegar de la VM -> NIC
  * Navegar de la VM -> Public IP
  * Navegar de la VM -> NSG
* IR al NSG y verificar que esta asociado con la NIC

* Voy a tratar de conectarme con la PC por RDP
  * No me deja
  * Tengo que habilitar el 3389 en el NSG
 
* Habilitar el RDP en el NSG

<img width="377" height="357" alt="image" src="https://github.com/user-attachments/assets/454d4b18-ad15-468b-b2a8-a3e08e378253" />

* Voy a tratar de conectarme de nuevo
  * Ahor si puedo

> [!NOTE]
> Cuando cree el NSG no tenia habilitado el puerto 3389. Cuando se lo habilite. Ahi pude conectarme a la VM
