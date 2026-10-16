# Clase Nueve - 15 de Octubre 2026

# Repase

* Soluciones de Computo
  * Virtual Machine (IaaS)
    * RDP
      * Tener la conexion siempre abierta (inseguro)
      * JIT
      * VPN (A la ip de red privada de la maquina virtual)
      * NSG : Network Security Group
    * Bastion
  * Contenedores
    * Container Instance (aci)
    * Container Apps (aca)
    * Kubernetes (aks)
    * App Service
  * App Service (Paas)

# Novedad

* Salio ahora una alternativa a docker que se llama podman
  * https://podman.io/
 
# App Service

* Crearmos el RG

```
New-AzResourceGroup -Name rg-az104-clase-09 -Location westus
```

* Instalamos dotnet si no lo tenemos instalado
  * https://dotnet.microsoft.com/es-es/download

* Crear una aplicacion en dotnet desde el cli

```
dotnet new mvc --name DemoApp
```

* Crear la app x 2 : tanto en local como en el CLI de azure

* Ejecutar la app

```
cd DemoApp
dotnet run
```

* Vamos al Recurso App Service Plans y creamos uno
  * Name :Plan-S1-Win
  * SO : Windows
  * Pricing Plan  : S1
 
* Sobre el mismo plan podes deplegar varias Apps

* Vamos a crear un App Service
    * Name : app4trainer......azurewebsites.net
    * Plan : Plan-S1-Win
    * Region : La misma del plan
    * Publish : Code
    * Runtime Stack : Dotnet 9 (la version que me de al hacer dotnet --version en el cli de azure)
    * Enable Application Insights : No
 

* Creamos una version para publicar

```
dotnet publish -o ./pub
cd pub
zip -r pub.zip .
az webapp deployment source config-zip --resource-group rg-az104-clase-09  --name app4trainner --src ./pub.zip
```

* Luego chequeamos que la app se haya desplegado
    * Van a App Service
 
---
BREAK
HAsta y 20
---

# Container

> No me la container

* Vamos a crear el RG si iniciamos el laboratorio de nuevo

---

## Container Intance

* Vamos a instalar una imgen de docker nginx
    * https://hub.docker.com/_/nginx
 
* Name : aci4trainner
* SO : Linux
* Image Source : Other Registry (defecto usa dockerhub)
* Image : nginx
* Puertos
  * 80
  * 443
* Enable container instance logs : No
  
* Una vez desplegado el contenedor vemos que tiene una ip publica  la que podemos acceder por el navegador por http (no https)

<img width="449" height="199" alt="image" src="https://github.com/user-attachments/assets/26fff5ef-2aa4-485e-96b2-a7fc931496f0" />

* En (ACI) -> Settings -> Logs
    * Aca se ve la salida por consola del contenedor

---

## Container Apps

* Analogia
   * (App Service Plan) -- analogo a --> (Container Apps Enviroment)
   * (App Service) -- analogo a --> (Container Apps)

 * Creo el Container Apps environment junto con el Container App

 * Container App
   * Name : aca-nginx
   * Container App Enviroment : (crea automaticamente)
   * Contanier
     * Publico
     * Docker Hub
     * nginx:latest
   * Networking
     * Ingress : Check
     * Accepting Trafic from anywhere
     * Ingress Type : http
     * Port 80
     * Http/1

* Una vez desplegado se puede acceder mediante la url publica
  * En este caso el ingreess recibe el en 443 y lo manda al 80 del contenedor
 
* En monitoring -> Log Stream ves la terminal del contenedor

* El Ingress
  * Permite recibir peticiones https y redigirlas a cualquier puerto del contenedor
  * Permite filtrar trafico como si fuera un NSG
  * Permite balancear la carga en distintos contenedores como si fuera un Load Balancer

---

# Container Registries

* Aca es donde subimos las imagenes de nuestras apps
* Name : <nombre_unico>

* Para subir imagenes al ACR puedo usar
  * Los comandos de docker
  * Los comandos de azure
 
* Dentro del Access Keys habilitamos el admin user para tener un usuario y pasword para subir imagenes con docker

---

# Proxima Clase

* Vamos a subir una imagen a nuestro ACR y desplegarla (en un ACI o ACA desde nuesto ACR)
* Vamos a crear una app que subimos con docker a nuestro ACR
