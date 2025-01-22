# Caso de uso metereológico
## Enunciado
La web el-tiempo.net tiene un API desde el la podemos consultar información meteorológica, tanto datos en tiempo real como previsiones.

Por ejemplo, para acceder a la predicción meteorológica de Xàtiva lo accedemos a través de la URL: 

- [El tiempo](https://www.el-tiempo.net/api/json/v2/provincias/46/municipios/46145)

En nuestro caso, nos piden que guardemos un histórico de varios datos en intervalos de X minutos (para que sea más vivo lo haremos de 1 minuto). 

Los datos que nos piden guardar son los siguientes:

-   Temperatura

-   Humedad

-   Precipitación

-   Viento

En concreto, nos piden que en cada minuto almacenemos valor mínimo y máximo de cada uno de estos valores salvo sobre precipitaciones que guardemos las precipitaciones del intervalo de tiempo y el total del día (último valor recibido). Esto lo realizaremos recogiendo datos cada X tiempo, que en nuestro caso puede ser cada 5 segundos, de forma que al final nos encontramos en que vamos recibiendo datos y agrupamos varios de ellos para obtener datos a partir de operaciones como media, máximo y mínimo.

Así pues, cada 5 segundos accederemos a la API, descargaremos los datos, y cada minuto (12 descargas) calcularemos valores medios, mínimos y máximos y los guardaremos en una tabla en PostgresSQL. 
 
Lo que pretendemos demostrar es que con Apache Nifi, podemos realizar cálculos a partir de un flujo de datos constantes, para obtener un provecho concreto de alguno de los datos obtenidos.

## Ejercicio
Los pasos que vamos a seguir deberían ser mas o menos los siguientes

1.	Obtenemos los datos del API
2.	Nos quedamos con los 4 datos que nos interesa.
3.	Agrupamos estos datos las X veces preestablecidas
4.	Realizamos los cálculos de los nuevos campos derivados planteados
5.	Almacenamos datos en la base de datos

Para todo este proceso los **Processors** que vamos a necesitar son: 

- **InvokeHTTP**:
   - **URL:** La URL de la API proporcionada:  
     `https://www.el-tiempo.net/api/json/v2/provincias/46/municipios/46145`
   - **Método HTTP:** `GET`

-   **JoltTransformJSON**: Este procesador se utiliza para transformar un archivo JSON utilizando una especificación Jolt.  Nos quedamos solo con los 4 campos indicados del JSONobtenido.
-   **MergeContent**: Nos permite agrupar una cantidad determinada de elementos en uno solo, o sea X JSON en uno único.
-   **ExecuteScript**: Permite ejecución de Scripts. Vamos a utilizar un Script para realizar los cálculos.
-   **PutDatabaseRecord**: Permite leer el JSON con los datos calculados e insertarlo directamente en PostgreSQL

Por último, ya que estamos, metemos en una collection de **MongoDB** todos los datos que obtenemos de el-tiempo.net.

## Ayuda
Para la creación de la tabla en PostgreSQL

```sql
CREATE TABLE datos_meteo_xativa (
    id SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    media_temperatura DOUBLE PRECISION,
    minima_temperatura DOUBLE PRECISION,
    maxima_temperatura DOUBLE PRECISION,
    cantidad_precipitaciones DOUBLE PRECISION,
    acumulado_precipitaciones DOUBLE PRECISION,
    media_humedad DOUBLE PRECISION,
    minima_humedad DOUBLE PRECISION,
    maxima_humedad DOUBLE PRECISION,
    media_viento DOUBLE PRECISION,
    minima_viento DOUBLE PRECISION,
    maxima_viento DOUBLE PRECISION
);
```

El código del script a utilizar (Groovy) es el siguiente: 

Completa la parte centrar marcada e intenta comprender qué hace sl script.

``` console
import org.apache.commons.io.IOUtils
import java.nio.charset.StandardCharsets
import groovy.json.JsonSlurper
import groovy.json.JsonOutput
 
def flowFile = session.get()
if (flowFile != null) {
    flowFile = session.write(flowFile, { inputStream, outputStream ->
        def text = IOUtils.toString(inputStream, StandardCharsets.UTF_8)
        def jsonSlurper = new JsonSlurper()
        
        // Separar los objetos JSON concatenados
        def data = text.split('(?<=})\\s*(?=\\{)').collect { jsonSlurper.parseText(it) }
 
        def temperaturas = data.collect { it.temperatura_actual.toDouble() }
        def precipitaciones = data.collect { it.precipitacion.toDouble() }
        def humedades = data.collect { it.humedad.toDouble() }
        def vientos = data.collect { it.viento.toDouble() }
 
        def resultado = [
            media_temperatura: temperaturas.sum() / temperaturas.size(),
            maxima_temperatura: temperaturas.max(),
            minima_temperatura: temperaturas.min(),
            cantidad_precipitaciones: precipitaciones.last() - precipitaciones.first(),
            ------------------------------------------------
            Completa el script aquí
            ------------------------------------------------  
            minima_viento: vientos.min()
        ]
 
        outputStream.write(JsonOutput.toJson(resultado).getBytes(StandardCharsets.UTF_8))
    } as StreamCallback)
    session.transfer(flowFile, REL_SUCCESS)
}
```

## Entregable

Realiza un documento PDF con las capturas necesarias para demostrar que el sistema funciona correctamente y entrégalo junto con el Flow Definition.