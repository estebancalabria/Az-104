# Clase Once - 25 de Agosto del 2026

# Repaso

* Monitoring / Logs
  * Que puedo monitorear en Azure:
      * Recursos de Azure
          * Activity log de Cada Recurso
      * VMs
          * Para logging de VM tengo que instalar el AMA (Azure Monitor Agent)
      * Entra
          * Sign-In Logs
          * Autit Logs
      * Acciones de Azure
  * Log Analitics Workspace
      * Base de datos de Logs
      * Se guardan en tablas
  * Copiar / Streaming
      * DCR : Data Collection Rules
          * Copiar del recurso al Log Analytics
          * Para VMs y recursos de Azure
      * Diagnostivcs settings
          * Copiar del entra al Log Analytics Workspace
  * Consulta de Logs
        * KQL (Kusto Query Languange)
* VM
  * Run command
    * Para ejecutar un comando en la VM 

---

# Monitoring de Apps 

## Pre Requisitos

* Tener instalado el dotnet
  * https://dotnet.microsoft.com/es-es/download

## Setup

* Crear el Resource Group
 * Name: rg-az104-clase-11

* Crear un Log Analitics Worskpace
  * Name: log-4-application
 
* Crear un recurso de Application Insights
  * Es un dashboard para el log de aplicaciones
  * No guarda nada, los datos reales se guardan en el log analytics workspace
  * Es como el monitor pero para apps
  * Name : applog4trainner
  * Conectado con el Log Analitics Workspace (log-4-application) creado previamente

> [!NOTE]
> Mirar en la consola de Azure que version de dotnet tiene instalada con el comando dotnet --version. En mi caso la 9.0.316

* Crear un App Service
   * Name : app4trainner
  * Runtime Stack : Net9
  * En la solapa monitoring la asociamos con el Application Insights

## Creacion de una APP

* Con el dotnet instalado vamos a crear una app


```
dotnet new mvc --name WebDemo
```

* Nos paramos en la carpeta de la APP

```
cd WebDemo
```

* Ejecutar con

```
dotnet run
```
