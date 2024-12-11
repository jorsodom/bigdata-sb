# NiFi Prácticas

<img src="https://nifi.apache.org/images/apache-nifi-drop-logo.svg" alt="NiFi" style="width:100px;height:100px;" >

## Práctica 1: Mover un fichero de un origen a un destino

**Iniciamos** NiFi. Ejecutamos:

        ./bin/nifi.sh start (Unix)
        ./bin/nifi.bat start (MSDOS)

**Accedemos** a la siguiente url que se levantará en el ordenador (*o la que indica el 
Readme, según la versión funcionara una u otra*): 

[https://localhost:8443/nifi/](https://localhost:8443/nifi/)

![NiFi](img/NiFiP1.1.png)  

**Pedirá unas credenciales**. Podemos utilizar las creadas de manera automática 
al arrancar por primera vez en el fichero de logs que podréis encontrar en: *logs/nifiapp.log*. Lo encontrareis buscando la siguiente palabra clave: *Username*

Una vez hayamos hecho login, nos aparecerá la interfaz de trabajo.

![NiFi](img/NiFiP1.2.png)  

En la **barra de iconos de herramientas**, hacemos clic en “*Processor*” y arrastramos 
hacia el área de trabajo

![NiFi](img/NiFiP1.3.png) 

En la ventana de “*Add Processor*” búscamos *getFile*. Y hacemos clic en “*Add*”.

![NiFi](img/NiFiP1.4.png) 

Repetimos el mismo proceso para añadir el processor “*putFile*”. Quedando algo similar 
a la siguiente imagen.

![NiFi](img/NiFiP1.5.png) 

Ahora, vamos a **configurar** de dónde vamos a coger el fichero *origen* y dónde lo vamos 
a dejar en el *destino*. 

**Hacemos clic** botón derecho en “*GetFile*” en “*Configure*” y vamos a la pestaña 
“*Properties*”. Dónde podemos ver los diferentes aspectos que son configurables. 
Ahora mismo sólo vamos a indicar el directorio de entrada “*Input Directory*”.

![NiFi](img/NiFiP1.6.png) 

Hacemos clic botón derecho en “*PutFile*” en “*Configure*” y vamos a la pestaña 
“*Properties*”. Dónde podemos ver los diferentes aspectos que son configurables. 
Ahora mismo sólo vamos a indicar el directorio de entrada “*Directory*”.

![NiFi](img/NiFiP1.7.png) 

Ya configurado el componente del origen de los ficheros y el destino, sólo nos queda 
unirlos. Si hacemos clic sobre el componente “*GetFile*” veremos una flecha que nos 
permitirá arrastrarla hasta el otro componente “*PutFile*”. Quedando como la siguiente 
imagen:

![NiFi](img/NiFiP1.8.png) 

Ahora nos queda probar que traslada correctamente los ficheros, arrancando los dos 
componentes con botón derecho y hacer clic en “*Start*”. En los dos componentes. 
Primero el “*GetFile*” y luego el “*PutFile*”.

![NiFi](img/NiFiP1.9.png) 

Si al realizar la acción no sale la opción en el “*PutFile*” lo que hay que hacer es entrar 
en este componente en propiedades e indicarle que acción debe hacer en el caso de 
que falle

![NiFi](img/NiFiP1.10.png) 

Una vez todo configurado y en estado “*Start*” veréis que empieza a mover el fichero 
del origen configurado al destino. Marcado con verde como que se ha ejecutado 
correctamente

![NiFi](img/NiFiP1.11.png) 

**ENTREGABLE:** Hay que exportar la practica con un Processor Group que genera un .json y entregarlo en Aules con el número de la práctica y el nombreApellidos. Por ejemplo:  *P1_NomAlumnoApellidos.xml*

## Práctica 2: Atributos y contenido

Generaremos primero un fichero aleatorio o con contenido personalizado, le aplicaremos 
alguna transformación y luego alteraremos en este sus propiedades. También veremos por los 
diferentes estados que pasa la ejecución y cómo ver en cada punto como va evolucionando el 
proceso.

Una vez hayamos hecho login, nos aparecerá la interfaz de trabajo

![NiFi](img/NiFiP2.1.png) 

En la barra de iconos de herramientas, hacemos clic en “*Processor*” y arrastramos 
hacia el área de trabajo.

![NiFi](img/NiFiP2.2.png) 

En la ventana de “*Add Processor*” búscamos “*GenerateFlowFile*”. Y hacemos clic en 
“*Add*”.

Nota: Este processor crea FlowFiles con datos aleatorios o contenido personalizado

![NiFi](img/NiFiP2.3.png) 

Ahora, vamos a configurarlo con datos aleatorios conforme la siguiente imagen. Y 
planificarlo.

![NiFi](img/NiFiP2.4.png) 

![NiFi](img/NiFiP2.5.png) 

Ahora vamos a añadir a la hoja de trabajo, otro processor llamado “*Replace Text 
Processor*”

Nota: bajo cada processor encontraremos una breve descripción de la funcionalidad

![NiFi](img/NiFiP2.6.png) 

Establecemos la conexión entre los dos processor antes de configurar el ReplaceText.

![NiFi](img/NiFiP2.7.png) 

Le dedicamos unos minutos a entender el processor “*ReplaceText*” que propiedades 
nos aporta. 
Nota: Es recomendable revisar siempre antes de usar las propiedades disponibles y si 
es necesario, realizar alguna pequeña prueba.

![NiFi](img/NiFiP2.8.png) 

Queremos remplazar en el contenido del fichero generado por unos valores separados 
por comas. Y guardamos


![NiFi](img/NiFiP2.9.png) 

Para visualizar que es lo que pasa, vamos a añadir un processor “*log attribute*” y 
conectarlo sobre el processor “*ReplaceText*”. En esta conexión, debemos activar la 
casilla “*success*”.

![NiFi](img/NiFiP2.10.png) 

Vamos a probar la generación del fichero y transformación de este. Le damos a “*Start*” 
con botón derecho sobre el processor “*GenerateFlowFile*”. Veremos que genera un 
fichero en la cola. Una vez lo genere, vamos a pararlo de la misma manera con la 
acción “*Stop*”. Ya que, si recordamos, lo hemos planificado para que se ejecute cada 5 
segundos. Si no, estará generando cada 5 segundos un nuevo fichero.

![NiFi](img/NiFiP2.11.png) 

En la cola, podemos validar el contenido generado, con botón derecho, “*List queue*”. Si 
damos al primer botón (columna), podremos ver/descargar el fichero generado.


![NiFi](img/NiFiP2.12.png) 

Si el processor os pone una alerta y no os deja arrancarlo. Es debido a que necesita 
que especifiquemos que hacer cuando falle. Cuando tenga éxito ira al processor 
conectado, pero cuando falle, que acción debe hacer. Vamos a propiedades, a 
relaciones y ahí lo podemos configurar

![NiFi](img/NiFiP2.13.png) 

Ahora ya le podemos dar la acción “Start” y ver que hace el “ReplaceText” que le 
hemos indicado al fichero de la cola. Podemos ir a la cola y validar que los ficheros se 
han convertido conforme lo esperado.


![NiFi](img/NiFiP2.14.png) 

![NiFi](img/NiFiP2.15.png) 

Ahora vamos a añadir el processor “*ExtractText*” y en propiedades de este 
configuramos una nueva propiedad “*csv*” con una expresión regular “*(.+),(.+),(.+),(.+)*” 
de la siguiente manera:

![NiFi](img/NiFiP2.16.png) 

Ahora conectamos el “*ReplaceText*” con “*ExtractText*” eliminando la anterior relación 
con “*LogAttribute*”. Y luego, conectamos “*ExtractText*” con “*LogAttribute*”. En la 
definición de la relación, se ha de marcar el check “matched”. Como veis, el processor 
ExtractText tiene una alerta amarilla, quiere decir que no está del todo bien 
configurado. Pasa lo mismo que antes, es necesario añadir cuando la acción contraria a 
“match” que tiene que hacer. 
Vamos a propiedades de “*ExtractText*”, a “*Relationships*” y marcamos la acción 
“*terminate*”.

![NiFi](img/NiFiP2.17.png) 

![NiFi](img/NiFiP2.18.png) 

Llegado a este punto, le damos a la acción “*start*” del processor “*ExtractText*” y vemos 
como procesa el fichero con una salida en la cola. Podemos ver el resultado en la cola 
de nuevo como ha generado nuevos atributos según la expresión regular que le hemos 
aplicado, ya que el contenido en este caso no se ha visto modificado.

![NiFi](img/NiFiP2.19.png) 


**ENTREGABLE:** Hay que exportar la practica con un Processor Group que genera un .json y entregarlo en Aules con el número de la práctica y el nombreApellidos. Por ejemplo:  *P2_NomAlumnoApellidos.xml*


## Práctica 3: Expression Language

Partimos del resultado de la anterior practica 2, trabajando con atributos y contenido dónde 
generaremos primero un fichero aleatorio o con contenido personalizado, le aplicaremos 
alguna transformación y luego alteraremos en este sus propiedades. También veremos por los 
diferentes estados que pasa la ejecución y cómo ver en cada punto como va evolucionando el 
proceso.

El objetivo de esta práctica es modificar la solución de la practica 2, añadiendo un paso más al 
final, dónde utilizando Expression Language NiFi extraeremos información de los atributos de 
FlowFile que hemos creado para introducirlas en el contenido en formato JSON. Teniendo 
como resultado algo similar:

        
        {
        "field1": "a",
        "field1": "b",
        "field1": "c",
        "field1": "d"
        }


![NiFi](img/NiFiP3.1.png) 


Añadimos un nuevo ReplaceText mediante el botón de Processor o duplicamos el que 
ya teníamos configurado para tener la misma configuración. Y lo conectamos entre el 
Processor “ExtractText” y terminando en el “LogAttribute”

![NiFi](img/NiFiP3.2.png) 

 Una vez en este punto, nos queda configurar el “ReplaceText” añadido o duplicado, 
con la misma configuración que el primero, pero con la diferencia que en la propiedad 
“ReplacementValue” introducimos con Expression Language NiFi de dónde va a 
obtener los datos y que estructura va a tener para substituir el anterior contenido con 
el nuevo. El código es el siguiente, dónde referenciamos con el carácter “$” que es una 
propiedad del FlowFile.

        {
        "field1": "${csv.1}",
        "field1": "${csv.2}",
        "field1": "${csv.3}",
        "field1": "${csv.4}"
        }

![NiFi](img/NiFiP3.3.png) 

Ejecutamos y podemos ver en la cola el resultado del contenido, si ha funcionado 
correctamente debe salir algo similar a la siguiente imagen:

![NiFi](img/NiFiP3.4.png) 

*Nota: El Expression Language NiFi es muy útil y existen muchas funciones que es posible 
utilizarlas. Para ello recomendamos visitar la siguiente documentación y dedicarle unos 
minutos: Apache NiFi Expression Language Guide*

Ahora vamos a continuar con el dataflow que hemos creado.
Si vamos a la cola final, y vemos los ficheros sus propiedades podemos ver que existen 
las propiedades de UID y Filename, que son valores únicos. Estos identifican de forma 
única el fichero dentro del dataflow y es posible utilizarlos para referenciar el FlowFile.
Por ejemplo, vamos a añadir un Processor “PutFile” y lo conectaremos entre el último 
replaceText y el log. Luego entraremos en las propiedades del PutFile y 
configuraremos el directorio dónde quedamos que se guarde el fichero.

![NiFi](img/NiFiP3.5.png) 

![NiFi](img/NiFiP3.6.png) 

Arrancamos todos los procesos para generar un fichero y que llegue hasta la cola del 
log y veamos que pasa en el directorio. Confirmamos que el nombre del fichero lo coge 
de la propiedad de Filename del FlowFile.

![NiFi](img/NiFiP3.7.png) 

Vamos a añadir un Processor para actualizar el atributo y poner un nombre a los 
ficheros de salida (en la propiedad). El Processor a añadir es “*UpdateAttribute*”. Y 
vamos a propiedades y añadimos una nueva “*Filename*”. Y introducimos el valor 
siguiente:

        ${filename}-${now():toNumber():format('dd-MM-yy')}.json

![NiFi](img/NiFiP3.8.png) 

Ya solo quedaría conectar el Processor antes del PutFile para que le dé tiempo a 
cambiarle la propiedad. Y volvamos a revisar la salida a ver qué pasa.

![NiFi](img/NiFiP3.9.png) 

Hagamos como ejercicio, que el fichero de salida salga con el siguiente formato dónde 
lo siguiente a la fecha son horas, minutos y segundos:

![NiFi](img/NiFiP3.10.png)

**ENTREGABLE:** Hay que exportar la practica con un Processor Group que genera un .json y entregarlo en Aules con el número de la práctica y el nombreApellidos. Por ejemplo:  *P3_NomAlumnoApellidos.xml*

## Práctica 4: Process group, Input-Output port
En NiFi uno o más processor son conectados en un process group. Podemos añadir un 
process group arrastrando el icono de la barra de herramientas .
Partiendo de la practica 3. Cogemos y añadimos un nuevo process group y le ponemos 
como nombre “CSV to JSON”.
Para decirle como usar los processor’s, debemos seleccionar todos los processor (con 
la tecla shift) y arrastrarlos sobre el process group

![NiFi](img/NiFiP4.1.png) 

Para ver los componentes de un Process Group, hacemos doble click y accedemos al 
detalle. 

![NiFi](img/NiFiP4.2.png) 

Para salir fuera del detalle, con botón derecho “*leave group*” saldremos de nuevo 
fuera.

*Nota: Es recomendable utilizar los Process Group para lógicas complejas. Es posible duplicar un 
process group heredando la misma configuración.*

![NiFi](img/NiFiP4.3.png) 

A veces, un Process Group puede generar una salida para utilizar en otros procesos. 
Vamos a transferir información des de un Process Group a otro. Para ello vamos a 
utilizar de la barra de herramientas el “*input*” y el “*output*” port .
El actual flujo de datos, lo vamos a partir en dos Process Group de la siguiente manera:
Creamos un nuevo Process Group que se llame “*Write JSON to File System*” dónde 
vamos a introduir los processors des de el “*UpdateAttribute*” hasta el último 
“*LogAttribute*”.

![NiFi](img/NiFiP4.4.png) 

Cómo ya tenemos un process group principal “*CSV to JSON*”, vamos a sacar el 
process group “*Write JSON to File System*” fuera para poder ejecutarlos 
conjuntamente. Para ello hacemos botón derecho sobre “*Write JSON to File 
System*” y seleccionamos “*Move to parent group*”.

![NiFi](img/NiFiP4.5.png) 

Ahora el problema está en que los dos processor group es necesario que se 
comuniquen para que funcionen. Para ello haremos uso del Input/Output port.
Accedemos al process group “*CSV to JSON*” y añadimos un “*Output port*”.

![NiFi](img/NiFiP4.6.png) 

Salimos del grupo y accedemos ahora al Process Group “*Write JSON to CSV*” y 
añadimos un “*Input port*” al inicio

![NiFi](img/NiFiP4.7.png) 

Salimos al flujo principal, dónde ahora vamos a conectar los dos Process Group. Saldrá 
el mapeo de entradas y salidas, hay que tenerlo en cuenta cuando tengamos más de 
una entrada/salida que este bien asociado.
Ahora solo queda arrancar con botón derecho “*start*” y validar que todo funciona 
correctamente.

*Nota: Dentro de un mismo Process Group no es posible conectar un “*Output port*” a un “*Input 
port*”.*

**ENTREGABLE:** Hay que exportar la practica con un Processor Group que genera un .json y entregarlo en Aules con el número de la práctica y el nombreApellidos. Por ejemplo:  *P4_NomAlumnoApellidos.xml*

## Práctica 5: Templates

Para guardar el trabajo realizado, exportarlo, etc usaremos los “Templates”.
Para ello debemos seleccionar todos los componentes a guardar en el template, y 
buscar el icono crear template que encontrareis en la izquierda.

![NiFi](img/NiFiP5.1.png) 

Le pondremos por ejemplo “*CSV to JSON*” y lo creamos.

![NiFi](img/NiFiP5.2.png) 

Hacemos click en “*Create*”.

![NiFi](img/NiFiP5.3.png) 

Este template se almacena en la instancia local.
Si queremos ver todos los templates que tenemos creados en nuestra instancia local, 
tenemos que ir al botón de la derecha arriba y hacer clic en “*Templates*” dónde 
saldrá un listado. Dónde a la derecha aparece los botones para descargarlos para 
una futura importación o copia de seguridad.

![NiFi](img/NiFiP5.4.png) 

*Nota: Existen templates de ejemplo que podemos descargar e importar a nuestra instancia
local para practicar o utilizar para un desarrollo. Lo podéis encontrar en el siguiente enlace: 
https://cwiki.apache.org/confluence/display/nifi/example+dataflow+templates*

Vamos a acceder a la anterior página web y descargar un template. Por ejemplo, el 
“*Retry Count Loop*”.
Nos quedaría ahora importarlo a nuestro entorno de desarrollo. Accedemos al botón 
“*Upload Template*” y seleccionamos el fichero descargado “Retry_Count_Loop.xml” a 
través del icono .
Ahora para utilizarlo o revisar, sólo debemos ir a la barra de herramientas y 
seleccionar “*Add Template*” y arrastrar al espacio de trabajo. Seleccionamos el 
template descargado y veréis que aparece un nuevo Process Group.

![NiFi](img/NiFiP5.5.png) 

El cual, si hacemos doble clic, nos aparecerán todos los processor que tiene este 
Process Group. 

**ENTREGABLE:** Hay que exportar la practica con un Processor Group que genera un .json y entregarlo en Aules con el número de la práctica y el nombreApellidos. Por ejemplo:  *P5_NomAlumnoApellidos.xml*

![NiFi](img/NiFiP5.6.png) 

## Práctica 6: Funnel

Combinar datos de varias conexiones en una sola
Vamos a revisarlo de forma rápida, se trata de como coger varias fuentes de datos y 
pasarlas por un solo componente para llegar a otro componente.
Añadimos dos processor “*GenerateFlowFile*” a una nueva hoja de trabajo.
Añadimos un “*Funnel*” des de la barra de herramientas
Añadimos un processor “*LogAttribute*”
Enlazamos los dos processor “*GenerateFlowFile*” al “*Funnel*”
Y el “*Funnel*” lo enlazamos con el ”*LogAttribute*”

![NiFi](img/NiFiP6.1.png) 


**ENTREGABLE:** Hay que exportar la practica con un Processor Group que genera un .json y entregarlo en Aules con el número de la práctica y el nombreApellidos. Por ejemplo:  *P6_NomAlumnoApellidos.xml*