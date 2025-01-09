# Conectar Raspberry Pi a Azure IoT
## Objetivo
Vamos a conectar dispositivos a la nube sin ningún problema con Azure Centro IoT utilizando un simulador de Raspberry Pi.  

**¿Qué vamos a hacer?**  

- [x] Crear un Centro IoT.  
- [x] Registrar un nuevo dispositivo en el Centro IoT para conectarlo con la Raspberry Pi.  
- [x] Configurar el simulador Raspberry Pi.  
- [x] Ejecutar una aplicación de ejemplo en el simulador para enviar datos de un sensor al Centro IoT.  
- [x] Recopilar datos del sensor al ejecutar el simulador IoT.  
- [x] Conectar con una cuenta de almacenamiento (*Storage Account*), aplicaciones lógicas y envío de correos.  

<div align="center">
<img src="../../img/azurep1_1.png" alt="Azure p1" 
width="80%" />
</div>
La **práctica 1* se dividide en **3 partes**:

- [**P1.1.** Conectar Raspberry Pi a Azure Centro IoT](https://jorsodom.github.io/bigdata-sb/azure/AzurePractica1/#p11-conectar-raspberry-pi-a-azure-centro-iot)  

- [**P1.2.** Conectar Raspberry Pi a Azure Centro IoT y Enrutamiento a una Cuenta de Almacenamiento (Storage Account)](https://jorsodom.github.io/bigdata-sb/azure/AzurePractica1/#p12-conectar-raspberry-pi-a-azure-centro-iot-y-enrutamiento-a-una-cuenta-de-almacenamiento-storage-account)  

- [**P1.3.** Conectar Raspberry Pi a Azure Centro IoT y Enrutamiento a una Aplicación Lógica y envío de correos](https://jorsodom.github.io/bigdata-sb/azure/AzurePractica1/#p13-conectar-raspberry-pi-a-azure-centro-iot-y-enrutamiento-a-una-aplicacion-logica-y-envio-de-correos)  

## P1.1. Conectar Raspberry Pi a Azure Centro IoT
### Introducción
- [x] Crearemos un "Azure Centro IoT".  
- [x] Registraremos un dispositivo para Raspberry Pi en Azure Centro IoT.  
- [x] Configuraremos el simulador Raspberry Pi.  
- [x] Ejecutaremos una aplicación de ejemplo en la Raspberry Pi para enviar datos del sensor al Centro IoT Hub.  
### Crear centro IoT
-       Creamos un nuevo recurso ****Centro de IoT****.
<div align="center">
<img src="../../img/azurep1_5.png" alt="Azure p1" 
width="80%"/>
</div>
-       Como no tenemos un recurso creado, vamos a generarlo para asignar todo a este recurso y así después encontrarlo más fácilmente.  
<div align="center">
<img src="../../img/azurep1_6.png" alt="Azure p1" 
width="80%"/>
</div>
-       Rellenamos los campos: *Suscripción, Grupo de recursos, nombre de la instancia, región y Nivel*. Después seleccionamos “**Siguiente: Redes**”.  
<div align="center"><img src="../../img/azurep1_7.png" alt="Azure p1" width="80%"/></div>
-       Seleccionamos “*Acceso público*”.  
<div align="center"><img src="../../img/azurep1_8.png" alt="Azure p1" width="80%"/></div>
-       Seleccionamos “**Siguiente: Administración**”. Lo dejamos por defecto. No tocamos ningún parámetro.  
<div align="center"><img src="../../img/azurep1_9.png" alt="Azure p1" width="80%" />
</div>
-       Seleccionamos “**Siguiente: Etiquetas**”. No introducimos nada. O, si deseas etiquetar el recurso, introduce el Nombre / Valor para luego buscar el recurso a través de la etiqueta.  
-       Seleccionamos “**Siguiente: Revisar y crear**”. Revisamos que todo esté correcto.  
-       Llegados a este punto, ya podemos crear el recurso Centro de IoT. Hacemos clic en “**Create/Crear**”. Tardará un tiempo en implementarse el recurso. Mientras tanto, en el espacio de notificaciones podemos observar el progreso hasta que finalice.  
<div align="center"><img src="../../img/azurep1_10.png" alt="Azure p1" width="80%" /></div>
<div align="center"><img src="../../img/azurep1_11.png" alt="Azure p1" width="80%" /></div>

### Nuevo dispositivo IoT
-       En el menú de navegación del Centro de IoT, seleccionamos “**Dispositivos**” y luego seleccionamos “**Agregar dispositivo**”.  
<div align="center"><img src="../../img/azurep1_13.png" alt="Azure p1" width="80%" /></div>
-       En “**Crear un dispositivo**”, proporcionamos un nombre para el nuevo dispositivo, como por ejemplo: “*RaspberryInput*” y no es necesario modificar ningún otro parámetro.*Dejamos activada la opción “**Generar claves automáticamente**” para las claves primarias y secundarias, que se generan de forma automática.* Seleccionamos “**Guardar**”. Esta acción crea una nueva identidad del dispositivo para el Centro de IoT.
<div align="center"><img src="../../img/azurep1_14.png" alt="Azure p1" width="80%" /></div>
-       Después de crear el dispositivo, lo abrimos desde la lista del panel de *Dispositivos*.  
<div align="center"><img src="../../img/azurep1_15.png" alt="Azure p1" width="80%" /></div>
-       Copiamos la “**Cadena de conexión principal o String**” (*el código del dispositivo utiliza esta cadena de conexión para comunicarse con el Centro IoT*).  
<div align="center"><img src="../../img/azurep1_16.png" alt="Azure p1" width="80%" /></div>

!!! note "Nota"
      - De forma predeterminada, las claves y las cadenas de conexión están enmascaradas porque son información confidencial. Si se hace clic en el ícono del ojo, se muestran. No es necesario mostrarlas para copiarlas.

### Simulador
<div align="center">
<img src="../../img/azurep1_4.png" alt="Azure p1" 
width="80%" />
</div>
- **Enlace**: [Raspberry Pi Azure IoT Web Simulator](https://azure-samples.github.io/raspberry-pi-web-simulator/#GetStarted)

Hay tres áreas en este simulador:  

- **Circuito**: El circuito predeterminado consiste en una Raspberry Pi conectada a un sensor BME280 y un LED. No se puede modificar.  

- **Área de codificación**: Un editor de código en línea para programar con Raspberry Pi. La aplicación de ejemplo predeterminada permite recopilar datos del sensor BME280 y enviarlos a Azure IoT Hub. La aplicación es totalmente compatible con dispositivos reales. 

- **Ventana de consola integrada**: Muestra la salida del código. En la parte superior aparecen tres botones: 

        - **Run (Ejecutar)**: Ejecuta la aplicación en el área de codificación.  
        - **Reset (Restablecer)**: Restablece el área de codificación a la aplicación de ejemplo predeterminada.  
        - **Fold/Expand (Comprimir/Expandir)**: A la derecha hay un botón para plegar o expandir la ventana de la consola.  

### Ejecución en simulador
-       Sobre el código por defecto del simulador web, **modificamos** la linia 15 dónde pone "*Your IoT hub device connection string*" para la cadena de conexión que hemos generado en Azure IoT Hub antes.
<div align="center"><img src="../../img/azurep1_2.png" alt="Azure p1" width="80%" /></div>
-       Seleccionar "**Ejecutar**" o escribir "**npm start**" para ejecutar.
Debemos de revisar el resultado del sensor y los mensajes generados.
<div align="center"><img src="../../img/azurep1_3.png" alt="Azure p1" width="80%" /></div>

## P1.2. Conectar Raspberry Pi a Azure Centro IoT y Enrutamiento a una Cuenta de Almacenamiento (Storage Account)
### Introducción
- [x] Creamos una cuenta de almacenamiento "Blob Storage Account".
- [x] Creamos un punto de conexión personalizado para que la cuenta de almacenamiento enrute los mensajes desde el Centro IoT.
- [x] Revisamos los mensajes del dispositivo en el "Blob Storage Account".

### Conexión con dispositivo
Acopiado este punto, vamos a recuperar los mensajes recibidos en el Azure Centre IoT a través de un componente de Azure llamado "enrutamiento de mensajes" para almacenarlos en una Storage Account para poder explotarlos posteriormente.

1. Vamos al Azure Centro IoT en el portal Azure.
2. Seleccionamos "**Directivas de acceso compartido**" en la sección "*Configuración de seguridad*".
3. Seleccionamos la directiva "**iothubowner**".
4. Copiamos el contenido de la "*cadena de conexión principal / string*"
5. Ahora utilizaremos esta cadena de conexión para configurar el Explorador del Centro IoT. Hay que descargar e instalar el herramiento: [Releases · Azure/azure-iot-explorer (github.com)](https://github.com/Azure/azure-iot-explorer/releases)
        -       Abrimos el aplicativo "**Azure IoT Explorer**".
        -       Seleccionamos "**Connect via IoT Hub connection string**". Y añadimos un nuevo dispositivo.
        -       Peguemos la cadena de conexión copiada anteriormente (iothubowner)
        -       Seleccionamos "Guardar".
        -       Ya conectados al Centro IoT, veremos un listado de los dispositivos. Seleccionamos lo creado.
        -       Seleccionamos "Telemetría".
        -       Con el dispositivo en ejecución, seleccionamos "Start". Si el dispositivo no se está ejecutando, no veremos la telemetría. 
        -       h.	Si todo esta funcionando, debemos visualizar los mensages que llegan al dispoisitvo, el mas reciente en la parte superior.
        -       Todos los mensajes reúnen al punto de conexión integrado predeterminado del Centro IoT. A continuación, vamos a crear un punto de conexión personalizado y enrutar algunos de los mensajes al conde de almacenamiento en función de las propiedades del mensaje.

!!! note "Observación"
        Observem els missatges entrants durant uns segons per comprovar que veiem diferents paràmetres. Després, podem parar el dispositiu.

!!! note "Nota"
        Los mensajes dejarán de aparecer en el Explorador IoT por que solo van al punto de conexión integrado cuando no coinciden con ninguna otra ruta en el Centro IoT

### Crear cuenta de almacenamiento (Storage Account)

Creamos un "Storage Account" y un contenedor dentro que tendrá todos los mensajes del dispositivo que se asoman a la misma.

1. Abrimos el Portal Azure y buscamos "Cuentas de almacenamiento"
2. Seleccionamos "Crear".
3. Proporcionamos los siguientes valores para la "Cuentas de almacenamiento": Suscripción, Grupos de recursos, Número del a cuenta de almacenamiento y Rendimiento.
4. Seleccionamos "Revisar y crear".
5. Una vez completada la validación, seleccionamos "Crear".
6. Una vez finalizada la implementación, seleccionamos "Ir al recurso" o lo buscamos a través del portal.
7. En el menú de la "cuenta de almacenamiento", seleccionamos "Contenedores en la sección Almacenamiento de datos".
8. Seleccionamos "+ Contenedor" para crear un nuevo contenedor.
9. Proporcionaremos un nombre para el contenedor y seleccionamos "Crear".

### Enrutamiento a una cuenta de almacenamiento
Vamos a definir un nuevo punto de conexión que apunta a la "cuenta de almacenamiento" que me creado. 
A continuación, creamos una ruta sin ningún filtro a los mensajes y lo enrutamos en el punto de conexión de la "cuenta de almacenamiento"

!!! note "Nota"
Se pueden escribir datos en el Blob Storage con formato Apache Avro (predeterminado) o JSON. El formato de codificación solo se puede establecer en el momento en el que se configura el punto de conexión del Blob Storage. No se puede cambiar el formato en un punto de conexión que ya está configurado. Cuando se utiliza codificación JSON, se debe establecer contentType en JSON y contentEncoding en UTF-8 en las propiedades del sistema de mensajes.

1. En Azure Portal, vamos hasta el Centro IoT.
2. Seleccionamos "Enrutamiento de mensajes".
3. En la pestaña "Rutas", seleccionamos "+ Agregar".
4. Seleccionamos en "Agregar punto de conexión" junto al campo "Extremo" y seleccionamos "Almacenamiento" en el menu desplegable.
5. Proporcionamos la información para el nuevo punto de conexión: Número, Contenedor de Azure Storage y Encoding.
6. Aceptamos los valores predeterminados para el resto de parámetros y seleccionamos "Crear".
7. Seguimos con la creación de la nueva ruta. Hemos agregado el punto de conexión al "Storage Account". Proporcionaremos la siguiente información para la nueva ruta:
8. Guardamos
Una vez creada la ruta en el Centro IoT y habilitada, iniciará inmediatamente el derrumbamiento de mensajes que cumpliendo la condición de la consulta del punto de conexión definido.

### Supervisión 
Volvamos a la sesión del explorador IoT. Recordemos que el explorador IoT supervisa el punto de conexión integrado para el centro IoT. Significa que ahora debería ver solo mensajes que no se enrutan mediante la ruta personalizada creada.
Volvemos a iniciar el simulador y la telemetría. Observamos los mensajes entrantes durante unos instantes (si hay)

### Visualización de mensages en la cuenta de almacenamiento
Comprobamos los mensajes están apretando al "Storage account":

1. En Azure Portal, vamos a "cuenta de almacenamiento".
2. Seleccionamos "Contenedores" en la sección de "Almacenamiento".
3. Seleccionamos el contenedor.
4. Debe haber una carpeta con el nombre del centro IoT. Exploramos en profundidad la estructura hasta que reúnamos a ficheros avro.
5. Seleccionamos el fichero avro y, a continuación, lo descargamos. Y confirmamos que contiene mensajes del dispositivo establecido en el "enrutamiento".
6. Paremos el simulador.

### Ejercicio

En el "enrutamiento" creado en el "Centro IoT" hacia el Storage Account, se pueden definir condiciones que filtran los mensajes que irán destinados al Storage Account.
Con la documentación de Microsoft: [Consulta sobre el enrutamiento de mensajes de Azure IoT Hub | Microsoft Learn](https://learn.microsoft.com/es-es/azure/iot-hub/iot-hub-devguide-routing-query-syntax)

Generar un filtro que destine solo mensajes filtrados por alguna de sus características del JSON devuelto.


## P1.3. Conectar Raspberry Pi a Azure Centro IoT y Enrutamiento a una Aplicación Lógica y envío de correos

