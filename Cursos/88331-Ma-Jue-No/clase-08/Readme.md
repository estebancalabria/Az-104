# Clase Ocho - 8 de Octubre del 2026

# Repaso

* Storage Account
  * Servicios
     * Containers / Blobs 
    * File Share
    * Queue Storage
    * Table Storage
  * Accesos
      * SAS
      * Por VNet con reglas de security + network
  * Tiers
      * Hot
      * Cool
      * Cold
      * Archive
  * Proteccion
    * Bakcup
    * Soft Delete
    * Redundancia (LRZ, GRZ)
    * Versionado
    * Snapshots

---

# Opciones de Computo en Azure

* Azure tiene un monton de servicios para que las empresas desplieguen y desarrollen sus apps

<img width="1638" height="1046" alt="image" src="https://github.com/user-attachments/assets/c11eb3ac-40a8-462c-894d-3b26a8f1189c" />

<img width="404" height="389" alt="image" src="https://github.com/user-attachments/assets/792d26ed-208d-4faf-813a-1b0b813f6d96" />


* El administradore de Azure debe decidir en que servicio desplegar la aplicacion

* Virtual Machines (IaaS)
  * Ideales para estrategia lift-and-shift
  * Te permite un control total del entorno
* App Services
  * El servicio de Web Hosting de Azure
  * Permiten desplegar Apps en distitnas tecnologias como Java. Net y NEt Core
  * Permiten opciones de automatizar el escalado manualmente o basado en condiciones de carga
  * Variedades de Planes y precios
* Containres (PaaS)
  * Hay varios servicios para desplegar contenedores en Azure
      * Container Intances (aci)
        * Pocas opciones de escalado dinamico
        * Elegis el Size y si queres mas grande lo tenes que crear de vuelta.
        * El mas economico
      * Container Apps (aca)
        * Tiene mas opciones de escalado
        * Por ende es un poco mas caro
        * Tiene mayor configuracion de networking
      * App Service
        * Este servicio tambien me permten alojar ciertos contenedores
        * Ideal para aprovechar si ya tengo un plan de App Serivice
      * Kubernetes (aks)
        * Una solucion de orquestacion de contenedores (no de Microsoft)
        * Microsoft la incoporo el Azure
        * Es el maximo nivel de control y flexibilidad a la hora de trabajar con contenedores
        * Se usa muchisimo en arquitectura de microservicios
        * (No hay lab)
    * Para desplegar una aplicacion en uno de los recursos anteiores necesitas una imagen base sobre la cual desplegar la app
    * Las imagenes se suben a registros de contenedores publicos:
      * https://hub.docker.com/
      * https://mcr.microsoft.com/
    * Si la imagen tiene una app de la organizacion no la puedo subir a un contenedor publico
      * Azure tiene su registro de contenedores privado
        * Container registries (acr)

---
# Break hasta y 15
# Reiniciar el LAB
---

# Virtual Machines

## Setup

* Crear un grupo de Recursos

```
New-AzResourceGroup -Name rg-az104-clase-ocho -Location Westus 
```

* Crear una VM

## Forma de Conexion a la VM
 
* Distintas formas de conectarnos a la VM
 * RDP
   * La mas comun
   * Por IP Publica
      * Si la conexion esta abierta siempre estamos expuestos a ataques del exterior -> Inseguro
      * JIT -> Just In Time
         * Habiliamos la conexion cada vez que me piden conectar
         * Requiere que el usuario se conecte en portal, vaya a la vm que se quiere conectar y en connect ponga el boton "Request JIT"
         * Se puede visualizar las maquinas que tengo trabajando con JIT en:
            * Defender for cloud -> Workload Protections
   * Por VPN
       * Crean un VPN Gateway
       * Tu maquina on Premise se mete en esa VPN
       * Te conectas por RDP cona la IP privada (La VM no tiene ip publica)
       * (Requiere toda la infraestructura de manejar una VPN)
  * Por Bastion
     * Via Browser desde el portal
     * Es un recurso Caro
     * No necesita tener IP Publica
     * Te podes autenticar a la VM desde el navegador con Microsoft Entra
     * El bastion es un recurso de Azure que da acceso a 1 o varias VM y esta en su propia subnet que se llama AzureBastionSubnet
     * Se puede crear automaticamente desde una VM o podemos ir a Bastions y crear el recurso
   * Ejecutar comandos de Powershell en la VM sin RDP desde el portal
     * (VM) -> Operations -> Run Command
        
## Escalado de VMs

* Esclado Vertical
  * Cambiarle el tamanio
     * Manualmente
       * (VM) -> Availability + Scale -> Size
     * O por regla
     * Si vm sola hacemos escalado Vertical
 
* Escalado Horizontal
  * Crear un Virtual Machine Scale Set
   * Un conjunto de maquinas virtuales con la misma caracteristica detras de un load balancer
   * La cantidad de maquinas virtuales no es fija, sino que se puede determinar dinamicamente
   * Definir manualmente o mediante reglas la cantidad de maquinas virtuales de un VMSS se llama Escalado Horizontal
   * Los VMSS se usan en escenarios de alta disponibilidad

