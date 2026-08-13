# Clase Ocho - 13 de Agosto del 2026

# Repaso

* Storage Accounts
  * Sub-Servicios:
    * Containers
    * FileS hares
      * Disco compartido SMB para VMs
      * Pasar archivos de una maquina a la otra
      * Se monta con una script de powershell
    * Tables
    * Queues
  * Seguridad
    * Acceso
      * Publico / Anonimo
          * No se recomienda
      * Privado
          * SAS (Shared Access Signature)
            * Un link que se genera a partir de las Keys del Storage
          * Firewall
            * En Security + Networking -> Neworking
      * Adicionamente se puede configurar acceso por usuario del Entra
          * Se ve mas en el Az-500
    * Redundancia
      * GRS -> Hace una copia a la Region emprentada
      * LRZ -> Hace una copia en otro rack de en el mismo data center
    * Borrado Accidental
      * Soft Delete
  * Administracion y Versionado
    * Chage Feed (Control de cambios y versionados)
    * Snapshots (Instantaneas)
  * Costos
    * Access Tiers
      * Hot, Cool, Cold, Archive

# Setup

* Crear el RG

```
 New-AzResourceGroup -Name rg-az104-clase-ocho -Location westus
```

# Storage

* Crear un Storage Account
  * Dejar las opciones por default

## Firewall del Storage Account
 
* En Security + Networking -> Neworking
  * Configurar el firewal del Storage Account
    * Poner "Enabled From Selected Networks"
      * En IPv4 Addresses
        * Poner +Agregar tu Ip

* Habilitar el acceso anonimo al SA
  * Settings -> Configuration
    * Allow Blob anonymous access : Enabled

* Creamos un container 
  * Subir un archivo publico al SA

> [!NOTE]
> Desde mi pc deberia dejar verlo porque lo habilite en el firewall. Desde la comput de un alumno deberia mostrarse

<img width="1672" height="102" alt="image" src="https://github.com/user-attachments/assets/11648ef6-f915-4f4e-bc65-24f523ebd8ec" />

## Cambio de Acces Tier (costos)

* Elegir el blob
  * "Chage Access Tier"
 
<img width="593" height="437" alt="image" src="https://github.com/user-attachments/assets/1db59ebf-1bb8-40ef-827b-2db6d204913c" />

## Chage Feed y Snapshots


* Habilitar el versionado en el Storage Account
  * Data Protection
    * Enable versioning for blobs : Enabled
    * Enable blob change feed : Enabled

> [!NOTE]
> Oservar la creacion de la carpeta $blobchangefeed

* Subir un archivo txt
  * Creo un archivo llamado versionado.txt
  * Su contenido es "Version 1"

* Edito el archivo desde el portal
  * Doble click en el blob
  * Es lo mismo que editarlo afuera y volverlo a subir
  * Lo cambio y le pongo "Version 2"

* Puedo tambien hacer un snapshot (instantanea)
  * En los ... a la derecha del blob pongo "Create Smapshot"
  * Verifico la version guardad como instantanea en la parte de snapshots

---

# Trafico de Redes

