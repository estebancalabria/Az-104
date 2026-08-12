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

* Probar acceder al blob desde el navegador mediante el SAS

# Uso del storage account habitual

* Portal (lo que usamos)
* Storage Browser
* Azure Stroage Explorer
   * Se debe instalar
   * https://azure.microsoft.com/en-us/products/storage/storage-explorer#Download-4
* AzCopy
   * Se debe instalar
   * https://learn.microsoft.com/es-es/azure/storage/common/storage-use-azcopy-v10

```
azcopy login
```

* Te manda una url para logueart

----
# BREAK! CERRAR Y VOLVER A ABRIR EL LABORATORIO
----

## File Shara

* Me permtien crear un disco compartido (una unidad de red) con acceso por SMB
* Sirve como disco compartido entre varias VM

* Crear un Rg

```
 az group create --name rg-az104-clase-siete --location westus
```

* Crear una VM
  * Name : vm-az104-clase-siete
  * SO : Windows Server
  * RDP habilitado
  * NO olvidar usuario y pass
  * Que cree la vnet, la subnet y el nsg solito

* Conectarnos a la VM por RDP

* Abrir el powershell en la virtual

* Crear un storage account

```
New-AzStorageAccount -ResourceGroupName "rg-az104-clase-siete" -Name "csaz104trainner"  -Location "eastus" -SkuName "Standard_LRS" -Kind "StorageV2"
```

* Crear un recurso de File Share
  * Name : smb4trainner

* En Overview apretar connect

* Generar un script en la letra G y ejecutarlo en el poweshell de la maquina virtual

<img width="380" height="347" alt="image" src="https://github.com/user-attachments/assets/4d7bfaca-e61d-4d5a-b1c2-aaa44be40b62" />


* Ejecutar el script en la vm remota

* Acceder al G: tanto desde powershell como del explorador de archivos
  
