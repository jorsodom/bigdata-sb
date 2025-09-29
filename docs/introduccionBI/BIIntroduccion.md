# Introducción BI


## Sistema operacional (OLTP)
Generalmente, la información que se quiere investigar sobre un cierto dominio de la organización se encuentra en bases de datos y otras fuentes muy diversas, tanto internas como externas.

- [x] Muchas de estas fuentes son las que se utilizan para el trabajo transaccional diario (conocido como OLTP, On-Line Transactional Processing).

- [x] Sobre estas mismas bases de datos de trabajo ya se puede extraer conocimiento (visión tradicional).

Problemas para realizar el análisis en este sistema (OLTP):

- [] La información se encuentra en varias y heterogéneas bases de datos y, en consecuencia, no se puede explotar en conjunto.

- [] Solo es posible el análisis de los datos actuales, no mantiene valores históricos para tratar evolutivos.

- [] Se obstaculiza el trabajo transaccional diario de los sistemas de información originales, no permite el análisis on-line.

- [] La base de datos está diseñada para el trabajo transaccional, no para el análisis de los datos.

## Sistema analítico (OLAP)

Disponer de una base de datos que permita extraer conocimiento de la información histórica almacenada en la organización.

Objetivos:

- [x] Análisis de la organización

- [x] Previsiones de evolución

- [x] Diseño de estrategias

<div align="center">
<img src="../../img/" alt="FlowFile" 
width="50%" />
</div>

● Almacén de datos para el análisis y toma de decisiones.

● Permite realizar análisis on-line, por lo que aumenta el poder de toma de decisiones por parte de los responsables en cuestión

● Unifica información dispersa de diversos sistemas operacionales

● Contiene la información relevante de la organización

● Diseños orientados a conceptos de negocio manejados por el usuario

● Sistema OLAP (On-Line Analitical Procesing)

## OLTP vs OLAP

| **Característica**                | **Operacional (OLTP)**                          | **Datawarehouse (OLAP)**                                             |
|-----------------------------------|------------------------------------------------|-----------------------------------------------------------------------|
| **Tipo de datos**                      | Almacén de datos actuales                       | Almacén de datos históricos                                         |
| **Nivel de detalle**                   | Almacena datos al detalle                       | Almacena datos al detalle y datos agregados a distintos niveles      |
| **Tamaño de la base de datos**         | Bases de datos medianas                         | Bases de datos grandes                                             |
| **Naturaleza de los datos**            | Los datos son actuales                          | Los datos son estáticos*                                              |
| **Tipo de procesos**                    | Los procesos son repetitivos                    | Los procesos no son previsibles                                      |
| **Tiempo de respuesta**                 | Tiempo de respuesta pequeño                     | Tiempo de respuesta variable                                        |
| **Tipo de decisiones que soporta**      | Soporta decisiones diarias                      | Soporta decisiones estratégicas                                      |

## Componentes de un sistema BI

<div align="center">
<img src="../../img/introbi-2.png" alt="componentesBI" 
width="80%" />
</div>

---

### Sistema ETL

●Proceso de extracción y carga de la información desde las distintas fuentes origen al Datawarehouse. Incluye las siguientes fases:

○Extracción: elaboración de interfaces entre sistemas operacionales orígenes de datos
○Transformación: validación de los datos extraídos, transformándolos al formato deseado
○Carga: cargar físicamente los datos extraídos de los sistemas operacionales y ya transformados en el modelo de datos del Datawarehouse

---

### Datawarehouse
Se soporta sobre el modelo físico dimensional diferente de los sistemas de bases de datos que están basados en el modelo Entidad-Relación (E/R). Este modelo contiene la misma información que el modelo E/R pero agrupa los datos con el objetivo de ganar una mayor comprensión para el usuario y garantizar la ejecución rápida y eficiente de las consultas.

●Existen dos tecnologías para implementar dicho modelo:

○MultidimensionalOLAP (MOLAP): se indexa los datos directamente en un modelo multidimensional (cubos) en el cual todas las posibles combinaciones de los datos ya están calculadas en una celda
○RelationalOLAP (ROLAP): implementa las estructuras dimensionales mediante bases de datos con modelos relacionales. 

---

### Presentación

<div align="center">
<img src="../../img/introbi-3.png"  alt="reporting" 
width="80%" />
</div>

**DSS (Decisión Support System)**:
○Informes dinámicos, normalmente para representar un indicador o un grupo de indicadores relacionados funcionalmente en tablas de datos.
○Además de estos informes predefinidos, los usuarios con capacidades de análisis podrán crear sus propios informes y obtener respuestas en demandas de información puntuales.

●**EIS (Executive Information System)**:
○Informes estáticos, predefinidos, fáciles de manejar y orientados a los directores. Son informes muy visuales (normalmente se utilizan exclusivamente gráficos) y con un nivel alto de agregación de la información. Deben estar orientados a la gestión estratégica.

●**BSC (Balance Scored Card)**:
○Informes estáticos para la gestión estratégica de la empresa. Permite medir el rendimiento de áreas o personas mediante el análisis de diversos de un conjunto de indicadores con valores objetivo y pesos.

## Modelo lógico

**Ejemplo**

**Organización**: Cadena de supermercados.

**Actividad objeto de análisis**: ventas de productos.
Información registrada sobre una venta:
“del producto“X” se han vendido en el almacén“nro.1” el día 17/2/2008, 5 unidadespor un importede 100 euros.”

<div align="center">
<img src="../../img/introbi-4.png"  alt="reporting" 
width="80%" />
</div>
<div align="center">
<img src="../../img/introbi-5.png"  alt="reporting" 
width="80%" />
</div>

## Modelo multidimensional
En un esquema multidimensional se representa una actividad que es objeto de análisis (hecho) y las dimensiones que caracterizan la actividad (dimensiones).

●La información relevante sobre el hecho (actividad) se representa por un conjunto de indicadores.

●La información descriptiva de cada dimensión se representa por un conjunto de atributos (atributos de dimensión).

<div align="center">
<img src="../../img/introbi-6.png"  alt="reporting" 
width="80%" />
</div>

## Terminología

| **Concepto**         | **Descripción**                                                                 |
|-----------------------|---------------------------------------------------------------------------------|
| **Hecho**             | Un hecho es un elemento de información del negocio, es decir, algo que se puede medir. |
| **Indicador**         | Fórmula matemática aplicada a un conjunto de hechos.                           |
| **Dimensión / Eje de análisis** | Aspecto o perspectiva mediante la cual se puede acceder y analizar los hechos. |
| **Atributo**          | Característica específica de una dimensión.                                    |
| **Jerarquía**         | Relación padre/hijo utilizada para agrupar los atributos de una dimensión.     |
| **Agregación**        | Método por el cual los datos son agrupados para crear una tabla de hechos específica. |
| **Sumarización**      | Método por el cual los datos se cambian a un nivel diferente de granularidad.  |
| **Desnormalización**  | Proceso de introducir redundancias en la información de las tablas de la base de datos para mejorar el rendimiento de la aplicación. |
| **Datamart**          | Subconjunto departamental de un Datawarehouse corporativo o almacén de datos enfocado en un área específica, utilizado para el análisis y la toma de decisiones. |
| **Drill Down / Up**   | Navegar dentro de la información, desde niveles más altos a niveles más bajos o viceversa. |
| **DataMining**        | Búsqueda de patrones de comportamiento dentro de los datos, ya sea en un Datawarehouse o cualquier otra fuente de información. |

## Business Intelligence

Business Intelligencesuele definirse como la transformación de los datos de la compañía en conocimiento para obtener una ventaja competitiva.
Desde un punto de vista más pragmático, y asociándolo directamente a las tecnologías de la información, podemos definir Business Intelligence como:

El conjunto de metodologías, aplicaciones y tecnologías que permiten reunir, depurar y transformar datos de los sistemas transaccionales e información desestructurada (interna y externa a la compañía) en información estructurada, para su explotación directa (reporting, análisis OLAP...) o para su análisis y conversión en conocimiento soporte a la toma de decisiones sobre el negocio.

<div align="center">
<img src="../../img/introbi-7.png"  alt="reporting" 
width="80%" />
</div>


## Herramientas

### 🧠 Herramientas de Business Intelligence (BI)
Estas herramientas permiten **analizar, visualizar y presentar datos** para apoyar la **toma de decisiones estratégicas y operativas**.

- **Tableau** – Visualización de datos interactiva y potente, ideal para análisis avanzados.  
- **Power BI** – Plataforma de Microsoft para reportes y dashboards.  
- **Qlik Sense / QlikView** – BI asociativo para exploración y análisis de datos.  
- **Looker (Google)** – BI en la nube, enfocado en análisis colaborativo.  
- **MicroStrategy** – Plataforma empresarial de análisis y visualización.  
- **SAP BusinessObjects** – BI empresarial con integración en SAP.  
- **Domo** – BI en la nube con enfoque en colaboración y gestión empresarial.  
- **IBM Cognos Analytics** – BI con capacidades avanzadas de reportes y analítica.  
- **Sisense** – BI enfocado en datos complejos y grandes volúmenes.  
- **Zoho Analytics** – BI en la nube, accesible y flexible.  
- **Metabase** – BI open source, sencilla y colaborativa.  
- **Redash** – Open source para visualización y consultas SQL.  
- **Apache Superset** – Plataforma de BI open source moderna y escalable.  
- **Elasticsearch (con Kibana)** – Motor de búsqueda y analítica en tiempo real, ideal para dashboards y monitoreo.

---

### 🔄 Herramientas de ETL (Extract, Transform, Load)
Herramientas enfocadas en **integrar datos** desde diversas fuentes hacia **Data Warehouses** o **Data Lakes**, aplicando procesos de **extracción, transformación y carga**.

- **ODI (Oracle Data Integrator)** – Solución empresarial de Oracle para procesos ETL robustos y escalables.  
- **Talend** – Plataforma completa para integración y calidad de datos (Open Source y Enterprise).  
- **Informatica PowerCenter** – Plataforma empresarial líder en integración de datos.  
- **Pentaho Data Integration (PDI)** – Herramienta ETL open source muy popular.  
- **Apache NiFi** – ETL para **flujos de datos en tiempo real** y por lotes, con interfaz visual.  
- **Microsoft SQL Server Integration Services (SSIS)** – ETL integrado con el ecosistema Microsoft.  
- **AWS Glue** – ETL serverless administrado por Amazon Web Services.  
- **Azure Data Factory** – ETL en la nube dentro del ecosistema Azure.  
- **Google Cloud Dataflow** – ETL basado en Apache Beam para Google Cloud.  
- **Fivetran** – Integración automatizada de datos con conectores listos para usar.  
- **Stitch** – Integración sencilla y rápida en la nube.  
- **Airbyte** – ETL open source moderno y flexible.  
- **Matillion** – ETL optimizado para Data Warehouses modernos en la nube.  
- **Singer** – Framework open source para mover datos entre sistemas.  
- **Luigi** – Librería open source en Python para flujos de trabajo ETL complejos.  
- **Apache Kafka (Streaming)** – Procesamiento y transporte de datos en tiempo real.  

---

### 🔍 Herramientas de Búsqueda y Analítica de Datos
Estas herramientas se enfocan en **indexación**, **búsqueda** y **análisis avanzado de datos**.

- **Elasticsearch** – Motor de búsqueda y analítica distribuido, ideal para grandes volúmenes de datos.  
- **Kibana** – Interfaz gráfica para visualización y monitoreo de datos indexados en Elasticsearch.  
- **Logstash** – Herramienta para ingesta, transformación y envío de datos hacia Elasticsearch.  

---

### 📌 Recomendaciones

- **BI Empresarial:** Tableau, Power BI, Qlik.  
- **ETL Empresarial:** ODI, Informatica PowerCenter, Talend.  
- **ETL Open Source:** Apache NiFi, Pentaho, Airbyte.  
- **Nube:** AWS Glue, Azure Data Factory, Google Dataflow.  
- **Analítica y Búsqueda:** Elasticsearch + Kibana + Logstash (ELK Stack).  
