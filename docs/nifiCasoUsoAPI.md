## Caso de uso con API

**Consulta de una API con NiFi**

En la práctica anterior sobre la API del INE, consultamos la encuesta de población activa. Vamos a continuar con esta práctica leyendo los datos con NiFi.

Recordemos que es necesario averiguar el código para realizar esta consulta, que nos devolverá un JSON:  

[http://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/<cod serie>?nult=<num dades>](http://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/<cod serie>?nult=<num dades>)

**Ejercicio:**

1. Crea un pipeline que tome el JSON y lo guarde en un archivo en el sistema.

2. Haz que el pipeline aplane el JSON y lo guarde como un archivo CSV.

3. Configura el pipeline para tomar el JSON aplanado y guardarlo en una base de datos PostgreSQL.

4. Guarda este pipeline como una plantilla (template) para utilizarlo en futuros proyectos.