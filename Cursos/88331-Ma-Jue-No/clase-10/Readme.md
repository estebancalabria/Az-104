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

* Desplegar el recurso y probarlo a partir de la IP publica del container app
