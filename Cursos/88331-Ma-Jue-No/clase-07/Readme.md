# Clase Siete - 6 de Octubre del 2026

# Repaso

* Networking
  * Virtual Machine
  * Balanceo de Carga
    * Load Balancer
      * Nivel Capa 4 de OSI
      * Frontend IP
      * Rules
      * Backend Pool
    * Application Gateway
      * Nivel Capa 7 de OSI
* Network Security Group
* Ip Publicas

---

# Storage Accounts

* Creamos el Grupo de Recursos

```bash
az group create --name rg-az104-clase-07 --location westus
```

## Serivicios

* Blob Service
    * EJ youtube subiria cada video en un blob service si subiera sus videos a Azure
* File Share
    * Discos compartidos de maquinas virtuales
* Queue Storage
    * Colas para comunicar aplicaciones
    * En el mercado hay un producto que se llama RabbitMQ
    * Es el messae broker "para pobres"
* Azure Tables
    * Sin necesidad de tener una base de datos podes guardar informacion tabular

## Redundancia

* LRS : Locally Redundant Storage
  * Mantiene una copia del almacenamiento en otro rack de servidores
* GRS : Global Redundant Storage
  * Tambien se mantiene una copia en otra region (la region espejo)
* GRS-LRS :
  * Con lectura de la copia en la otra region

## Data Protection

* Ojo, no es protecion de acceso. Es una vez que accede

* Encriptacion
  * Encription at Rest : Todo lo que se guarda en azure, incluyendo las cuentas de almacenamiento, van encriptadas
  * Tipo de Encriptacion
    * (MMK) Manejada por microsoft (transparente para nosotros)
    * (CMK) Customer Managed (nosotros manetenemos las claves de encriptacion por ej en un key vault)
* Soft Delete
  * Al eliminarse una cuenta de almacenamiento, los datos se manienen por una ventana de dias para solicitar su recuperacion
* Versionado
  * Se puede ver el log de los cambios que se van realizando si se habilita el versionado por si se cambian los datos de forma indeseada
* Point in time Restauration / Snapshot
  * Generar una imagen de almacenamiento para restauracion en ese punto en el tiempo
 
## Blob Tiers

* Cada blob (archivo) puede tener un tier segun la frecuencia de acceso y determina el costo
* Hot :
  * Acceso Frecuente
* Cool
  * Acceso poco frecuente
* Cold :
  * Backups
  * Esperas no acceder pero cada tanto es posible que lo necesites
* Archive :
  * Acceso no esperado
  * El acceso a los datos requiere una preparacion previa de hasta 30
  * (Como si lo pasaran a cinta)
  * Es el mas barato por GB de almacenamiento, pero si accedes te sale muy caro el acceso

* Mas arriba : Mas caro el Almacenamiento por GB, pero mas barato el acceso (MB Tranferencia)
* Mas abajo : Mas barato el almacenamiento, pero mas cara el acceso/transferencia por red

> Uno puede jugar con estos tiers para optimizr el costo de almacenamiento
> Incluso se pueden cargar reglas de tipo luego de 6 meses sin acceder pasalo a un tier mas bajo

## Creacion del Storage Account (SA)

* Basics
  * Resource group
    * rg-az104-clase-07
  * Storage account name
    * csazure104clase07
  * Region
    * (US) West US
  * Primary service
    * Azure Blob Storage or Azure Data Lake Storage
  * Primary workload
    * General purpose
  * Performance
    * Standard
  * Redundancy
    * Locally redundant storage (LRS)
* Advaned
  * Lo dejamos como esta
  * Se va a entender mejor cuando vea los file Share primero
* Networking
  * Vamos a dejar el acceso publico desde internet
  * Pero en ambies productimos sobre todo si almacenamos informacion sensible considerar que el acceso sea solamente mediante una Vnet en azure
* Data Protection
  * Deshabilito todo
 * Security
   * Lo dejamos por aqui... nada para acotar de esta parte
* Review and Create

### Creamos un Blob

* Vamos a Data Storage -> +Add Container
  * Name : Imagenes
  * Notar que no puedo cambiar el nivel de acceso
* Elegir el container y con el boton UPLOAD subir una imagen al mismo
* Elegir el blob -> Ir al elipsis (...) al final -> Poner copy url

* Al abir esa url en un navegador me da este mensaje porque el acceso es privado

```xml
<Error>
<Code>PublicAccessNotPermitted</Code>
<Message>Public access is not permitted on this storage account. RequestId:e9535c85-301e-000b-0fe4-551a89000000 Time:2026-10-06T22:47:41.7610389Z</Message>
</Error>
```

#### Dar acceso a un blob privado (SAS)

* Para dar acceso a un blob privado debemos crear un SAS (Shared Access Signature)
  * Es una url especial generada a partir de las claves del storage account
  * Las claves se pueden ver en
    * (Storage Account) -> Security and Networking -> Access Keys

* Para crear un sas vamos al blob y elegimos la opcion en el elipsis de "Generate SAS"
  * Recomendado siempre que se pueda filtrar por IP o por rango de IP
  * Una vez generado se muestra una URL que no se puede volver a ver de ningun otro lado en azure
    * El es momento de copiarla y guardarla en un lugar seguro

#### Dar acceso publico a un blob

* No recomendado. Solo para casos muy especiales
* Es para que los sepan
* Ojo que un ataque de acceso bruto a un blob puede impactarte significativamente en la factura

* Primero tengo que habilitar que se pueda poner acceso publico en la configuracion del SA
  * (Storage Account) -> Settings -> Configuration
    * Allow Blob anonymous access : Enabled

* Luego vas al Container
  * Seleccionas el Blob
    * Le das arriba al boton "Chage Access Level"
        * Le pones "Container"
     
* Ahora con la url del blob puede acceder cualquiera
  * Si accedo a la misma dede el navegador ya no me tira el error del Blob

---

### Trabajo con Stroage Account 

* Storage Browser
  * Desde el portal

* Microsoft Azure Storage Explorer dezde Local
  * Es parecido al Explorer de Windows
  * https://azure.microsoft.com/en-us/products/storage/storage-explorer#Download-4

<img width="957" height="339" alt="image" src="https://github.com/user-attachments/assets/af9e225b-74e7-448c-abff-c7cd48d98dcb" />

* Por el cli con el Comando AZCopy desde cualquier CLI
  * Opciono recomendada
  * Te la preguntan en el examen
  * Link de descargas en:
    * https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
   
---
# Break - hasta y 40
---
