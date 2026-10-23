# Clase 11 - 22 de Octubre del 2026

# Repaso

* Microsoft.Compute
    * Hicimos una applicacion en NodeJS
    * La desplegamos en contenedores
      * Azure Container Registry
          * Lo subimos mediante Dockerfile
      * Azure Container Apps
        * Teniamos que configurar el ingress
      * Kubernetes
        * Esto no pudo hacer en los labs de XtremeLabs
        * Teniamos dos Manifiestos YAML
* Monitoring
  * Defender for Cloud
  * Activity Log de Cada Recurso
      * Retencion de 90 Dias
  * Log Analytics Workspace
      * Se guardan los logs en distintas tablas
      * Se consultan mediante
  * Monitor
    * El servicio maestro de telemetria sobre recursos


# Monitoring

* Creamos el RG
    * az group create --name rg-az104-clase-11 --location westus
* Crear un Log Analitics Workspace
    * name : Log-az104-clase-11
    * Tablas Creadas por defectos
        * Alert
        * ...
        * Usage
        * Operation
* Ir a Logs, habilitar consultas KQL (Kusto Query Language)
    * Usage

## Guardar el ActivityLog en el Log Analitics Workspace 

* Vamos a hacer que El Activity Log del RG se guarde en el Workspace
    * Vamos al RG
      * Vamos al Activity Log del RG
      * Export Activity logs
      * Crear un Diagnostic Settings
          * Es un mecanismo que tiene Azure para decirle que los logs y metricas los envie a otro lado
          * +Add Diagnostic Settings
              * Elijo el Log-az104-clase-11
              * Elijo toda las categorias de eventos

* Vamos a hacer algo en el RG
  * Crear una VM

> [!NOTE]
> Se deberia llenar con tiempo la tabla AzureActivity

* En el log Analitycs Workspace aparece la tabla AzureActivity

> [!WARN]
> Ojo no aparece enseguida, hay que esperar

## Guardar Los Logs del Entra en el Log Analitics Workspace 

* Vamos al Entra
  * Vamos a Sing In Logs
      * Lo mismo podemos crear un Diagnostic Segtting para que los copie al Workspace
  * Vamos a Audit Logs
      * Lo mismo podemos crear un Diagnostic Segtting para que los copie al Workspace

## Guardar los logs de la VM en en el Log Analitics Workspace 

* La idea es que el Event Viewer y similares se guarden en el Log

* Ir monitor
  * Insights
    * Virtual Machine
      * Enable VM Insights -> Configure Insights
        * Elegimos la VM y le damos Enabled
        * Esto instala un agente llamado AMA (Azure Monitor Agent) en la VM
        * Tenems que poner "Customize infrastructure monitoring" para elegir nuestro LOG
        * Se configura automaticamente un DCR (Data Collection Rules)
          * Este dice que se copia de la VM a los logs

* Ir al Workspace y fijarse que aparecen muchas tablas nuevas que fueron creadas por el AMA
    * Perf
    * VMCompupter (No se llena mas)
    * VMProcess (No se llena mas)
    * ...

* Las Podemos consultar por KQL pero seguro todavia estan vacias

* Vamos a ir al DCR (Data Collection Rule) para ver que se copia
  * Veo que solo copia performance counters
        * Se guardan en la tablas Perf (oldStyle) y InsightsMetrics (newStyle)
  * Vamos a agregar para que ademas copie los Windows Event Logs en el Worspace

> [!NOTE]
> Se deberian guardar en una tabla que se llama Event
 
* Podemos consultar la taba Heartbeat que se actualiza todo el tiempo cuando el AMA se conecta con Azure

```
Heartbeat
```

---
# Break
Hasta y 35
De paso vemos si se graba en el LOG
---

* Vamos a ver despues del break si se guardo algo en:
   * Event : Esta si tiene registros
   * Perf : No hay nada, esta vacia
   * InsightsMetrics : Es la que reemplaza a Perf, esta llena de datos
         * Aca se guardan los Performance Counters

* KQL no solo te permite ver tablas sino que tiene la posibilidad de graficar

```
InsightsMetrics
| where TimeGenerated > ago(30m)
| where Name == "UtilizationPercentage"
| summarize AverageUtilization = avg(Val)
    by bin(TimeGenerated, 5m), Computer
| render timechart
```

---
# Reiniciar el LAB
---

* Crear el RG y una VM

* Ir  a Monitoring -> Metrics
   * Explorar las metricas sobre las VM que aparecen
   * Estas metricas aparecen aunque no tengamos el AMA instalado
 
* Si vamos a Monitor -> Metrics tambien podes explorar metricas para cada recurso de Azure

* Vamos a programar una alerta sobre la VM
   * Programarse sobre Eventos
   * Programarse sobre Metricas

> [!NOTE]
> Las alertas estan relacionadas a un log o a una metrica (Activity Log o Log Analitics Workspace). En este caso vamos a hacerla sobre el ActivityLog

* Creo una alerta en la VM
   * See Al Signals
      * Busco "Shut Down"
      * Completo los parametros de la alerta
   * Acciones
      * Notificar una persona  (por mail / sms)
      * Podemos ejecutar una automatizacion
    

* Vamos tambien a EMULAR crear una alerta basada en metricas solo para ver que tambien se puede

* Me hace validar el mail y me muestra 

<img width="717" height="274" alt="image" src="https://github.com/user-attachments/assets/e2d6f97e-80b9-43bb-bdf7-b92c16057858" />

* Sale alerta de este tipo que te llega por mail

<img width="715" height="264" alt="image" src="https://github.com/user-attachments/assets/03dd6e8c-d8a8-4375-9ca7-67f021321ca9" />
