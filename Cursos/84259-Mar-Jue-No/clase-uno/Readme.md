# Clase Uno - 16 de Julio del 2026

# Roadmap

* Microsoft Entra
   * Administracion de Identidades
      * Ejemplo Creacion de Usuario
   * Administracion de permisos
      * Permisos del Entra
      * Permisos sobre recursos de Azure (RBAC)
   * Gobernanza
      * Manejo de Politicas 
* Administracion
   * Creacion de Recursos mediante ARM Templates
   * Uso CLI
* Virtual Netorks (vnet)
   * Manejo de Redes an Azure
   * Conectar distintas redes entre si
   * Trobleshooting de problmeas
   * Manejo del trafico y la seguridad (----> Conecta con el az500)
* Azure Storage : Storae Account 
* Despliegue de Apps
   * Virtual Machines (vm)
   * App Servicess
   * Contenedores / Docker
      * Container Intances
      * Contaienr Apps
      * Kubernetes
      * Azure Container Registry (Simil -> Hub: https://hub.docker.com/)
* Backup (Data Protection)
* Alarmas y monitoreo
   * Log Analytics Workspace
   * Activity Log
   * Monitor
   * Alerts
   * (Application Insights) (----> Conecta con el az204)
* Defender (----> Conecta con el az500)
 
# Sobre el Profe

* MCT Esteban Calabria
* Redes
   * https://www.linkedin.com/in/esteban-calabria-7a44401a/
   * https://www.instagram.com/mct.esteban.calabria/

# Links

* Portal de Azure
    * https://portal.azure.com/
* Portal Microsoft entra
   * https://entra.microsoft.com/
* Microsoft Learn
  * https://learn.microsoft.com/es-mx/training/courses/az-104t00
* Rendir el examen
  * https://learn.microsoft.com/es-es/credentials/certifications/azure-administrator/?practice-assessment-type=certification
* GitHub Oficial
  * https://github.com/MicrosoftLearning/AZ-104-MicrosoftAzureAdministrator
* Github Pages de los laboratorios
  * https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/

---

# PRoceso de Acceso a XtremeLAbs

* Loguearse al portal de XtremeLabs con el usuario/pass provisto por educacionIT
  * Cualquier problema repoder URGENTE el mismo correo y masndar una mail tambien a alumnos

* Iniciar cualquier laboratorio del Az-400

* Obtener un acceso temporal al portal de azure

<img width="240" height="182" alt="image" src="https://github.com/user-attachments/assets/4ca53a52-69c3-4b9f-b600-a4be7f1a89d8" />

* Loguearse con el usuario y el passwor de XtremeLabs en el portal En modo incognito

* Crear un Resource Group

---

# Microsoft Entra

## Identity

* Los usuarios residen en un tennant
  
* Tipos de Identidad en Microsoft
  * Usuarios Finales (USers)
      * Usuarios del Tennant
      * Usuarios Invitados
  * Applicaciones (app Registratios)
      * Me permite que las aplicaciones accedan a recursos de Azure indetificandose como ellas mismas
      * Me permiten implentar el SSO (single sign on), loguearse en una app con mi cuenta del tennat
  * Enterpise Applications
      * Son aplicacion conocidas que microsoft permite registrar de una forma mas facil
  * Managed Identity
      * Una identidad asociada a un recurso de azure (VM, BaseDeDatos, Storace Account)
      * Tipos
        * System Assigned Manged Identity 
        * User Assigned Managed Identity

* Grupos de Usuarios

### Laboratorio

* Cree un usuario en mi tennant

* Abri una ventana de incognito

* Me loguee con ese usuario
  * Me obliga a cambiar la clave
  * Me obliga el MFA (Multi Factor Autenticator) para poder ingresar
