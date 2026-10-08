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
  


