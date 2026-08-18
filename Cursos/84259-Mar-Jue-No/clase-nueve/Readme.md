# Clase Nueve - 18 de Agosto del 2026

# Repaso

* Storage Accout
  * Access Tiers
  * Seguridad
    * Firewall Storage
    * SnapShot
    * Versioning
* Networking
  * Routing / Load Balancer
      * Tener dos VMs y delante un LB que distribuye la carga
      * En las dos VM les instalamos el IIS

<img width="667" height="397" alt="Image20260818191058" src="https://github.com/user-attachments/assets/d6e080e9-c2e4-48c6-8856-ade42f4e2c33" />

> [!NOTE]
> En laboratorio que hicimos dejamos las IP Publicas de las VM y tambien las reglas del NSG
> Como la conexion del LB con las VM se hace dentro de las VNET, si borro las reglas del NSG igual funciona porque todo el trafico en la VNET esta habiltiado

# Setup

* Crear el RG
  * rg-az104-clase-09

# Compute

* Los recursos computacionales donde instalamos Aplicaciones
    * VMs
    * AppService
    * Container
        * Containr Instances
            * Conservan el tamanio una vez creados
        * AppService
        * Container App
            * Se pueden escalar
        * Kubernetes
            * Una plataforma de orquestacion para manejar contenedores

## Containers

### Contaienrs vs VMs

<img width="1106" height="581" alt="image" src="https://github.com/user-attachments/assets/4ccc2282-1d3a-4512-bd6c-b389080692e6" />

### Container Images

* Los contenedores se llaman docker
    * https://www.docker.com/
* Existen repositorios de contenedores con Imagenes ya creadas (con programas ya instalados)
    * https://hub.docker.com/
    * https://mcr.microsoft.com/
    * Es un container registry
    * Guarda imagenes publicas
    * En azure hay algo similar que es el
      * Contaienr Registry
      * Un docker hub pero privado en mi azure
* Justificacion
    * Surge ante el problema de "No anda en la maquina del cliente, pero anda en la maquina del desarrollador"
        * Si ambos corren la aplicancion en un contenedor, me aseguro que tiene el mismo entorno
    * Si la aplicacion falla, el contenedor se puede reiniciar facilmente
    * Mas barato y mas facil de administrar que la VM

### Container Instances

* Vamos a desplegar una imagen de docker hub
  * https://hub.docker.com/_/nginx
  * Nginx es un webserver como IIS que ademas tiene reverse proxy
  * Cada imagen tiene un nombre, en este caso
    * nginx
   
* Voy a container Instances y le doy Create
  * Name : aci-nginx
  * Imagen : mcr.microsoft.com/oss/nginx/nginx:1.9.15-alpine
  * Puertos : 80, 443

* En overview del container instance figura la IP publica
  * Abrir la IP publica en el navegador
* En Settings -> Containers
  * Se puede ver en logs lo que arroja el contenedor por la consola
 
### Container Registries

* Crear un conainer Registrie
  * Name : <nombre-unico>
  * SKU : Basic
* Una vez creado ir a Settings->Properties
  * Check Admin user
  * Save

* Importar una imagen el el ACR mediante el CLI

```
az acr import --name  <nombre-unico> --source docker.io/library/nginx:latest  --image nginx-mio
```

* Vamos a crear un nuevo conainer Intance pero que saque la imagen de mi acr (no del respositorio publico de Microsoft como hicimos antes)
* Acceder al contenedor mediante http://<ip-publica>

---
# BREAK
# NO OLVIDAR REINICIAR EL LAB
---
