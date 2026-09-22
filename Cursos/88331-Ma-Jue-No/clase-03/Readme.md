# Clase Tres - 22 de Septiembre del 2026

# Repaso

* Uso de Azure
  * Padawan
      * Usa el portal
  * Jedi
      * CLI
          * Comando Az
          * Comandos de Powershell
      * ArmTemplates / Bicep Templates
* Microsoft Entra
  * Indentities
      * Usuarios / Grupos
      * Service Principal
          * App Registrations
          * Enterprise Applications
      * Manages Identities
  * Permisos
      * RBAC
          * Sobre recursos de Azure
          * Roles
            * Roles Built-In
              * Owner
              * Contributor
            * Roles Custom
              * Definir mediante un json
          * Asignados Mediante "Access Controll IAM"
      * Roles del Entra
    * ID Governance
        * Requerimiento licencia P2
        * PIM
        * Conditional Access

---

# Uso del CLI

* Existen los comandos de powershell  los comandos az
* Los dos pueden hacer lo mismo
* Los dos se pueden usar o desde el cli dentro del portal de azure o el CLI de mi maquina
* Para usar el comando az desde mi casa lo tengo que instalar
    * https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&pivots=msi
* Una vez que lo descargue desde la linea de comando me logue usando

```
az login
```

# Policies

* Siempre lo primero que hacemos en la clase es crear un RG, hoy toca con powershell
```
New-AzResourceGroup -Name rg-az104-clase-03 -Location westus
```
* Ir a la Opcion de Policies
  * Ver la opcion de Definitions
    * Un monton de politicas que estan disponibles out of the vox para implementar
    * Hay dos tipos de Definicion de Policy
      * Policy
      * Initiative (conjuto de policies)

* Actividad
  * Buscar la Inicitativa "ISO/IEC 27001 2022" y ver todas las policies que incluye
    * Si yo quisiera auditar mi empresa con esta norma deberia tomar esta policy y aplicarla
    * Elegir una policy cualquiera dentro de la incitiva como "Azure subscriptions should have a log profile for Activity Log"

* Observammos que la definicion de la policy es un JSON que tiene una estructura IF <TAL COSA> then Audit/Deny

```
{
  "properties": {
    "displayName": "Azure subscriptions should have a log profile for Activity Log",
    "policyType": "BuiltIn",
    "mode": "All",
    "description": "This policy ensures if a log profile is enabled for exporting activity logs. It audits if there is no log profile created to export the logs either to a storage account or to an event hub.",
    "metadata": {
      "version": "1.0.0",
      "category": "Monitoring"
    },
    "version": "1.0.0",
    "parameters": {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "AuditIfNotExists",
          "Disabled"
        ],
        "defaultValue": "AuditIfNotExists"
      }
    },
    "policyRule": {
      "if": {
        "field": "type",
        "equals": "Microsoft.Resources/subscriptions"
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.Insights/logProfiles",
          "existenceCondition": {
            "field": "Microsoft.Insights/logProfiles/categories",
            "exists": "true"
          }
        }
      }
    }
  },
  "id": "/providers/Microsoft.Authorization/policyDefinitions/7796937f-307b-4598-941c-67d3a05ebfe7/versions/1.0.0",
  "type": "Microsoft.Authorization/policyDefinitions/versions",
  "name": "1.0.0"
}
```

* Vamos a ver la parte de Assigments Ir a assigments
  * El assigment hace que se tome una definicion de policy/iniciativa y efectivamente se aplique en mi tennant
  * Asignar una policy no es algo inmediato, tarda entre 5 - 20 minutos

* Elegir una Asignacion que sea de tipo initiative y de ahi puedo ver que iniciativa se esta aplicando

* Demo. Yo tengo una policy asignada que tiene esta parte

```
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Resources/subscriptions/resourceGroups"
          },
          {
            "field": "location",
            "equals": "eastus"
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
```

* Voy a tratar de crear un RG en eastus

<img width="454" height="176" alt="image" src="https://github.com/user-attachments/assets/72e52234-c38a-4985-8de4-ce4055431d2f" />

* Podemos generar una definicion de policy con Copilot

```
Creame una policy de Azure que no pemita crear resource groups salvo que comienzen con el prefijo rg-
```

* Me crea

```json
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
    }
  }
```

* Con este JSON voy a crear una definicion de Policy
* Una vez creada voy a el boton Assing Policy para implementarla en mi subscripcion

<img width="209" height="74" alt="image" src="https://github.com/user-attachments/assets/5a04f047-093e-42d5-91d4-cdf595d2ad0b" />

---

# Entender un poco mas a Azure
