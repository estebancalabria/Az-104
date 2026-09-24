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

# ARM Templates / Bicep Templates

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

# Redes
