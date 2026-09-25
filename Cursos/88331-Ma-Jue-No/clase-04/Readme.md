# Clase 04 - 24 de Septiembre del 2026

# Repaso

* Uso del Cli
  * Comando de Powershell
* Policy
  * Definicion de Policy
    * Tipos de Policy
        * Iniciativas -> Grupos de Policies Individuales
        * Policy Individuales
    * Definiciones por el usuario
        * Definiamos en un Json
    * Asignacion de Policy
        * A nivel Managament Group
        * A nivel Subscripcion
        * A nivel RG
        * A nivel recurso
  * Ejemplos de Policy
    * Nomenclatura de nombre
    * Tamanio de recurso
    * Ubicaciones donde ponemos los recursos
    * Policas de seguridad
* Management Group
* Administracion de costo
    * Calcula de costos
    * Budgets
    * Alarmas
    * Tags
* Mandar un ticket a soporte
 
---

# IAC (Infraestructura como codigo)

## ARM Templates / Bicep Templates

* Setup
  * Creamos el RG

* Creamos un disco
  * Name
    * disk-01
  * Source
    * None
  * Resto de las opciones como viene por defecto
  * Pero no le damos create, en vez de eso vamos al link "Download a template for automation"
 
* Le saco el tilde de "Include Parameters" y le doy "Download" me baja este json (que tuve que retocar con IA)

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "diskName": {
      "type": "string",
      "defaultValue": "disk-01"
    },
    "location": {
      "type": "string",
      "defaultValue": "westus"
    }
  },
  "resources": [
    {
      "apiVersion": "2025-01-02",
      "type": "Microsoft.Compute/disks",
      "name": "[parameters('diskName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "StandardSSD_LRS"
      },
      "properties": {
        "creationData": {
          "createOption": "Empty"
        },
        "diskSizeGB": 1024,
        "encryption": {
          "type": "EncryptionAtRestWithPlatformKey"
        },
        "dataAccessAuthMode": "None",
        "networkAccessPolicy": "AllowAll",
        "publicNetworkAccess": "Enabled"
      }
    }
  ]
}
```
Con este json creo el archivo template-un-disco-full.json

> [!NOTA]
> Los template son idempotentes : los podes ejecutar varias veces y siempre obtenes el mismo resultado. Si hay parte de la infraestructura que ya existe solo crea lo que falta

* Busco la opcion "Deploy Custom Template"

<img width="408" height="35" alt="image" src="https://github.com/user-attachments/assets/17a96747-f0ba-45d9-8702-7480a529dc3f" />

* Elegir "Build your own template in the editor"

* Cargar en la interfaz copiando y pegando o haciendo load file el template que esta mas arriba

* Crear el disco

## Crear 10 discos de una

* Ahora vamos a crear 10 duscos de una con este template

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "location": {
      "type": "string",
      "defaultValue": "westus"
    }
  },
  "resources": [
    {
      "apiVersion": "2025-01-02",
      "type": "Microsoft.Compute/disks",
      "name": "[format('disk-{0}', format('{0:00}', copyIndex(1)))]",
      "location": "[parameters('location')]",
      "copy": {
        "name": "diskCopy",
        "count": 10
      },
      "sku": {
        "name": "StandardSSD_LRS"
      },
      "properties": {
        "creationData": {
          "createOption": "Empty"
        },
        "diskSizeGB": 1024,
        "encryption": {
          "type": "EncryptionAtRestWithPlatformKey"
        },
        "dataAccessAuthMode": "None",
        "networkAccessPolicy": "AllowAll",
        "publicNetworkAccess": "Enabled"
      }
    }
  ]
}
```

* Ahora hacemos un deploy con ese json

## Bicep Template

* Vamos a convertir el primer template en un template bicep (parece una especie de diccionario de python)

```bicep
param diskName string = 'disk-bicep'
param location string = 'westus'

resource disk 'Microsoft.Compute/disks@2025-01-02' = {
  name: diskName
  location: location
  sku: {
    name: 'StandardSSD_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 1024
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    dataAccessAuthMode: 'None'
    networkAccessPolicy: 'AllowAll'
    publicNetworkAccess: 'Enabled'
  }
}
```

* Lo guardamos en un archivo template-un-disco-full.bicep

* Si tengo instala la extension bicen en vscode tengo colorcitos y auto completado

 <img width="218" height="110" alt="image" src="https://github.com/user-attachments/assets/70b68378-d924-4fcc-ae7d-71efc801ab0e" />

* Primero lo subimos al CLI

<img width="326" height="125" alt="image" src="https://github.com/user-attachments/assets/6a12fba1-f9f3-4e3f-952e-0c31614b4bcd" />


* Lo desplegamos desde el cli

```bash
az deployment group create --resource-group rg-az104-clase-04 --template-file ./template-un-disco-full.bicep
```

## Terraform Template

* No son de microsoft
* Es una tecnologia que permite definir la infraestructura para varios Cloud

```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  type    = string
  default = "westus"
}

variable "disk_name" {
  type    = string
  default = "disk-01"
}

resource "azurerm_managed_disk" "disk" {
  name                 = var.disk_name
  location             = var.location
  resource_group_name  = "rg-example"
  storage_account_type = "StandardSSD_LRS"
  disk_size_gb         = 1024
  create_option        = "Empty"
}
```

---
# BREAK 
Hasta y 45
---

# Redes

* Intro a la parte de Redes...
* Son la base de comunicacion entre muchos recursos de Azure
* Son requisito necesario para desplegar nuestram VM

> [!NOTE]
> Alguno de ustedes se junto con amigos en un casa a armar una LAN Party?
> Llevaban las compus, habia que llevar un switch   ---> Algo asi en Azure

* Hay Ips Publicas
* Hay IPS reservadas para ip local -> 127.0.0.01 -> 192.168.XX.XX -> 10.XX.XX.XX

* Repasando un poco con ChatGPT

```
Sí. Son **rangos de IP privadas** definidos por RFC 1918:

* **10.0.0.0/8** → `10.0.0.0` a `10.255.255.255` → **16.777.216 IPs**
* **172.16.0.0/12** → `172.16.0.0` a `172.31.255.255` → **1.048.576 IPs**
* **192.168.0.0/16** → `192.168.0.0` a `192.168.255.255` → **65.536 IPs**

Lo de **clase A, B y C** es el esquema antiguo de direccionamiento:

| Rango privado | Antigua clase | Cantidad de direcciones |
| ------------- | ------------- | ----------------------: |
| `10.x.x.x`    | **Clase A**   |          ~16,7 millones |
| `172.16.x.x`  | **Clase B**   |               ~1 millón |
| `192.168.x.x` | **Clase C**   |                  65.536 |

Pero **hoy se habla de CIDR**, no de clases. Por eso es más correcto decir:

> **10.0.0.0/8 es un bloque privado mucho más grande que 192.168.0.0/16.**

Y sí: **10.x.x.x permite muchísimas más direcciones privadas que 192.168.x.x**.

```

* Las Virtual Netrwork van a usar alguna de esos rangos de IP,

* Vamos a crear nuestra primer Virtual network (vnet)
  * Name: vnet-10.0
  * Es importante la region, porque es mas facil que dos redes se cominiquen si estan en la misma region (mismo data center)

<img width="520" height="263" alt="image" src="https://github.com/user-attachments/assets/18e98b48-4d12-45a7-8ef1-c6d02c56fe34" />

* Adress Space 10.0.0.0 / 16
  * /16 los primeros 16 bits, los primeros dos octetos quedan fijos
  * 10.0.0.0 a 10.0.255.255 

<img width="485" height="165" alt="image" src="https://github.com/user-attachments/assets/fbbbbca3-29f5-4577-8def-e0a275504d29" />

* Creamos la Red

* Creamos dos subnet
  * 10.0.0.0 / 24
    * 10.0.0.0 a 10.0.0.255
  * 10.0.1.0 / 24
    * 10.0.1.0 a 10.0.1.255
   
* Visualizar las redes en la parte de Network Topology

<img width="449" height="291" alt="image" src="https://github.com/user-attachments/assets/60b35afa-5c1b-48ed-9936-b5bc653afd74" />
