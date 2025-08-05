# Laboratorio Evet Grid

Primero ir a la opcion de Event Grid y explorar el Event Grid System Topic

1. Crear Resource Group
2. Crear Storage Account
3. Crear un queue dentro del stroage account
4. Crear un System Event Grid para el stroage account desde la opcion de Event Grid
          * Asegurarse que el system event grid tenga un Managed Identity
5. Opcional : Darle permisos al system event grid del stroage account para poder acceder al storage account
          * Esto se hace en la parte de "Access Control (IAM)" le vamos a dar el rol de contributor o uno menor
6. Crear una subcripcion que cuando pase eve to lo deje en la queue
7. Subir un blob al storage account
8. Fijarse que haya algo en la queue
9. Fijarse los graficos que se proceso el evento
