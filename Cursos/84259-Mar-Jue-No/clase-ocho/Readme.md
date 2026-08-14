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

# Setup (Para toda la clase)

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
BREAK
Matar el XTREMELabs y volverlo acrear
Nos vemos en 15!
---

# Trafico de Redes

## Setup de la primera VM

* Crear una VM
  * Asi como viene, que cree la VNet tambien
  * Nombre : vm-spider-man

* Conectarse al VM por RDP
  * Abrir Powershell en el RDP de la VM en modo administrador
  * Instalar IIS

```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
```

* Una vez instalado si accedo a veo el portal del IIS :

```
http://<IP-VM>/
```

* En la VM modificar el archivo C:\inetpub\wwwroot\iistart.html

```
Soy Spider-Man
```

* Verifico que se muestra eso desde mi pc en el navegador

* Habilitar el puerto 80 y 443 en el NSG

<img width="1516" height="448" alt="image" src="https://github.com/user-attachments/assets/b1d4136b-6a1b-48c3-bbfc-9a0bba5fc489" />

## Setup de la segunda VM

* Crear siguiendo los mismos pasos exactos otra VM
 * Name : vm-iron-man
 * Se puede habilitar directamente el http y https en la creacion
 * Ponerla en la misma vnet y subnet que la otra vm anterior << IMPORTANTE

* Tambien
 * Conectamos con RDP
 * Instalamos el IIS
 * Modificamos el archivo Iistart
    * Debe decir "Soy Iron Man"
 * Chequeamos el acceoso desde el navegador

## Load Balancer

* Crear un balanceador de carga delante de las VM
  * Name : lb-az104
  * SKU : Standard
  * Type : Public
  * Tier : Regional
    
* Fronted-Configuration
  * Crear IP Nueva pip-lb-az104

<img width="771" height="539" alt="image" src="https://github.com/user-attachments/assets/82cd7c7a-91a2-4141-9eaa-baf1199cdc51" />

* Backend Pool
 * Crear backend Pool
 * Asociarlo con la vnet de las VM
 * Agregarle las dos VM

* Review And Create

* Revisar el recurso

* Settings -> Load Balancing Rules
 * Crear regla "+Add"
   * Elegir el FrontedIP
   * Elebir el Backend Pool
   * Va del puerto 80 al puerto 80
   * Le creamos un heath probe para que chequee que las maquinas esten vivas

   <img width="959" height="686" alt="image" src="https://github.com/user-attachments/assets/7dc055d1-ec84-42ba-a555-dd0067fe2de3" />

* Acceder a la ip del load balancer

* Primero va a decir "Soy Iron Man" pero si le doy f5 como un condenado va a cambiar a "Soy Spider-MAn"

> [!NOTE]
> Una vez que tengo configurado el load balancer, no es necesesario tener habilitados los puertos 80 y 443 del nsg, los pue doar de baja para que no se tenga acceso a las vm desde internet
