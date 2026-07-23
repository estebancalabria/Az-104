# Clase Tres - 23 de Julio del 2026

# Repaso

* Mencionar video de tour a Azure Data Center
    * https://www.youtube.com/watch?v=80aK2_iwMOs&t=20s
* Jerarquia Recurso Azure
  * Tennant / Inquilino
    * Management Group (CAF : Cloud Addoption Framework recomienda como organizarlos)
      * Subscripcion
        * Resource Group
          * Recurso
* Entra ID
  * Creacion de Usuarios
  * Licencias del Entra (P1 y P2)
  * Permisos
    * RBAC (Role Based Access Control)
      * Se asignaban en la opcion IAM
      * Roles
        * Built-in
          * Privilegiados
            * Contributor
            * Owner
            * Reader
          * Virtual Machine Contributor
        * Custom
          * Los defino con un json
    * Microsoft Entra
* Uso del CLI
  * Comandos AZ
    * Vimos como crear un Grupo de Recursos
  * Comandos de Powershell
* Costos
  * Como entrar a la facturacion
* Conceptos fundamentales
  * Least Priviledge access (Darle al usuario solo los permisos minimos para hacer lo que necesita)

---

# Uso del CLI

## Powershell

* Abrir dos solapas
  
* En una solapa abro el cli en Powershell

```
New-AzResourceGroup -name rg-az104-clase-03 -Location westus 
```

## Az

* Para usar el comando az dede mi casa tengo que instalar
  * Windows
      * https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&pivots=msi
  * Linux
      * https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt
  
* Y luego tengo que ejecutar el comando

```
az login
```
* Abre una ventana del navegador, me logueo y queda asociado el comando a mi cuenta

---

# Azure Policy

* Esto pasa si queremos ejecutae una accion que una policy previene (deny)

* Una policy es una regla if then [Deny/Audit]

```
New-AzResourceGroup -name rg-az104-clase-03 -Location westus
New-AzResourceGroup: Resource 'rg-az104-clase-03' was disallowed by policy. Policy identifiers: '[{"policyAssignment":{"name":"RestrictLocations","id":"/subscriptions/0c4d7cc4-d64d-46eb-b8ad-59b8a35abc09/providers/Microsoft.Authorization/policyAssignments/33fec66f08575a4ebe8f553a"},"policyDefinition":{"name":"myAllowedLocations","id":"/subscriptions/0c4d7cc4-d64d-46eb-b8ad-59b8a35abc09/providers/Microsoft.Authorization/policyDefinitions/33747ffa109958548ca1e8e4","version":"1.0.0"}}]'.
StatusCode: 403
ReasonPhrase: Forbidden
OperationID : 0476077c-080a-4efd-8fda-41db655dcef0
```

* Tipos de Policy
   * Deny
   * Audit

* Inciativa
   * Conjunto de Policy
   * Azure trae un moonton de iniciativas y de policies built-in

> [!NOTA]
> Cuando asignamos una policy puede tardar 20 minutos en hacer efecto

## Asignacion de policy

### Asignacion de policy exitente

* Seria agarrar una policy y hacer que se cumpla en mi empresa

* Ir Policy
   * Ir A Assigments
      * Elegir el resource group como el scope
      * Elegir la policy "Allowed Locations"


<img width="539" height="254" alt="image" src="https://github.com/user-attachments/assets/b2c4717d-bbc7-4e1f-9f0a-e7861c948d89" />

      * En la parte de parameters (Segunda solapa) elegir CentralUS
      * En la solapa de "Non-Compliance Messages" ponemos "Solo se pueden crear recursos en CentralUS"

* Me da ese mensaje

<img width="229" height="68" alt="image" src="https://github.com/user-attachments/assets/855c6cdd-9531-4775-8817-434f493cc6bc" />

> [NOTE!]
> Le cambie el nombre de la asignacion de "Allowed Location" a "Allowed locations solo en CentralUS para rg rg-az104-clase-03" para que sea mas facil de entender

* Si busco la definion de la policy "Allowed Location" me da este json

```json
{
  "properties": {
    "displayName": "Allowed locations",
    "policyType": "BuiltIn",
    "mode": "Indexed",
    "description": "This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region.",
    "metadata": {
      "version": "1.1.0",
      "category": "General"
    },
    "version": "1.1.0",
    "parameters": {
      "listOfAllowedLocations": {
        "type": "Array",
        "metadata": {
          "description": "The list of locations that can be specified when deploying resources.",
          "strongType": "location",
          "displayName": "Allowed locations"
        }
      },
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "Audit",
          "Deny",
          "Disabled"
        ],
        "defaultValue": "Deny"
      }
    },
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "location",
            "notIn": "[parameters('listOfAllowedLocations')]"
          },
          {
            "field": "location",
            "notEquals": "global"
          },
          {
            "field": "type",
            "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
    }
  },
  "id": "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c/versions/1.1.0",
  "type": "Microsoft.Authorization/policyDefinitions/versions",
  "name": "1.1.0"
}
```

* Despues de esperar 15 minutos si quiero crear un recurso que no cumpla la policy no me deja

<img width="528" height="272" alt="image" src="https://github.com/user-attachments/assets/1392a04e-f519-4f1f-ac7f-6791d14596fe" />


## Creacion de Policy nueva

* Voy a Policy
   * Definition
      * + Policy Defitiion

* Name : ResourceGroup starts with rg-

* Para sacar el json use ChatGPT y le dije esto
```
Completame este json "{
  "mode": "All",
  "policyRule": {
    "if": {
      "not": {
        "field": "location",
        "in": "[parameters('allowedLocations')]"
      }
    },
    "then": {
      "effect": "audit"
    }
  },
  "parameters": {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
}" quiero que mis resource groups todos comiencen con el prefijo "rg-"
```

* ChatGPT me genero este json que voy a usar para crear la definion de la policy

```
{
  "mode": "All",
  "policyRule": {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          "not": {
            "field": "name",
            "like": "rg-*"
          }
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  },
  "parameters": {}
}
```

---
# Gobernanzada en Entra

# Deployment con ARM Template

---
