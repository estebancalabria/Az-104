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
```


