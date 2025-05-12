# Hadoop

## Introducción

**Hadoop** es una de las tecnologías más representativas del mundo del Big Data, hasta el punto de que, en muchos casos, ambos términos se utilizan casi como sinónimos. Se trata de un entorno distribuido que permite gestionar tanto grandes volúmenes de datos como los procesos necesarios para analizarlos y extraer valor.

Diseñado siguiendo el modelo de los superordenadores de alto rendimiento (High Performance Super Computers), Hadoop destaca por su capacidad para escalar horizontalmente, es decir, puede ampliarse fácilmente añadiendo más máquinas (nodos) que utilizan hardware relativamente económico.

## Características principales de Hadoop
- **Capacidad**: Almacena y procesa enormes cantidades de datos, de cualquier tipo (estructurados y no estructurados), de forma rápida y eficiente.

- **Potencia de procesamiento**: Basado en computación distribuida, aprovecha múltiples nodos para ejecutar tareas en paralelo.

- **Tolerancia a fallos**: Si un nodo falla, Hadoop redistribuye automáticamente las tareas a otros nodos disponibles, asegurando la continuidad del procesamiento.

- **Flexibilidad**: Permite elegir cuándo y cómo se realiza el preprocesamiento de los datos.

- **Bajo coste**: Al ser un proyecto de código abierto y funcionar sobre hardware estándar, su implantación es accesible económicamente.

- **Escalabilidad**: Puede crecer desde unas pocas máquinas hasta miles de nodos trabajando juntos de forma coordinada.

## Arquitectura y componentes
Hadoop implementa un modelo de procesamiento paralelo, ejecutando tareas distribuidas entre nodos mediante un sistema de archivos llamado Hadoop Distributed File System (HDFS).

Sus principales componentes son:

- **Hadoop Common**: Librerías y utilidades esenciales que permiten que los demás módulos funcionen.

- **MapReduce**: Modelo de programación que permite procesar grandes conjuntos de datos dividiéndolos en tareas menores que se ejecutan en paralelo.

- **HDFS (Hadoop Distributed File System)**: Sistema de almacenamiento distribuido que guarda los datos en bloques replicados entre distintos nodos.

Este entorno está diseñado para escalar desde un pequeño clúster de pocas máquinas hasta miles de nodos, cada uno con su propia lógica de procesamiento y capacidad de almacenamiento local.

## Ecosistema Hadoop: Otros proyectos relacionados
Hadoop no es un sistema aislado, sino que forma parte de un amplio ecosistema de herramientas que complementan y amplían sus capacidades. Entre ellas destacan:

- **HBase**: Base de datos NoSQL orientada a columnas, que corre sobre HDFS y permite acceso en tiempo real a grandes cantidades de datos.

- **Hive**: Sistema que facilita la agregación de datos y permite ejecutar consultas SQL sobre Hadoop usando MapReduce.

- **Pig**: Lenguaje de alto nivel que simplifica la escritura de flujos de datos complejos y su ejecución sobre Hadoop.

- **Mahout**: Plataforma para el desarrollo de algoritmos de aprendizaje automático (machine learning) sobre Hadoop.

- **Zookeeper**: Servicio centralizado que gestiona la configuración y sincronización de servicios distribuidos.

- **Sqoop**: Herramienta diseñada para transferir grandes volúmenes de datos entre Hadoop y bases de datos relacionales tradicionales.

## Distribuciones

A lo largo de los años, el crecimiento del ecosistema Big Data ha llevado a la aparición de diversas empresas que ofrecen soluciones “empaquetadas” o distribuciones listas para usar basadas en Hadoop. Estas soluciones eliminan la complejidad de configurar manualmente todos los componentes y ofrecen plataformas robustas, seguras y optimizadas para uso empresarial.

Estas distribuciones pueden desplegarse de varias formas:

Mediante máquinas virtuales preconfiguradas que podemos descargar y ejecutar localmente o en entornos corporativos.

Utilizando servicios completamente gestionados en la nube, facilitando así la escalabilidad y reduciendo la carga operativa.

Entre los proveedores y plataformas más destacados se encuentran:

1. **Cloudera**
Uno de los líderes del mercado.

Ofrece la Cloudera Data Platform (CDP), que integra Hadoop con herramientas modernas como Spark, Hive y machine learning.

Disponible tanto para despliegues en la nube como en instalaciones locales.

Incorpora seguridad avanzada, gestión de datos y analítica en tiempo real.

2. **Hortonworks (ahora parte de Cloudera)**
Ofrecía la distribución Hortonworks Data Platform (HDP), basada totalmente en software de código abierto.

En 2019, Hortonworks se fusionó con Cloudera, combinando sus tecnologías para ofrecer soluciones unificadas.

3. **IBM Open Platform**
IBM proporcionaba una distribución basada en Hadoop y otros componentes del ecosistema, con fuerte integración con su suite de analítica e inteligencia artificial.

Sus nuevas ofertas están centradas en IBM Cloud Pak for Data, que incorpora capacidades Big Data y AI sobre Kubernetes.

Otras Plataformas y Soluciones Relevantes
4. **MapR (Ahora HPE Ezmeral Data Fabric)**
Ofrecía una plataforma Big Data altamente optimizada que combinaba almacenamiento distribuido, procesamiento en tiempo real y gestión de flujos.

Actualmente forma parte de la propuesta HPE Ezmeral, que permite trabajar con Big Data y AI en entornos híbridos.

5. **Amazon EMR (Elastic MapReduce)**
Servicio gestionado de Amazon Web Services (AWS) para ejecutar Hadoop, Spark, HBase y otros componentes.

Altamente escalable y pago por uso, lo que permite procesar petabytes de datos sin necesidad de gestionar la infraestructura.

6. **Google Cloud Dataproc**
Solución gestionada en Google Cloud que permite desplegar clústeres Hadoop y Spark en cuestión de minutos.

Integrado con otras herramientas como BigQuery, Google Cloud Storage y AI Platform.

7. **Azure HDInsight**
Plataforma en la nube de Microsoft basada en Hadoop que también soporta Spark, Hive, HBase, y más.

Ofrece integración con las herramientas de datos y analítica del ecosistema Azure.

## Tendencia actual

Aunque Hadoop sigue siendo un pilar importante, las empresas también están adoptando nuevas arquitecturas como:

- Lago de datos (Data Lake) en la nube.

- Procesamiento distribuido en tiempo real con Apache Kafka, Apache Flink o Delta Lake.

- Herramientas de machine learning y analítica avanzada sobre plataformas unificadas (por ejemplo, Databricks).

Elegir entre estas soluciones dependerá de las necesidades específicas de cada organización:

- On-premise vs. cloud.

- Procesamiento por lotes vs. en tiempo real.

- Presupuesto y requisitos de seguridad.

Las soluciones empaquetadas y en la nube han democratizado el acceso al Big Data, permitiendo que tanto grandes corporaciones como pequeñas empresas puedan aprovechar su potencial sin grandes inversiones iniciales.

## Prácticas
Para consolidar el aprendizaje, se propone realizar dos prácticas iniciales:

- **Práctica 1**: Configuración básica del entorno Hadoop.

- **Práctica 2**: Configuración del sistema SSH, necesario para la comunicación entre nodos del clúster Hadoop.

