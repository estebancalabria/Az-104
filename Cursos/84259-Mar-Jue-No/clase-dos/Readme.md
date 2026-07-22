# Clase Dos - 21 de Julio del 2026

# Repaso

* Microsoft Entra
  * Tennant / Inquilino
    * Dominio por defecto
    * Crear dominios o alias adicionales
  * Indentities
    * Usuarios
    * Service Principal
       * Aplicaciones propias (App Registrations)
       * Aplicaciones Conocidas (Enterprise Applications)
    * Managed Identity
      * System Assigned
      * User Assigned
* Seguridad
  * MFA 

---
# Consideraciones

* Vamos a aprednder a usar el CLI

<img width="468" height="277" alt="image" src="https://github.com/user-attachments/assets/7ab141f8-27cc-47b2-a1c8-be73e0dbcf73" />

---

# Miscelanias

* Tour por los datacenter de Azure
  * https://www.youtube.com/watch?v=80aK2_iwMOs&t=20s

---

# RBAC (Permisos)

* Crear un Resource Group
  * Vamos a crearlo utilizando el CLI de azure
    * 2 Sabores
      * Comando az
      * Comandos de Powershell

* Abrir un CLI en una segunda solapa

* Primero vamos a ver que resource group     
```
az group list  
```

* Crear un resource group

```
az group create --name rg-az104-clase-02 --location westus
```

* Ver los management groups
 * Son Contenedor logicos para administrar subscripciones, recursos, politicas y permisos
 * El Cloud Addoption Framework (CAF) es una guia de Microsoft que te dice como crear tus recursos y su management groups
   * https://azure.microsoft.com/es-es/solutions/azure-essentials/cloud-adoption-framework

* Ejemplo de organizacion en Management Groups segun el CAF

```
Tenant Root Group
│
├── Platform
│   ├── Identity
│   ├── Connectivity
│   └── Management
│
├── Landing Zones
│   ├── Corp
│   │   ├── Producción
│   │   ├── Desarrollo
│   │   └── Testing
│   │
│   └── Online
│       ├── Producción
│       ├── Desarrollo
│       └── Testing
│
├── Sandbox
│
└── Decommissioned
```

* Hay un icono "Acces Control (IAM) donde se

<img width="163" height="25" alt="image" src="https://github.com/user-attachments/assets/ce0cc9eb-6cd6-49f3-9793-76c0abd92eaa" />

* Vamos a la parte de subscripcion donde tambien observamos que el mismo boton
  * Observamos en la parte de subscripcion todo el tema de manejo de costos
  * Es la unidad de facturacion

* Vamos al resource group que creamos donde tambien observamos que el mismo boton

* En este caso vamos a darle permis a un usuario a nivel subscripcion

> [!NOTE]
> En azure siempre hay que considera el "The Principle of Least Privilege (PoLP) is a cybersecurity concept where users, systems, and applications are granted only the minimum level of access or permissions necessary to perform their assigned tasks." y darle al usuario solamente los permisos necesiarios y minimos para lo que tiene que hacer. No hay que dar permisos de mas por las dudas

* Tipps de Roles
  * Built-IN
    * Privilegiados
      * Owner
        * Solo dos personas deberian tener rol de owner. El principal y el backup por si el principal se muere
        * Puede asignar roles RBAC a otros usuarios
      * Contributor
       * Puede acceder a los recursos libremente (crear, borrar, etc) pero no puede asignar otros permisos
      * Reader
    * Roles por Funcion
      * Virtual Machine Contributor
        * Puede hacer lo que quiera pero solo con maquinas virtuales
      * ....
  * Custom
 
* Crear una asignacion de roles RBAC
  * Voy al Scope (subscripcion)
  * Elijo el boton "IAM"
  * Creo un "Role Assignment"
  * Elijo el tipo de Rol (Ej contributor)
  * Elijo la identity (el usuairo, grupo de usuario, recurso de azure, applicacion, grupos de usuarios)
  * Creo la asignacion de roles

* Tambien lo puedo hacer por el CLI

```
az role assignment create --assignee <ID_USUARIO> --role "Contributor" --scope "/subscriptions/<ID_SUBSCRIPCION>"
```

* Chequear en la solapa "Role Assignments" que este la asignacion de rol que acaban de crear

## Creacion Roles Custom

* Mediante un archivo json se pueden definir roles especificos con la maxima granuralidad
* Seria recomendable verificar primero si alguno de los roles "build-in" ya cumple lo que se necesita antes de crear uno nuevo

* Primero vamos a ver el json de algunos de los roles ya definidos
* Vamos a la solapa Role y buscamos alguno por ejemplo "Virtual Machine..."
  * Luego darle a View
  * En la solapa "Actions" se ve las acciones que este rol permite (agrupadas por tipo)
 
* Vamos a crear nuestro propio rol
  * Add... Custom Role
    
<img width="214" height="81" alt="image" src="https://github.com/user-attachments/assets/9553d754-8001-4705-aead-11bcaad43087" />

* Vamos a armar un rol que solo se pueda conectar a las VM con ayuda de la IA

```
{
  "properties": {
    "roleName": "Usuario Maquinas Virtuales",
    "description": "Permite ver las máquinas virtuales, consultar su información y conectarse mediante RDP.",
    "assignableScopes": [
      "/subscriptions/91dc3067-fd7a-4ed3-95eb-8c938f69cbfe"
    ],
    "permissions": [
      {
        "actions": [
          "Microsoft.Compute/virtualMachines/read",
          "Microsoft.Compute/virtualMachines/instanceView/read",
          "Microsoft.Compute/virtualMachines/extensions/read",
          "Microsoft.Network/networkInterfaces/read",
          "Microsoft.Network/publicIPAddresses/read",
          "Microsoft.Network/networkSecurityGroups/read",
          "Microsoft.Network/virtualNetworks/read",
          "Microsoft.Resources/subscriptions/resourceGroups/read",
          "Microsoft.Resources/subscriptions/resources/read",
          "Microsoft.Compute/locations/*/read",
          "Microsoft.Compute/virtualMachines/login/action"
        ],
        "notActions": [],
        "dataActions": [],
        "notDataActions": []
      }
    ]
  }
}
```

* Si queres ver la lista de operaciones en el CLI

```
az provider operation list
```

---
# PAUSA 10 minutos hasta las 9
# Luego vamos a reiniciar el laboratorio
---


# Algunos recursos pocos conocidos de Azure...

* Resource Graph Explorer
* Resource Explorer
* Resource Visualizer

---

# Permisos de Microsoft Entra

* Son distintos a los Permisos RBAC
* Los permisos del Entra son para manera identities
* Se ven en el Entra... Roles and administration
* Para verlo debes tener la licencia del usuario del Microft Entra tiene que ser P2
* Si le asigno el rol de "User Admisitrator" a un usuario, este va a poder crear usuarios en el Entra

* A igual que los roles RBAC tenemos
  * Roles Buil-in
    * User Administrator
    * Global Administator
   
* Ir a un usuario X
  * Ver los roles de Microsoft Entra asignados
 

## Licencias

* Microsoft Entra tiene dos licencias
  * P1
  * P2
* Se pagan por usuario
* Cada licencia te permite acceder a mas funcionalidades dentro del Entra
* Si elijo un usuario cualquiera puedo ver que licencias tiene asignadas y cambiarle
  * Ahora la asignacion de licencias se maneja en https://admin.microsoft.com/
 
---

# Gobernaza  Microsoft Entra (Proxima Clase)

* Se explora en produndidad en el Az-500, Sc-900, Sc-100
* Contenpla casos de aceso mas avanzados y ShadowIT  
