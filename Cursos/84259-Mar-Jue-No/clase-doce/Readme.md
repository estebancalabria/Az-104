# Clase Doce - 27 de Agosto de 2026

# Ultima Clase

# Backup

* Crear el RG
  * Name : rg-az104-clase-12

* Crear una VNET
  * vnet-az104-clase-12
    * 10.0.0.0 / 16
    * Subnet : default
      * 10.0.0.0 /24 

* Crear una VM con su NSG
  * vm-az104-clase-12
  * RDP habilitado
  * Asegurarse que este en la vnet anterior
 
* Conectarnos a la VM y crear un archivo de texto en el escritorio

* Crear un Storage Account
    * cs4backup
 
* Crear un Log Analytics Workspace
    * log4backups
 
* Crear un recurso de Recovery Service Vault
  * vault-az104-clase-12
  * En el overview  ponemos + Backup
      * Elegir Backup de VM de Azure
      * Click BACKUP
          * Standard
          * Agregar la politica
          * Agregar la vm
       
* En backup items puedo ir a ver la VM y hacer el backup manual... pero todavia esperen

* En monitoring -> Diagnostic Settings  voy a configurar donde se guardan los logs que se van haciendo los backups
    * ds-4backup
    * Que lo guarde todos los logs en el log analytics worskpace y en el storage account
 
* En Backup Jobs se pueden ver los backups que se hicieron

* En backup items puedo ir a ver la VM y hacer el backup manual... ahora hagamos el backup

* En backup items se puede tambien restaurar el backup
