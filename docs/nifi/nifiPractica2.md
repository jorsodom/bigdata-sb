## Atributos y contenido

Generaremos primero un fichero aleatorio o con contenido personalizado, le aplicaremos 
alguna transformación y luego alteraremos en este sus propiedades. También veremos por los diferentes estados que pasa la ejecución y cómo ver en cada punto como va evolucionando el 
proceso.

Una vez hayamos hecho login, nos aparecerá la interfaz de trabajo

<div align="center">
<img src="../../img/NiFiP2.1.png" alt="Práctica 2" 
width="80%" />
</div>

En la barra de iconos de herramientas, hacemos clic en “*Processor*” y arrastramos 
hacia el área de trabajo.

<div align="center">
<img src="../../img/NiFiP2.2.png" alt="Práctica 2" 
width="80%" />
</div>

En la ventana de “*Add Processor*” búscamos “*GenerateFlowFile*”. Y hacemos clic en 
“*Add*”.

*Nota*: Este processor crea FlowFiles con datos aleatorios o contenido personalizado

<div align="center">
<img src="../../img/NiFiP2.3.png" alt="Práctica 2" 
width="80%" />
</div>

Ahora, vamos a configurarlo con datos aleatorios conforme la siguiente imagen. Y 
planificarlo.

<div align="center">
<img src="../../img/NiFiP2.4.png" alt="Práctica 2" 
width="80%" />
</div>

<div align="center">
<img src="../../img/NiFiP2.5.png" alt="Práctica 2" 
width="80%" />
</div>

Ahora vamos a añadir a la hoja de trabajo, otro processor llamado “*Replace Text 
Processor*”

*Nota*: bajo cada processor encontraremos una breve descripción de la funcionalidad

<div align="center">
<img src="../../img/NiFiP2.6.png" alt="Práctica 2" 
width="80%" />
</div>

Establecemos la conexión entre los dos processor antes de configurar el ReplaceText.

<div align="center">
<img src="../../img/NiFiP2.7.png" alt="Práctica 2" 
width="80%" />
</div>

Le dedicamos unos minutos a entender el processor “*ReplaceText*” que propiedades 
nos aporta. 
*Nota*: Es recomendable revisar siempre antes de usar las propiedades disponibles y si 
es necesario, realizar alguna pequeña prueba.

<div align="center">
<img src="../../img/NiFiP2.8.png" alt="Práctica 2" 
width="80%" />
</div>

Queremos remplazar en el contenido del fichero generado por unos valores separados 
por comas. Y guardamos

<div align="center">
<img src="../../img/NiFiP2.9.png" alt="Práctica 2" 
width="80%" />
</div>

Para visualizar que es lo que pasa, vamos a añadir un processor “*log attribute*” y 
conectarlo sobre el processor “*ReplaceText*”. En esta conexión, debemos activar la 
casilla “*success*”.

<div align="center">
<img src="../../img/NiFiP2.10.png" alt="Práctica 2" 
width="80%" />
</div>

Vamos a probar la generación del fichero y transformación de este. Le damos a “*Start*” con botón derecho sobre el processor “*GenerateFlowFile*”. Veremos que genera un fichero en la cola. Una vez lo genere, vamos a pararlo de la misma manera con la acción “*Stop*”. Ya que, si recordamos, lo hemos planificado para que se ejecute cada 5 segundos. Si no, estará generando cada 5 segundos un nuevo fichero.

<div align="center">
<img src="../../img/NiFiP2.11.png" alt="Práctica 2" 
width="80%" />
</div>

En la cola, podemos validar el contenido generado, con botón derecho, “*List queue*”. Si damos al primer botón (columna), podremos ver/descargar el fichero generado.

<div align="center">
<img src="../../img/NiFiP2.12.png" alt="Práctica 2" 
width="80%" />
</div>

Si el processor os pone una alerta y no os deja arrancarlo. Es debido a que necesita 
que especifiquemos que hacer cuando falle. Cuando tenga éxito ira al processor 
conectado, pero cuando falle, que acción debe hacer. Vamos a propiedades, a 
relaciones y ahí lo podemos configurar

<div align="center">
<img src="../../img/NiFiP2.13.png" alt="Práctica 2" 
width="80%" />
</div>

Ahora ya le podemos dar la acción “Start” y ver que hace el “ReplaceText” que le 
hemos indicado al fichero de la cola. Podemos ir a la cola y validar que los ficheros se han convertido conforme lo esperado.

<div align="center">
<img src="../../img/NiFiP2.14.png" alt="Práctica 2" 
width="80%" />
</div>

<div align="center">
<img src="../../img/NiFiP2.15.png" alt="Práctica 2" 
width="80%" />
</div>

Ahora vamos a añadir el processor “*ExtractText*” y en propiedades de este 
configuramos una nueva propiedad “*csv*” con una expresión regular “*(.+),(.+),(.+),(.+)*” de la siguiente manera:

<div align="center">
<img src="../../img/NiFiP2.16.png" alt="Práctica 2" 
width="80%" />
</div>

Ahora conectamos el “*ReplaceText*” con “*ExtractText*” eliminando la anterior relación con “*LogAttribute*”. Y luego, conectamos “*ExtractText*” con “*LogAttribute*”. En la definición de la relación, se ha de marcar el check “matched”. Como veis, el processor ExtractText tiene una alerta amarilla, quiere decir que no está del todo bien configurado. Pasa lo mismo que antes, es necesario añadir cuando la acción contraria a “match” que tiene que hacer. Vamos a propiedades de “*ExtractText*”, a “*Relationships*” y marcamos la acción “*terminate*”.

<div align="center">
<img src="../../img/NiFiP2.17.png" alt="Práctica 2" 
width="80%" />
</div>

<div align="center">
<img src="../../img/NiFiP2.18.png" alt="Práctica 2" 
width="80%" />
</div>

Llegado a este punto, le damos a la acción “*start*” del processor “*ExtractText*” y vemos como procesa el fichero con una salida en la cola. Podemos ver el resultado en la cola de nuevo como ha generado nuevos atributos según la expresión regular que le hemos aplicado, ya que el contenido en este caso no se ha visto modificado.

<div align="center">
<img src="../../img/NiFiP2.19.png" alt="Práctica 2" 
width="80%" />
</div>

## ENTREGABLE 

Hay que exportar la practica con un Processor Group que genera un .json y entregarlo en Aules con el número de la práctica y el nombreApellidos. Por ejemplo:  *P2_NomAlumnoApellidos.xml*