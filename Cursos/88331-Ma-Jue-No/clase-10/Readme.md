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

