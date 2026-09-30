# Clase 5 - 29 de Septiem bre del 2026

# Repaso

* IAC
  * ARM Template
    * Los desplegamos desde el portal en ejemplo
    * copyIndex() para hacer como un for
    * Idempotentes
  * Bicep
    * Lo desplegamos con el cli en un ejemplo
  * Terraform
* Networking
  * Segmentacion de Redes y Suredes
  * Sintaxis para definir un rango de ips : CIDR (10.0.0.0/24)
  * Network Topology

---

# Networking

## Setup

* Crear el RG

```
New-AzResourceGroup -Name rg-az104-clase-05 -Location westus
```

* Crear la Vnet-10.0
  * Direcciones 10.0.0.0/16
    * Subnet subnet-10.0.0
      * 10.0.0.0/24
      * 255 - direcciones reservadas
    * Subnet subnet-10.0.1
      * 10.0.0.0/24
      * 255 - direcciones reservadas

* Network Security Group (NSG)
  * Es el que controla el trafico en la red
  * Posee una serie de reglas donde se define que trafico esta permitido y cuales  no
  * Cuando creamos una virtual se crea un nsg automaticamente, pero ahora lo vamos a crear nosotos manualemnte
 
* Crear el NSG
  * Name : nsg-az104-clase-05
  * Tomense un minuto para explorar la opcion del NSG mirando especialmente las inbound/outbound rules

* Crear una VM en la subnet-10.0.0 asociada al NSG nsg-az104-clase-05
  * Region : La misma que las vnet
  * Name : vm-az104-clase-05-00
  * Vnet : Vnet-10.0
  * Subnet: subnet-10.0.0
  * NSG :(advanced) -> nsg-az104-clase-05

* Ir a la VM Creada
  * Tomarse unos minutos para explorar las opciones de la VM
  * En el overview veo que la vm tiene una ip publica a la cual me conectaria por RDP (si me deja)
  * Sino en la solapa connect puedo bajar un archivo de  conexxion para RDP
  * El puerto del RDP es 3389

* Me trato de conectar a la VM por RDP y no conecta

<img width="431" height="185" alt="image" src="https://github.com/user-attachments/assets/ebc03deb-9af7-4964-b5ed-d5a6232d6d1b" />

* Porque???  -> Porque el NSG no permite conexiones desde internet a la VM por el puerto 3389

* Vamos a crear la regla en el NSG

<img width="377" height="363" alt="image" src="https://github.com/user-attachments/assets/715de120-8594-4cee-b2c1-468b92c60122" />

* Nombre: Allow-RDF-From-My-IP

* Tratemos de conectarnos de vuelta por RDP
  * Ahora siiiiiiiiiiiiiiiiiiiiiiiiiiii
    
* Para continuar luego vamos a exportar todo lo que hicimos como un template ARM
  * Vamos al Resource Group
  * Elegimos todos los recursos
  * Exportamos el template sin parametros

```
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {},
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2025-07-01",
            "name": "nsg-az104-clase-05",
            "location": "westus",
            "properties": {
                "securityRules": [
                    {
                        "name": "Allow-RDP-From-My-Ip",
                        "id": "[resourceId('Microsoft.Network/networkSecurityGroups/securityRules', 'nsg-az104-clase-05', 'Allow-RDP-From-My-Ip')]",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "3389",
                            "sourceAddressPrefix": "152.170.190.55",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 100,
                            "direction": "Inbound",
                            "sourcePortRanges": [],
                            "destinationPortRanges": [],
                            "sourceAddressPrefixes": [],
                            "destinationAddressPrefixes": []
                        }
                    }
                ]
            }
        },
        {
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2025-07-01",
            "name": "vm-az104-clase-05-00-ip",
            "location": "westus",
            "sku": {
                "name": "Standard",
                "tier": "Regional"
            },
            "properties": {
                "ipAddress": "20.245.202.31",
                "publicIPAddressVersion": "IPv4",
                "publicIPAllocationMethod": "Static",
                "idleTimeoutInMinutes": 4,
                "ipTags": [],
                "ddosSettings": {
                    "protectionMode": "VirtualNetworkInherited"
                }
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
                        "name": "subnet-10.0.0",
                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.0', 'subnet-10.0.0')]",
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
                        "name": "subnet-10.0.1",
                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.0', 'subnet-10.0.1')]",
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
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2026-03-01",
            "name": "vm-az104-clase-05-00",
            "location": "westus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkInterfaces', 'vm-az104-clase-05-00138')]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "Standard_D2ads_v6"
                },
                "additionalCapabilities": {
                    "hibernationEnabled": false
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "MicrosoftWindowsServer",

           "offer": "WindowsServer",
                        "sku": "2025-datacenter-g2",
                        "version": "latest"
                    },
                    "osDisk": {
                        "osType": "Windows",
                        "name": "vm-az104-clase-05-00_OsDisk_1_c6c4d64afc374f268580a6826513f619",
                        "createOption": "FromImage",
                        "caching": "ReadWrite",
                        "managedDisk": {
                            "storageAccountType": "Premium_LRS",
                            "id": "[resourceId('Microsoft.Compute/disks', 'vm-az104-clase-05-00_OsDisk_1_c6c4d64afc374f268580a6826513f619')]"
                        },
                        "deleteOption": "Delete",
                        "diskSizeGB": 127
                    },
                    "dataDisks": [],
                    "diskControllerType": "NVMe"
                },
                "osProfile": {
                    "computerName": "vm-az104-clase-",
                    "windowsConfiguration": {
                        "provisionVMAgent": true,
                        "enableAutomaticUpdates": true,
                        "patchSettings": {
                            "patchMode": "AutomaticByOS",
                            "assessmentMode": "ImageDefault",
                            "enableHotpatching": false
                        }
                    },
                    "secrets": [],
                    "allowExtensionOperations": true,
                    "requireGuestProvisionSignal": true,
                    "adminUsername": "AzureUser"
                },
                "securityProfile": {
                    "uefiSettings": {
                        "secureBootEnabled": true,
                        "vTpmEnabled": true
                    },
                    "encryptionAtHost": true,
                    "securityType": "TrustedLaunch"
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', 'vm-az104-clase-05-00138')]",
                            "properties": {
                                "deleteOption": "Detach"
                            }
                        }
                    ]
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true
                    }
                }
            }
        },
        {
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "apiVersion": "2025-07-01",
            "name": "nsg-az104-clase-05/Allow-RDP-From-My-Ip",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', 'nsg-az104-clase-05')]"
            ],
            "properties": {
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "3389",
                "sourceAddressPrefix": "152.170.190.55",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 100,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": []
            }
        },
        {
            "type": "Microsoft.Network/virtualNetworks/subnets",
            "apiVersion": "2025-07-01",
            "name": "vnet-10.0/subnet-10.0.0",
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
            "name": "vnet-10.0/subnet-10.0.1",
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
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2025-07-01",
            "name": "vm-az104-clase-05-00138",
            "location": "westus",
            "dependsOn": [
                "[resourceId('Microsoft.Network/publicIPAddresses', 'vm-az104-clase-05-00-ip')]",
                "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.0', 'subnet-10.0.0')]",
                "[resourceId('Microsoft.Network/networkSecurityGroups', 'nsg-az104-clase-05')]"
            ],
            "kind": "Regular",
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "id": "[concat(resourceId('Microsoft.Network/networkInterfaces', 'vm-az104-clase-05-00138'), '/ipConfigurations/ipconfig1')]",
                        "properties": {
                            "privateIPAddress": "10.0.0.4",
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', 'vm-az104-clase-05-00-ip')]",
                                "properties": {
                                    "deleteOption": "Detach"
                                }
                            },
                            "subnet": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-10.0', 'subnet-10.0.0')]"
                            },
                            "primary": true,
                            "privateIPAddressVersion": "IPv4"
                        }
                    }
                ],
                "dnsSettings": {
                    "dnsServers": []
                },
                "enableAcceleratedNetworking": true,
                "enableIPForwarding": false,
                "disableTcpStateTracking": false,
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups', 'nsg-az104-clase-05')]"
                },
                "nicType": "Standard",
                "auxiliaryMode": "None",
                "auxiliarySku": "None"
            }
        }
    ]
}
```

---
BREAK
Hasta 2030
---

*  Vamos a iniciar el laboratorio de vuelta y vamos  levantar el template

> [!NOTE]
> Creo todo menos la VM. La VM la tuvimos que crear aparte


* Crear otra VNET igual. La 10.1.0.0/16

  <img width="485" height="223" alt="image" src="https://github.com/user-attachments/assets/9df743af-3911-4ba8-91b9-fea009cb236d" />

* Crear otra VM en la VNet La 10.1.0.0/16
  * Aca vamos a ver que el NSG se crea automaticamente porque no lo cree antes
  * Verificamos que al crear la nueva virtual se creo automaticamente un nsg y una regla de inbound para RDP

* Me conecto a la segunda VM por RDP tambien

* Ademas de la IP publica observo que las maquinas cada una tiene una ip privada
    * vm-az105-clase-05-00  -> 10.0.0.5
    * vm-az105-clase-05-01  -> 10.1.0.4

* Si dentro de la primera VM trato de conectarme por RDP a la segunda vm por su ip privada confirmo que no se ven

<img width="1363" height="621" alt="image" src="https://github.com/user-attachments/assets/2105f1b9-d56c-4ba5-8e11-bc3eaed84a4c" />

* Para que se vean ambas vnet tengo que establecer lo que se llama vnet-peering

* Vamos a
  * vnet-10.0 -> Settings -> Peering -> Add
    * Name : vnet-10.0-a-vnet-10.1

<img width="524" height="246" alt="image" src="https://github.com/user-attachments/assets/c0324c46-bc56-4cbc-896f-542a164cbe6e" />

* Ahora tratemos de hacer RDP desde la primera a la segunda mediante su IP privada

# Probar la conectividad con Network Watcher

* Buscamos el recurso "Network Watcher"
  * Probemos el NSG Diagnostics
      * Este permite evaluar que reglas del NSG se aplican en una conexion y si la misma es permitida o n o
  * Probemos el IP Flow Verify



