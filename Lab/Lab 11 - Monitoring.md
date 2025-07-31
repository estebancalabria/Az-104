# Laboratorio 11 - Logging


## Parte 1 : Monitorear la VM

Pasos
1. Crear el Resource Group
    
```powershell
NEw-AzResourceGroup -Name rg-az104-clase-09 -Location westus
```
    
2. Crer Un Log Analitics Workspace

3. Ver las tablas y hacer una consulta con Kusto (igual no hay nada) en la opcion de logs

> En el lenguaje Kusto (KQL) Select * from Alerts  seria Alerts
> https://learn.microsoft.com/en-us/kusto/query/?view=microsoft-fabric

4. Ir al Activity Logs de Resource Group y exportarlo al Log Analitics Workspace

5. Crear una VM desde el portal

6. Conectarnos a la VM

7. Ir al log Analitics Workpace\Agents y descargar el agente de la virtal

      * El Agente deberia guardar informacion de la maquina en el log analitics worspace
      * Lo copiamos a la virtual en el escritprio
      * Lo instalamos
      * En la m isma pantalla de Azure tenes la info para conectarlo al Log Analitics Workspace
              * Workspace ID
              * Workspace Key
      * Esperar que aparezca, no es instantaneo
        

8. Vamos a Crear un Data Collection Rules

9. Esperar unos minutos y ejecuta esta consulta

```kql
Perf
| where TimeGenerated >= ago(15m)
| where ObjectName == "Memory" and (CounterName == "Committed Bytes" or CounterName == "Available Bytes")
| summarize AvgCounterValue = avg(CounterValue) by CounterName, bin(TimeGenerated, 1m)
| order by TimeGenerated asc

```




