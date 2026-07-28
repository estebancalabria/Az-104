# Clase Cuatro - 28 de Julio 2026

# Repaso

* Microsoft Entra
  * Roles RBAC
    * Privilegiados
      * Owner
      * Contributor
      * Reader
* Azure Policy
  * Policies
    * Built-in
    * Custom
      * Las definiamos en JSON
  * Iniciativas (Grupo de Policies)
  * Asignacion de Una policy
* CLI
  * Uso desde Powershell y bash (comando aaz)

 ---

 # Administracion de Azure

 * Los locks sobre grupos de recursos son una forma sencilla de evitar que otra persona nos borre un rg por accidente
   * Vamos a crear un lock de delete en un rg
   * Vamos a tratar de borrar ese rg
  
  <img width="227" height="105" alt="image" src="https://github.com/user-attachments/assets/52dba8a0-711e-4558-9559-bde3089d19db" />

* Si lo quiero hacer desde el CLI

```
New-AzResourceLock -LockName "PreventDeleteLock" -LockLevel CanNotDelete -ResourceGroupName "rg-az104-clase-04"
```

 # IAC (Infraestructura como codigo)

 * Primero creamos el grupo de de recurso

<img width="629" height="241" alt="image" src="https://github.com/user-attachments/assets/eacac41b-2907-464f-a980-fc38db341d68" />

* Vamos a hacer como que creamos un recurso secillo, en este caso un disk
  * Lleno los datos del disco, no hace falta elegir nada en particular
  * Ir a review and create, pero no darle create aun ir donde dice
      * Download a template for automation (Abajo a la derecha)

## ARM Template

* Me baja este json

```
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "diskName": {
            "type": "string"
        },
        "location": {
            "type": "string"
        },
        "sku": {
            "type": "string"
        },
        "diskSizeGb": {
            "type": "int"
        },
        "sourceResourceId": {
            "type": "string"
        },
        "createOption": {
            "type": "string"
        },
        "hyperVGeneration": {
            "type": "string",
            "defaultValue": "V1"
        },
        "diskEncryptionSetType": {
            "type": "string"
        },
        "dataAccessAuthMode": {
            "type": "string"
        },
        "networkAccessPolicy": {
            "type": "string"
        },
        "publicNetworkAccess": {
            "type": "string"
        }
    },
    "resources": [
        {
            "apiVersion": "2025-01-02",
            "type": "Microsoft.Compute/disks",
            "name": "[parameters('diskName')]",
            "location": "[parameters('location')]",
            "properties": {
                "creationData": {
                    "createOption": "[parameters('createOption')]"
                },
                "diskSizeGB": "[parameters('diskSizeGb')]",
                "encryption": {
                    "type": "[parameters('diskEncryptionSetType')]"
                },
                "dataAccessAuthMode": "[parameters('dataAccessAuthMode')]",
                "networkAccessPolicy": "[parameters('networkAccessPolicy')]",
                "publicNetworkAccess": "[parameters('publicNetworkAccess')]"
            },
            "sku": {
                "name": "[parameters('sku')]"
            },
            "tags": {}
        }
    ]
}
```

* Opcionalmente tambien baja los parametros

```
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "diskName": {
            "value": "az105-clase-03-disk-1"
        },
        "location": {
            "value": "westus"
        },
        "sku": {
            "value": "Premium_LRS"
        },
        "diskSizeGb": {
            "value": 1024
        },
        "sourceResourceId": {
            "value": ""
        },
        "hyperVGeneration": {
            "value": ""
        },
        "diskEncryptionSetType": {
            "value": "EncryptionAtRestWithPlatformKey"
        },
        "createOption": {
            "value": "empty"
        },
        "dataAccessAuthMode": {
            "value": "None"
        },
        "networkAccessPolicy": {
            "value": "AllowAll"
        },
        "publicNetworkAccess": {
            "value": "Enabled"
        }
    }
}
```
 

 # Virtual Networks
