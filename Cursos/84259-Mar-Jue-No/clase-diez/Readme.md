# Clase Diez - 20 de Agosto del 2026

# Repaso

* Microsoft.Compute
  * Containers
    * Docker
    * Registro de Imagenes
        * Docker Hub
        * Microsoft Artifact Registry
        * Azure : Azure Container Registry (ACR)
            * Importamos una imagen en el ACR desde el CLI
    * Desplegar contenedores en Azure
        * Container Instances
        * Container Apps
        * Kubernetes
  * AppService
    * Despliegue de una app PHP

# Setup

* Crear el RG
  * rg-az104-clase-10

# Microsoft Compute

# Monitoreo / Monitoring

> [!NOTE]
> La aparicion de los registros en los logs no es instanea, lleva tiempo (a veces 10 minutos)

* En el Entra
  * Sign-In Logs
    * Para ver quien se logue en Azure
  * Adit Logs
    * Para ver que se va haciendo en el entra (creacion/elminacion usuarios, etc)
* En Azure
  * Activity Log
      * El log individual que se va guardando de lo que va haciendo cada usuario en el recurso
      * Uno importante es el Activity Log de la subscripcion
      * Se borran cada 90 dias
  * Log Analitics Workspace
      * Es una base de datos de Logs para retencion de logs donde los logs se guardaen en tablas
      * Los logs se consultan con un lenguaje llamado KQL (Kusto Query Language)
      * Es una decision del Adminitrador que workspaces crear
          * Una base de datos de logs donde guardamos todo
          * Varias bases de datos divididas segun algun criterio
      * A veces se crea uno por defecto por region
  * Diagnostic settings
      * Define reglas que es lo que se exporta del Activity Log al Workspace


## Laboratorio

* Crear un Log analitics Workspace
  * Name: log-az104-clase-10

* Ver las tablas que se crean por defecto
  * Tablas de uso interno
      * Usage : Cuantos datos ingiere el log
  * Tablas para importar el Activity Log
      * La idea es conectar el Activity Log para que exporte los datos en el Log Analitics Worspace
      * Azure Activity / Operacion
      * Azure Metrics
  * DefenderForCloud
      * SecurityEvent
      * AuditLogs
  * Para los logs de las VM
      * La idea es instalar un agente en las VM para que log lo guarde en aca y  no el log de windows solamente
      * Hearbear
      * Process

<img width="1549" height="402" alt="image" src="https://github.com/user-attachments/assets/25c6f7c1-aead-4641-8141-1eb539a4ca83" />

* Vamos a conectar el Activity Log del RG con el Workpace
* Ir al Activity log del RG
* Poner Exportar
* Definir un diagnostic Settings
  * Name : activity-log-to-log-az104-clase-10
  * Elijo todas las categorias
  * Y elijo el log analitics workspace creado como destino

> [!NOTE]
> En algun momento va a aparecer la tabla Azure Activity
> Podeos crear otro recurso mientras para probar

### Guardar Logs de Azure

* Vamos a alimentar el Activity Log y que copie cosas al Workspace
  * Crear una VM
    * No olvidar la clave
    * Elegir el Windows Server
    * Crea implicitamnete la red, el nsg, todo lo que vimos
   
* En el Activity Log del RG veo la Creacion de la VM

* En el Log Analitics Workspace aparece la tabla
    * AzureActivity
 
* Vamos a consultar esa tabla con KQL (Kusto Query Language)
    * Entrar a la opcion de Logs del Log Analistics Worskpace (seria como el DBStudio para hacer consultas KQL)
    * Pasar de "Simple Mode" a "KQL Mode"

* Es como hacer "Select * from AzureActivity"
```kql
AzureActivity
```

* Con un where
```kql
AzureActivity
| where ActivityStatusValue == 'Success'
```

* Que haga un grafico de torta

```
AzureActivity
| summarize Cantidad = count() by ActivityStatusValue
| render piechart
```

### Guardar Logs de las VM

* Ir a la VM
  * Monitoring -> Insights
  * Es lo mismo ahora que ir a la opcion Monitors
    * [LINK] Monitor Settings
      * Logs
          * OpenTelemetry metrics          ---> Desseleccionar
          * [Classic] Log-based metrics    ---> Seleecionar
      * [LINK] Customize infrastructure monitoring
          * Vamos a mandar todo a nuesto Log Analytics Workspace
   * Creando un DCR (Data Collection Rules)
       * Name : msvmi-westus-vm-az104-clase-10 (
    
---
BREAK
DESPUES DEL BREAK VEMOS QUE GUARDA EN EL LOG Y RECREAMOS EL LABORATORIO
ESTA OPERACION PUEDE TARDAR
---




