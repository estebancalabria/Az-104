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

 # Requisito

 * Instalar el VSCode el que no lo tiene
   * https://code.visualstudio.com/

 # Administracion de Azure

 * Los locks sobre grupos de recursos son una forma sencilla de evitar que otra persona nos borre un rg por accidente
   * Vamos a crear un lock de delete en un rg
   * Vamos a tratar de borrar ese rg
  
  <img width="227" height="105" alt="image" src="https://github.com/user-attachments/assets/52dba8a0-711e-4558-9559-bde3089d19db" />

* Si lo quiero hacer desde el CLI

```
New-AzResourceLock -LockName "PreventDeleteLock" -LockLevel CanNotDelete -ResourceGroupName "rg-az104-clase-04"
```

* Sacar el resource group lock

 # IAC (Infraestructura como codigo)

 * Primero creamos el grupo de de recurso

<img width="629" height="241" alt="image" src="https://github.com/user-attachments/assets/eacac41b-2907-464f-a980-fc38db341d68" />

* Vamos a hacer como que creamos un recurso secillo, en este caso un disk
  * Lleno los datos del disco, no hace falta elegir nada en particular
  * Ir a review and create, pero no darle create aun ir donde dice
      * Download a template for automation (Abajo a la derecha)

## ARM Template

* Caracteristica
 * Los arm templats son idempotentes : significa que si hay una infraestructura a medio crear, el template va a tratar de completarla 

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

* Para desplegarlo buscar en el buscador de recursos "Deploy custom Template"

<img width="289" height="115" alt="image" src="https://github.com/user-attachments/assets/783d4476-ff72-4fdd-96ed-4e1e62cd6a48" />

* Elegir el boton "Build your own template in the editor"

* Darle Save

* Todo lo que son Parameters lo tendria que completar

* Uff... que embole completar todos los parmetros.. mejor vamos a hacer algo... le pido a la IA

```
Tengo este template.json y parameters.json <Adjuntar archivos) No quiero que me pregunte ningun parametro, que esten fijos en el template y que ademas me cree 5 discos que se llamen az102-clase-03-disk-<Numero> donde numero va variando entre 1 y 5. Devolverme el json nuevo sin acotar nada mas
```

* Nuevo template

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "variables": {
    "location": "westus",
    "sku": "Premium_LRS",
    "diskSizeGb": 1024,
    "diskEncryptionSetType": "EncryptionAtRestWithPlatformKey",
    "createOption": "Empty",
    "dataAccessAuthMode": "None",
    "networkAccessPolicy": "AllowAll",
    "publicNetworkAccess": "Enabled"
  },
  "resources": [
    {
      "copy": {
        "name": "diskCopy",
        "count": 5
      },
      "type": "Microsoft.Compute/disks",
      "apiVersion": "2025-01-02",
      "name": "[format('az102-clase-03-disk-{0}', add(copyIndex(), 1))]",
      "location": "[variables('location')]",
      "sku": {
        "name": "[variables('sku')]"
      },
      "properties": {
        "creationData": {
          "createOption": "[variables('createOption')]"
        },
        "diskSizeGB": "[variables('diskSizeGb')]",
        "encryption": {
          "type": "[variables('diskEncryptionSetType')]"
        },
        "dataAccessAuthMode": "[variables('dataAccessAuthMode')]",
        "networkAccessPolicy": "[variables('networkAccessPolicy')]",
        "publicNetworkAccess": "[variables('publicNetworkAccess')]"
      },
      "tags": {}
    }
  ]
}
```

> [!NOTE]
> Observar que ahora no hay parameters (que se los pregunta al usuario) son todos "variables"

* Creamos un archivo template.json con nuestra nueva version
 * Podemos pisar el anterior

* Al hacer deploy de este nuevo template ya no me pregunta todos los parametros

* Ahora tengo de una 5 discos creados

### Idempotencia y deployment por Consola

* Borrar 2 de los 5 discos, el 2 y el 4

* Podemos borrarlo por el cli
```
az disk delete -g rg-az104-clase-04 -n az102-clase-03-disk-4 --yes    
```

* Subo el template.json al cli

<img width="198" height="107" alt="image" src="https://github.com/user-attachments/assets/168caa20-3ef5-492c-b1b5-ac104a27cd0a" />


* Ahora a ChatGPT

```
como hago deploy de un json sin parametros con el comando az en el rg rg-az104-clase-04 en westus. Devolveme el parametro sin acotar nada mas
```

* Me tira ( y lo tiro en el cli)

```
az deployment group create --resource-group rg-az104-clase-04 --template-file template.json
```

> [!NOTE]
> Veo que creo los discos que faltaban pero los que ya estaban los dejo como estaba. Esto es la IDEMPOTENCIA

---

 # Virtual Networks
