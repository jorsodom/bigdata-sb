### Consulta de una API con NiFi
En la práctica que hicimos sobre la API del INE, consultamos la encuesta de población activa. Vamos a ampliar con esta práctica leyendo y automatizando la lectura de los datos con NiFi.

## Consulta de la API y guardar el JSON en un archivo
**Processor a usar:** `InvokeHTTP`  
**Objetivo:** Consultar la API del INE para obtener los datos en formato JSON y luego guardarlos en un archivo local.

**Configurar `InvokeHTTP`**:
    - **URL:** `http://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/<cod serie>?nult=<num dades>`
    - **Método HTTP:** `GET`
    - **Propiedades adicionales:**  Asegúrate de que se ha configurado correctamente el manejo de errores (por ejemplo, reintentos y tiempo de espera).

**Guardar el JSON en un archivo con `PutFile`**:
    - **Directorio de destino:** Elige la carpeta donde deseas almacenar los archivos JSON.
    - **Nombre del archivo:** Puede ser dinámico o fijo (por ejemplo, `datos.json`).

Este paso recogerá la respuesta de la API y la almacenará como un archivo JSON en el sistema de archivos.

## Aplanar el JSON y guardarlo como CSV
**Processor a usar:** `JoltTransformJSON` y `ConvertRecord`

**Aplanar el JSON con `JoltTransformJSON`**:
    - **Objetivo:** El JSON puede estar anidado y necesitamos aplanarlo para poder convertirlo a CSV.
    - **Jolt Specification:** Deberás crear una especificación Jolt que transforme el JSON en una estructura plana. Un ejemplo básico de Jolt podría ser:
     ```json
     [
       {
         "operation": "shift",
         "spec": {
           "data": {
             "*": {
               "value": "data[].value",
               "date": "data[].date"
             }
           }
         }
       }
     ]
     ```
  '''note "Nota"
    Extrae los datos necesarios del JSON y los coloca en un formato más adecuado para la conversión.

**Convertir el JSON a CSV con `ConvertRecord`**:
    - **Record Reader:** `JsonTreeReader` (configurado para leer JSON).
    - **Record Writer:** `CSVRecordSetWriter` (configurado para generar archivos CSV).
    - Este paso toma los datos JSON aplanados y los convierte en un formato CSV.

**Guardar el archivo CSV con `PutFile`**:
    - Similar al paso anterior, puedes guardar el archivo CSV en el sistema de archivos local.

## Guardar los datos en una base de datos PostgreSQL
**Processor a usar:** `PutDatabaseRecord`

**Configurar `PutDatabaseRecord`**:
    - **JDBC Connection Pooling Service**: Debes configurar un servicio de conexión JDBC, como `DBCPConnectionPool`, para conectarte a tu base de datos PostgreSQL.
    - **Configuración de la base de datos PostgreSQL**:
        - **JDBC URL:** `jdbc:postgresql://<host>:<port>/<database>`
        - **Usuario:** El usuario para conectarse a la base de datos.
        - **Contraseña:** La contraseña correspondiente.
   
**Especificar el esquema de la base de datos**:
    - **Schema**: Define un esquema adecuado para insertar los datos del archivo CSV.
    - **Tabla**: Selecciona o crea una tabla en PostgreSQL para almacenar los datos. La estructura de la tabla debe coincidir con los datos CSV que estamos insertando.

**Configurar `PutDatabaseRecord`**:
    - **Record Reader:** `CSVReader` (configurado para leer los datos del archivo CSV).
    - **Record Writer:** No es necesario, ya que los datos se insertan directamente en la base de datos.
   
Este paso leerá los datos CSV y los insertará en la base de datos PostgreSQL.

## Entregable
**Guardar la plantilla**:

    - Después de configurar todos los processors, selecciona todos los processors y haz clic en el botón derecho para elegir la opción "Create Template".
    - Nombra tu plantilla (por ejemplo, "API_to_PostgreSQL_Template").
    - Guarda la plantilla y podrás reutilizarla en futuros proyectos.

## Resumen de los processors a utilizar
-   **`InvokeHTTP`**: Para consultar la API del INE y obtener el JSON.
-   **`JoltTransformJSON`**: Para aplanar el JSON.
-   **`ConvertRecord`**: Para convertir el JSON a CSV.
-   **`PutFile`**: Para guardar los archivos JSON y CSV en el sistema de archivos.
-   **`PutDatabaseRecord`**: Para insertar los datos en PostgreSQL.
-   **`DBCPConnectionPool`**: Para configurar la conexión JDBC a PostgreSQL.

## Anexos

[INE API](http://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/<cod serie>?nult=<num dades>)