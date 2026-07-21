# Clase Dos - 21 de Julio del 2026

# Repaso

* Microsoft Entra
  * Tennant / Inquilino
    * Dominio por defecto
    * Crear dominios o alias adicionales
  * Indentities
    * Usuarios
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

