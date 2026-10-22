# Laboratorio - Azure Monitoring y Log Analytics

## Objetivo

En este laboratorio vamos a:

* Crear un Log Analytics Workspace
* Consultar logs mediante KQL
* Guardar el Activity Log de Azure en Log Analytics
* Guardar los Sign-in Logs y Audit Logs de Entra ID
* Instalar Azure Monitor Agent (AMA) en una VM
* Habilitar VM Insights
* Configurar Data Collection Rules (DCR)
* Guardar Windows Event Logs en Log Analytics
* Consultar las tablas generadas

## 1. Crear un Resource Group

```bash
az group create --name rg-az104-clase-11 --location westus
```

## 2. Crear un Log Analytics Workspace

Desde el Portal de Azure:

* Crear un recurso
* Buscar **Log Analytics Workspace**
* Create

Configurar:

* Resource Group: **rg-az104-clase-11**
* Name: **log-az104-clase-11**
* Region: **West US**

Luego:

* Review + Create
* Create

## 3. Explorar las tablas creadas por defecto

Ingresar al Log Analytics Workspace:

* Logs

Verificar que existan tablas como:

* Alert
* Operation
* Search
* Usage

## 4. Ejecutar una consulta KQL

Ir a:

* Logs

Ejecutar:

```kusto
Usage
```

También probar:

```kusto
Usage
| take 10
```

## 5. Configurar el envío del Activity Log al Workspace

La idea es guardar todos los eventos administrativos de Azure dentro de Log Analytics.

Ir a:

* Resource Group **rg-az104-clase-11**
* Activity Log
* Export Activity Logs
* Add Diagnostic Setting

Configurar:

* Nombre: ActivityLogToLAW
* Destination: Send to Log Analytics Workspace
* Workspace: log-az104-clase-11

Seleccionar todas las categorías disponibles.

Guardar.

## 6. Generar actividad en Azure

Para generar eventos:

* Crear una máquina virtual

## 7. Verificar la tabla AzureActivity

Esperar algunos minutos.

Ir a:

* Log Analytics Workspace
* Logs

Ejecutar:

```kusto
AzureActivity
```

O bien:

```kusto
AzureActivity
| take 50
```

> La tabla puede tardar varios minutos en aparecer.

## 8. Enviar Sign-in Logs de Entra ID al Workspace

Ir a:

* Microsoft Entra ID
* Monitoring & Health
* Sign-in Logs

Luego:

* Export Data Settings
* Add Diagnostic Setting

Configurar:

* Send to Log Analytics Workspace
* Workspace: log-az104-clase-11

Guardar.

## 9. Enviar Audit Logs de Entra ID al Workspace

Ir a:

* Microsoft Entra ID
* Monitoring & Health
* Audit Logs

Luego:

* Export Data Settings
* Add Diagnostic Setting

Configurar:

* Send to Log Analytics Workspace
* Workspace: log-az104-clase-11

Guardar.

## 10. Verificar los logs de Entra

Esperar algunos minutos.

Ejecutar:

```kusto
SigninLogs
```

También:

```kusto
AuditLogs
```

## 11. Habilitar VM Insights

Vamos a monitorear una máquina virtual.

Ir a:

* Azure Monitor
* Insights
* Virtual Machines

Seleccionar:

* Configure Insights

Elegir la VM creada anteriormente.

Presionar:

* Enable

Seleccionar:

**Customize infrastructure monitoring**

para elegir nuestro Workspace.

Elegir:

* log-az104-clase-11

Finalizar la configuración.

## 12. Verificar la instalación del Azure Monitor Agent (AMA)

Durante la habilitación de VM Insights:

* Se instala automáticamente el Azure Monitor Agent (AMA)
* Se crea automáticamente una Data Collection Rule (DCR)

La DCR define qué datos recopilar y hacia qué Workspace enviarlos.

## 13. Verificar las nuevas tablas creadas por AMA

Esperar algunos minutos.

Ir a:

* Log Analytics Workspace
* Logs

Buscar tablas nuevas.

Entre ellas:

* Heartbeat
* Perf
* VMComputer
* VMProcess

## 14. Consultar Heartbeat

La tabla Heartbeat registra cuándo el agente se comunica con Azure.

```kusto
Heartbeat
```

También:

```kusto
Heartbeat
| take 50
```

## 15. Consultar Performance Counters

```kusto
Perf
```

También:

```kusto
Perf
| take 50
```

## 16. Revisar la Data Collection Rule (DCR)

Ir a:

* Azure Monitor
* Data Collection Rules

Abrir la DCR creada automáticamente.

Revisar:

* Data Sources
* Destinations

Observar que normalmente solo recopila:

* Performance Counters
* Heartbeat
* Información de VM Insights

## 17. Agregar Windows Event Logs

En la DCR:

* Data Sources
* Add Data Source
* Windows Event Logs

Agregar:

```text
Application!*
```

Agregar:

```text
System!*
```

Agregar:

```text
Security!*
```

Guardar los cambios.

## 18. Generar eventos en Windows

Dentro de la VM:

* Iniciar sesión
* Abrir aplicaciones
* Reiniciar servicios
* Reiniciar la VM

Esto generará eventos que el AMA enviará al Workspace.

## 19. Verificar la tabla Event

Esperar algunos minutos.

Ejecutar:

```kusto
Event
```

O:

```kusto
Event
| take 50
```

## 20. Consultar procesos de la VM

```kusto
VMProcess
```

También:

```kusto
VMProcess
| take 50
```

## 21. Consultar información de la VM

```kusto
VMComputer
```

También:

```kusto
VMComputer
| take 50
```

## 22. Resumen

Durante este laboratorio:

* Creamos un Log Analytics Workspace
* Ejecutamos consultas KQL
* Copiamos Activity Logs a Log Analytics
* Copiamos Sign-in Logs de Entra ID
* Copiamos Audit Logs de Entra ID
* Habilitamos VM Insights
* Instalamos Azure Monitor Agent (AMA)
* Analizamos la Data Collection Rule (DCR)
* Configuramos Windows Event Logs
* Consultamos AzureActivity
* Consultamos Heartbeat
* Consultamos Perf
* Consultamos Event
* Consultamos VMComputer
* Consultamos VMProcess
