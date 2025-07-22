# Soluciones de computo (AppService)

La soluciones de computo para desplegar aplicaciones  
* IaaS (Infraestructura comoo servicio) : Para control total
          * Virtual Machine
* PaaS (Plataforma como servicio) : Para desplegar desde el codigo fuente y Azure maneja la Infraestructura
          * App Service
          * Contenedores
                * App Service
                * Container Instances
                * Container Apps
                * Kubernetes

## Requisitos

Crear el Resource Group
```bash
   az group create --name <NOMBRE-RESOURCE-GROUP> --location westus 
```

## Scenario 1 : Deployment en un App Service desd Codigo

1. Crear un App Service Plan  

> Crear el plan desde el portal con Windows
   
2. Crear App Service

> Crear el App Service del Portal de codigo con opcion .NET 9

3. Crear una aplicacion de .NET en el CLi

```bash
  dotnet new mvc --name DemoApp
```
Luego pararnos en la carpeta   

```bash
  cd DemoApp
```

4. Desplegar nuestra Aplicacion

** USar Comando az webapp deploy**
```bash

```

## Scenario 2 : Deployment en un App Service Rapida

1. Crear una aplicacion de .NET en el CLi

```bash
  dotnet new mvc --name DemoApp
```
Luego pararnos en la carpeta   

```bash
  cd DemoApp
```

2. Crear App, Crear Plan y Deplegar en un solo comando

```
az webapp up --resource-group <NOMBRE-RESOURCE-GROUP> --name <NOMBRE-APPSERVICE-CREAR> --plan <NOMBRE-PLAN-CREAR>
```


## Scenario 3 : Deployment en un App Service desde una image de Docker

1. Crear un App Service Plan  

> Crear el plan desde el portal con Linux


2. Crear El app service

> En vez de deply de code ponemos container y en la sola container ponemos como nombre de la imagen nginx

