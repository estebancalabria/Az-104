# Clase Siete - 11 de Agosto del 2026

# Repaso

* Networking
  * Creamos dos VNET
    * VNet Peering (conectar dos VNET_
    * Cada VNET tenia una subnet y cada una tenia VM
    * Conectarnos a un VM utilizando otra de Puente

# Storage Accounts

* Crear un Resource Group

```
 az group create --name rg-az104-clase-siete --location westus
```

* Crear un Storage Account 
 * Nombre : csaz104clase07<nombre>
   * El nombre debe ser unico porque crea una URL
 * Redundancy :
   * LRS (Solo copia los datos en el mismo data center)
 * Access Tier
   * Puede ser: Hot -> Cool -> Cold -> Archive
     * Mas frio el almacenamiento, es mas barato el alacenamiento por gigabite pero mas caro el acceso
   * Elegimos HOT
 * Networking
   * Public from all networks
 * Data Protection
   * Soft Delete : Disabled
 * Security
   * Defender for Storage : Disabled

* Proceder con la creacion

* Servicios disponibles
  * Container
  * File Share
  * Queue 
     * Enterprise service bus para pobres)
  * Tables
     * (Base de datos relacional para pobres)

## Subir un blob

* Crear un container
   * Name : az104-container
* Subir un blob (archivo) al container
  * Entrar al container
  * [LINK] Upload
  * Elegir un archivo
* Obtener la URL del blob
  * Properties -> Copiar URL
  * Si trato de accder a la url en el navegador me tira error porque el blob es privado

```
https://csaz104clase07trainner.blob.core.windows.net/az104-container/MS-102-0200-Manage%20Users.pdf
```

## Manejar el acceso a nuestros blobs

* A pesar de que no es una buena practica el acceso publico vamos a hacerlo para mostrarles
   * Si le trato de cambiar el acceso a publico no me deja
   * Primero tengo que ir a la configuracion de seguridad del Storage account
      * Stroage Account -> Settings -> Configuration
        * Allow Blob anonymous access : Enables
   * Ahora si Puedo cambiarle el Access level al blob

> [!NOTE]
> Esta es la tecnica del lado oscuro, en produccion tengan cuidad cuando dejan acceso publico.

* La forma correcta de dar acceso a un blob es mediante un SAS (Shared Access Signature)
  * Una url con una clave para controlar el acceso al blob
  * Elegir el blob y en los tres puntitos poner create SAS
    
<img width="812" height="114" alt="image" src="https://github.com/user-attachments/assets/21bf2b72-7f8b-4834-8203-e7cb678cdf3b" />

  * Al crear un SAS puedo definir
    * Fechas entre las que tengo acceso
    * IPs /Rangos de IP que pueden acceder

> [!WARN]
> Copiar la URL que genera el SAS, no se vuelve a mostar


# Networking

## Balanceo  de Carga
