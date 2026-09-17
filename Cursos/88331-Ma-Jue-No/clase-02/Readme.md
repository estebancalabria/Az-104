# Clase Dos - 17 de Septiemrbe del 2026

# Repaso

* Interfaz de Azure
* Microsoft Entra
  * Permisos del Entra
  * RBAC
* Virtual Networks
* Storage
* Compute
  * AppService
  * Container
    * Container Instance
    * Container Apps
    * Kubernetes
  * VM
* Backup
* Monitoreo
* Defende
* 
# Hoy Vamos a ver

* Usuarios
* Permisos RBAC
* ...tal vez algo de policies
* Creacion de VMs

# Microsoft Entra

* Grupos
* Identidades (Identity)
  * Usuarios
     * Usuarios de nuestro tennant
     * Usuarios Invitados
  * Service Principals (no humanos)
     * App Registrations
        * Aca registro las aplicaciones que se programan en mi organizacion y quiero que autentiquen con los usuarios de mi tennant
        * OAuth / SSO
  
  <img width="209" height="220" alt="image" src="https://github.com/user-attachments/assets/513e10c4-b662-4a06-b8f9-b9b9f11a5e32" />

     * Enterpise Application
        * Aplicaciones conocidas de terceros que puedo instalar en mi organizacion y quiero que autentiquen con los usuarios de mi tennant
  * Managed Identities
      * Recusos de Azure que necesitan tener una identity en el entra porque necesitan autenticarse sobre otros recursos de Azure

# Asignacion de roles RBAC

## Asignacion de roles Built-in

* Hoy vamos a utilizar el CLI

<img width="290" height="203" alt="image" src="https://github.com/user-attachments/assets/b1423732-6bfe-4bed-abc7-dfeaf0522a29" />

* Para interactuar con Azure desde el cli tenemos:
  * Comandos de Powershell
  * Comando de Bash
      * az

```powershell
az group create --name rg-az104-clase-02 --location westus
```

* A Un alumno le paso esto
<img width="1913" height="250" alt="image" src="https://github.com/user-attachments/assets/dd208350-21b3-4f18-8000-72fcf3f173ee" />

> [!NOTE]
> En este caso en azure tiene definida una Policy que determina en que regiones se pueden crear grupos de recurso

* Vamos a buscar a nuestros colegas en el tennant

* XLab-jQx-264@xtremelabs.us
* XLab-lWs-303@xtremelabs.us
* XLab-D0w-305@xtremelabs.us
* XLab-08f-306@xtremelabs.us
* Xab-krU-319@xtremelabs.us
* XLab-Sjq-320@xtremelabs.us
* Xab-8jZ-321@xtremelabs.us


* Vamos a los Resource Groups
  * Observamos que podemos ver el REsource Group que cree pero no puedo ver el que creo mi compa a pesar de que estamos en el mismo tennar
 
* Vamos a darle permiso a otro usuario del tennant para que pueda interacturar con mi Resource Group
  * Voy al RG que cree
  * Voy a la parte de Access Control (IAM) para darle permiso a otro usuario para trabajar con mi RF
 
* Ahora en la parte de la parte de resoruce Groups hay dos, el que cree y el que hizo mi companiero

<img width="1536" height="422" alt="image" src="https://github.com/user-attachments/assets/d6265185-8878-4630-baf9-6aec007391f0" />

* En el activity log tiene que aparecer una entrada "Create rol Assignent"

<img width="384" height="163" alt="image" src="https://github.com/user-attachments/assets/b3495dce-8bc3-4bca-91b1-f64c248815c6" />

* Este rol que acabamos que acabamos de asignar a un companiero es un rol RBAC
* El rol de Contributor sobre el RG le permite al otro usuario hacer lo que quiera sobre ese RG

* Existen roles BuiltIN
  * Owner
  * Contributor
  * Reader
  * Virtual Machine Contributor
* Existen los roles cutom (creados por el administador)

## Asignaciones de Roles Custom
 
* Veamos por ejemplo uno como Virtual Machine Contributor (lo mejor es ver el json)

```
{
    "id": "/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c",
    "properties": {
        "roleName": "Virtual Machine Contributor",
        "description": "Lets you manage virtual machines, but not access to them, and not the virtual network or storage account they're connected to.",
        "assignableScopes": [
            "/"
        ],
        "permissions": [
            {
                "actions": [
                    "Microsoft.Authorization/*/read",
                    "Microsoft.Compute/availabilitySets/*",
                    "Microsoft.Compute/locations/*",
                    "Microsoft.Compute/virtualMachines/*",
                    "Microsoft.Compute/virtualMachineScaleSets/*",
                    "Microsoft.Compute/cloudServices/*",
                    "Microsoft.Compute/disks/write",
                    "Microsoft.Compute/disks/read",
                    "Microsoft.Compute/disks/delete",
                    "Microsoft.Compute/hostgroups/write",
                    "Microsoft.Compute/hostgroups/hosts/write",
                    "Microsoft.DevTestLab/schedules/*",
                    "Microsoft.Insights/alertRules/*",
                    "Microsoft.Network/applicationGateways/backendAddressPools/join/action",
                    "Microsoft.Network/loadBalancers/backendAddressPools/join/action",
                    "Microsoft.Network/loadBalancers/inboundNatPools/join/action",
                    "Microsoft.Network/loadBalancers/inboundNatRules/join/action",
                    "Microsoft.Network/loadBalancers/probes/join/action",
                    "Microsoft.Network/loadBalancers/read",
                    "Microsoft.Network/locations/*",
                    "Microsoft.Network/networkInterfaces/*",
                    "Microsoft.Network/networkSecurityGroups/join/action",
                    "Microsoft.Network/networkSecurityGroups/read",
                    "Microsoft.Network/publicIPAddresses/join/action",
                    "Microsoft.Network/publicIPAddresses/read",
                    "Microsoft.Network/virtualNetworks/read",
                    "Microsoft.Network/virtualNetworks/subnets/join/action",
                    "Microsoft.RecoveryServices/locations/*",
                    "Microsoft.RecoveryServices/Vaults/backupFabrics/backupProtectionIntent/write",
                    "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/*/read",
                    "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/read",
                    "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/write",
                    "Microsoft.RecoveryServices/Vaults/backupPolicies/read",
                    "Microsoft.RecoveryServices/Vaults/backupPolicies/write",
                    "Microsoft.RecoveryServices/Vaults/read",
                    "Microsoft.RecoveryServices/Vaults/usages/read",
                    "Microsoft.RecoveryServices/Vaults/write",
                    "Microsoft.ResourceHealth/availabilityStatuses/read",
                    "Microsoft.Resources/deployments/*",
                    "Microsoft.Resources/subscriptions/resourceGroups/read",
                    "Microsoft.SerialConsole/serialPorts/connect/action",
                    "Microsoft.SqlVirtualMachine/*",
                    "Microsoft.Storage/storageAccounts/listKeys/action",
                    "Microsoft.Storage/storageAccounts/read",
                    "Microsoft.Support/*"
                ],
                "notActions": [],
                "dataActions": [],
                "notDataActions": []
            }
        ]
    }
}
```

* Si quiero armar un rol personalizado que no esta contemplado entre los que ya vienen armado voy a armar un json

* Ejemplo

```
Quiero armar un rol RBAC de Azure que solamente permtia crear storage accounts en un resource group y no pueda hacer anda mas. Armame el JSON
```

> [!NOTE]
> Antes de hacer esto en la practica siempre me tengo que fijar si no existe ya un rol que lo haga

* LA IA me devuelve

```
{
  "Name": "Storage Account Creator",
  "IsCustom": true,
  "Description": "Permite crear Storage Accounts en un Resource Group, sin permisos adicionales.",
  "Actions": [
    "Microsoft.Storage/storageAccounts/read",
    "Microsoft.Storage/storageAccounts/write"
  ],
  "NotActions": [],
  "DataActions": [],
  "NotDataActions": [],
  "AssignableScopes": [
    "/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP_NAME>"
  ]
}

```

* Podemos crear este rol en Add Custom Role con el json

<img width="347" height="127" alt="image" src="https://github.com/user-attachments/assets/de668146-a7a5-4370-996e-7125917451a5" />

* En algunos entornos se ve que ya hay algunos custom roles ya creados

<img width="2027" height="81" alt="image" src="https://github.com/user-attachments/assets/cc37ed75-313a-44a3-a411-0c9aa7b7c16f" />
