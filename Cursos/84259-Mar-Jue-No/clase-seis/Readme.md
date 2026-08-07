# Clase Seis - 6 de Agosto del 2026


# Repaso

* Networking
  * Virtuan Network (vnet)
      * Segmentacion en VNets y Subnets
  * Network Security Group (nsg)
    * Definicion de las reglas
    * Habilitar el 3389 para el RDP
  * Network Watcher
    * Hacer un grafico de la topologia de la red
  * Recomendaciones del CAF
  * Armar un ARM template con la configuracion de la RED
* Virtual Machines (vm)
  * Coneccion por RDP

---

# Administracion de Redes

* Crear el RG

```
New-AzResourceGroup -Name rg-az104-clase-06 -Location Westus
```

* Crear dos VNet con Dos Subnet cada Una desde el portal
    * vnet-10.0 (10.0.0.0/16)
      * vnet-10.0-subnet-0 (10.0.0.0/24)
      * vnet-10.0-subnet-1 (10.0.1.0/24)
    * vnet-10.1 (10.1.0.0/16)
       * vnet-10.1-subnet-0 (10.1.0.0/24)
       * vnet-10.1-subnet-1 (10.1.1.0/24)

* Observar la topologia en "Network Watcher"

* Crear dos NSG
  * nsg-vnet-10.0
  * nsg-vnet-10.1
  * (Por ahora estan sueltos, pero por el nombre me doy cuenta donde va cada uno)
      * Un NSG se puede asociar con
          * una subnet
          * una NIC
          * un ASG (Aplication Security Group)
            * Es un conjunto de NICS



> [!NOTE]
> Los NSG tienen que estar en la misma region que la vnet

* Guardar el template

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
            "name": "nsg-vnet-10.0",
            "location": "westus",
            "properties": {
                "securityRules": []
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2025-07-01",
            "name": "nsg-vnet-10.1",
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
            "type": "Microsoft.Network/virtualNetworks",
            "apiVersion": "2025-07-01",
            "name": "vnet-10.1",
            "location": "westus",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "10.1.0.0/16"
                    ]
                },
                "encryption": {
                    "enabled": false,
                    "enforcement": "AllowUnencrypted"
                },
                "privateEndpointVNetPolicies": "Disabled",
                "subnets": [
                    {
                        "name": "vnet-10.1-subnet-0",
                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.1', 'vnet-10.1-subnet-0')]",
                        "properties": {
                            "addressPrefixes": [
                                "10.1.0.0/24"
                            ],
                            "delegations": [],
                            "privateEndpointNetworkPolicies": "Disabled",
                            "privateLinkServiceNetworkPolicies": "Enabled",
                            "defaultOutboundAccess": false
                        }
                    },
                    {
                        "name": "vnet-10.1-subnet-1",
                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.1', 'vnet-10.1-subnet-1')]",
                        "properties": {
                            "addressPrefixes": [
                                "10.1.1.0/24"
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
        },
        {
            "type": "Microsoft.Network/virtualNetworks/subnets",
            "apiVersion": "2025-07-01",
            "name": "vnet-10.1/vnet-10.1-subnet-0",
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks', 'vnet-10.1')]"
            ],
            "properties": {
                "addressPrefixes": [
                    "10.1.0.0/24"
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
            "name": "vnet-10.1/vnet-10.1-subnet-1",
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks', 'vnet-10.1')]"
            ],
            "properties": {
                "addressPrefixes": [
                    "10.1.1.0/24"
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


* Crear dos VM
    * Una en vm-10-0-subnet-0
    * Otra en vm-10-1-subnet-0

* Trarar de conectarme por RDP al vm-10-0-subnet-0
  * No me puedo conectar
* Agregar el RDP al NSG
  * Ahi me puedo conectar
 
* Abrir un RDP en la maquina remota y me voy a intentar conectar pero por la IP privada (10.1.0.4)
    * No conectan porque las dos redes no se ven
    * Tengo que establecer un VNET peering para que las dos redes se puedan comunicar
* Hacer un peering entre las dos VNET

<img width="174" height="262" alt="image" src="https://github.com/user-attachments/assets/ed75cedc-991b-41bc-ae8a-5f8971f6e155" />

* Ahora si me puedo conectar....

# Teoria de VMs y Azure

 * UN VMSS (Virtual Machine Scale Set) permite crear muchas (1 a 1000) Vms identicas
     * Fault Domain (Un rack que si cae, se cae todo lo que sta adentro)
     * Update Domain (Es en grupo de VMS que se actualizan todas juntas)
       * Hasta 20
      
* Los Tags sirven para agrupar recursos por ejemplo por departamento
