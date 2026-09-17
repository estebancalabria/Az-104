# Clase Dos - 17 de Septiemrbe del 2026

# Repaso

* Interfaz de Azure
* Microsoft Entra
  * Permisos del Entra
  * RBAC
* Virtual Networks
* Storage
* Compute
  * AppService
  * Container
    * Container Instance
    * Container Apps
    * Kubernetes
  * VM
* Backup
* Monitoreo
* Defende
* 
# Hoy Vamos a ver

* Usuarios
* Permisos RBAC
* ...tal vez algo de policies
* Creacion de VMs

# Manejo de Permisos

* Hoy vamos a utilizar el CLI

<img width="290" height="203" alt="image" src="https://github.com/user-attachments/assets/b1423732-6bfe-4bed-abc7-dfeaf0522a29" />

* Para interactuar con Azure desde el cli tenemos:
  * Comandos de Powershell
  * Comando de Bash
      * az

```powershell
az group create --name rg-az104-clase-02 --location westus
```

* A Un alumno le paso esto
<img width="1913" height="250" alt="image" src="https://github.com/user-attachments/assets/dd208350-21b3-4f18-8000-72fcf3f173ee" />

> [!NOTE]
> En este caso en azure tiene definida una Policy que determina en que regiones se pueden crear grupos de recurso

* Vamos a buscar a nuestros colegas en el tennant

* XLab-jQx-264@xtremelabs.us
* XLab-lWs-303@xtremelabs.us
* XLab-D0w-305@xtremelabs.us
* XLab-08f-306@xtremelabs.us
* Xab-krU-319@xtremelabs.us
* XLab-Sjq-320@xtremelabs.us
* Xab-8jZ-321@xtremelabs.us


* Vamos a los Resource Groups
  * Observamos que podemos ver el REsource Group que cree pero no puedo ver el que creo mi compa a pesar de que estamos en el mismo tennar
 
* Vamos a darle permiso a otro usuario del tennant para que pueda interacturar con mi Resource Group
  * Voy al RG que cree
  * Voy a la parte de Access Control (IAM) para darle permiso a otro usuario para trabajar con mi RF
 
* Ahora en la parte de la parte de resoruce Groups hay dos, el que cree y el que hizo mi companiero

<img width="320" height="270" alt="image" src="https://github.com/user-attachments/assets/133fecf3-e705-49d7-a52b-1487a83cccf0" />

* En el activity log tiene que aparecer una entrada "Create rol Assignent"

<img width="384" height="163" alt="image" src="https://github.com/user-attachments/assets/b3495dce-8bc3-4bca-91b1-f64c248815c6" />
