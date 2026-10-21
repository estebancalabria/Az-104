# Clase 10 - 20 de Octubre 2026

# Repaso

* Microsoft.Compute
  * Crear una app en .NET
    * Subirla en un APP Service
  * Contenedores (basado en Docker)
    * Desplegamos una imagen que ya estaba en docker hub : ngnix
    * ACI : Container Instance
    * ACA : Container Apps

# Desplegando nuesta app 

* Crear el RG
  * Name : rg-az104-clase-10
 
* Verificar que este NodeJs instalado

```
>node --version
v22.15.0
```

> [!NOTE]
> Se puede instalar desde https://nodejs.org/es

* Vamos a crear una simple app de nodejs creando el archivo server.js

```javascript
const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hola mundo');
});

app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
```

* Para ejecutarlo en la carpeta donde esta el archivo server.js

```
npm init -y
npm install express
node server.js
```

* En el navegador vamos a abrir esta url

```
http://localhost:3000/
```

* Creamos el Container Registries (acr)
 * Name : acr4trainner (cada uno le pone un nombre unico)
 * Luego ir a Settings -> Access Keys -> Check Admin User


* Crear el archivo Dockerfile en la carpeta de nuestra app

```
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY server.js .

EXPOSE 3000

CMD ["npm", "start"]
```

> [!NOTE]
> Este archivo de texto tiene las instrucciones para construir una omagen docker


* Vamos a subir el server.js, package.json y el Dockerfile a una carpeta en el cli de Azure

```
PS /home/xxxx> md nodeapp
PS /home/xxxx> cd nodeapp
```

* Subir nuestra app al acr

```
az acr build --registry acr4trainner --image app-minimal . 
```

> [!NOTE]
> No se olviden el . al final sino no anda

* Crear nuestro container App (ACA)
 * Basics
   * Name : aca-app-minimal
   * No completo nada mas
  * Container
    * Elijo el acr del desplegable
    * Elijo la imagen que subi  del desplegable
    * Version : latest
  * Ingress
    * Enabled
    * Accept Trafic From Anyware
    * Target Port : 3000
 
> [!NOTE]
> Si tira el error "Cannot access ACR 'acr4trainner.azurecr.io' because admin credentials on the ACR are disabled." hay que habilitarle las credenciales al acr

---
BREAK HASTA  Y 30
---

# App para administrar Kubernetes

* Headlamp
  * https://headlamp.dev/
* FreeLens
  * https://freelensapp.github.io/

# Kubernetes

* Vamos a crear nuestro Kubernetes Services
  * Creamos un cluster de Kubernetes
  * Name : aks4trainner
  * En Integrations conectarlo con el Container Registrie
  * En advanced se ve el nombre del RG que crea donde Kubernetes administra todo


* Creamos el archivo Services.yml

```
apiVersion: v1
kind: Service
metadata:
  name: express-minimal-service
  labels:
    app: express-minimal
spec:
  selector:
    app: express-minimal
  ports:
  - port: 80
    targetPort: 3000
  type: LoadBalancer
```

* Creamos el archivo Deployment.yml


```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: express-minimal
  labels:
    app: express-minimal
spec:
  replicas: 2
  selector:
    matchLabels:
      app: express-minimal
  template:
    metadata:
      labels:
        app: express-minimal
    spec:
      containers:
      - name: express-minimal
        image: <url-acr>:<nombre-imagen>:latest
        ports:
        - containerPort: 3000
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "100m"
```

* Loguearme en aks

```
 az aks get-credentials --resource-group rg-az104-clase-10  --name aks4trainner                     
```

* Desplegamos la app

```
kubectl apply -f ./Deployment.yaml
kubectl apply -f ./Service.yaml
```

* Desplegar el recurso y probarlo a partir de la IP publica del container app

----

# Monitoring en Azure

* Logs del Recurso de Azure
  * Activity Logs
    * Tiempo de Retencion 90 dias
  * Log Analitics Workspace
    * Base de datos de Logging Persistente
  * Application Insights
    * Es un log (Que graba sobre log analitics workspace) y tiene una vista e interfaz perticular para grabar logs desde apps
    * Es un servicio para el desarrollador
* Logs del Entra
  * Sign-In Logs
  * Audit Logs


* Monitor
  * Es el recurso de Azure que pemite recopiar, analizar y vislaizar metricas
  * El el monitor se pueden consultar tambien los Log anatics Workspace y activity Logs
  * Los logs se peuden consultar mediante un lenguaje que se llama KQL
 
* Defender
  * Defender for Cloud
   * Es un recurso pago que:
     * Genera sugerencias de seguridad
     * Va generando logs adicionales de seguridad

* Metricas y Alertas
  * Sobre los logs podemos configurar altertas que periodicamente consultan estos logs y disparan una notificacion o una automatizacion
