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

Actividades Prácticas
Para consolidar el aprendizaje, se propone realizar dos prácticas iniciales:

Práctica 1: Configuración básica del entorno Hadoop.

Práctica 2: Configuración del sistema SSH, necesario para la comunicación entre nodos del clúster Hadoop.

