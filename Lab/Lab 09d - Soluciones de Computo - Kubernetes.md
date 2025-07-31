# Kubernetes

## Pasos 

1. Crear el resource group
   
```bash
az group create --name <nombre-resource-group> --location westus 
```
   
2. Crear Container Registry desde el portal

3. Crear una app en Nodejs

Primero crear un archivo
```cmd
touch server.js
```

Desde el cli crear este archivo server.js
```javascript
   // app.js
   const express = require('express');
   
   const app = express();
   const PORT = 3000;
   
   app.get('/', (req, res) => {
     res.send('Hola mundo');
   });
   
   app.listen(PORT, () => {
     console.log(`Servidor en http://localhost:${PORT}`);
   });
```
    
Instalar las dependencias por cli 
```bash
npm init -y
npm install express 
```

4.Crear el Dockerfile

Primero crear un archivo
```cmd
touch Dockerfile
```

El contenido es:
```Dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package.json .
RUN npm install

COPY server.js .

EXPOSE 3000

CMD ["npm", "start"]
```

5. Subir la imagen al contenedor

```bash
az acr login --name <nombre-acr> --expose-token
az acr build --registry ac4raz104clase07 --image app-minimalista .
```

6. Verificar que la imagen se subio al contenedor

> Verlo en el portal
   
o...
   
```bash
az acr repository list --name  ac4raz104clase07
```

7. Crear el recurso de Kubernetes desde el portal

> Lo hacemos todo desde el portal. Utilizar DS2_v2 para el nodo

8. Conectar aks con acr (No deja desde el portal)
   
```bash
az aks update -n <cluster-aks> -g <grupo-de-recursos> --attach-acr <nombre-acr>
```
   
9. Crear los manifiestos de Kubernetes

**Service.yaml**
```yaml
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

**Deployment.yaml**    
Reemplazar
* <url-acr> por la URL de nuestro Azure Container Registry
* <nombre-imagen> por el nombre de la imagen que subimos al Container Registry
```yaml
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

10. Loguearnos en kubernetes

```bash
az aks get-credentials --resource-group <nombre-resource-group>  --name <nombre-cluster-kubernetes>
```

11. Hacer el deployment

```bash
kubectl apply -f ./Deployment.yaml
kubectl apply -f ./Service.yaml
```

12. Probar el deployment

Listar serviccios de Kubernetes
```
kubectl get service
```
Copiamos la IP publica y la probamos en el navegador   

**Comandos Extras**    
Para ver los pods corriendo
```bash
kubectl get pods
```

Para ver que esta pasando en los pods (especie de logs)
```bash
kubectl describe pods  
```



