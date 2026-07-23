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

# Gobernanzada en Entra

# Deployment con ARM Template

---
