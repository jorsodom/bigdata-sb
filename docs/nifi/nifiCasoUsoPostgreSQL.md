### Análisis y comparativa de temperaturas y acumulación de Lluvia (2022-2024)
## Objetivo
Realizar un análisis mensual de las temperaturas medias y la acumulación de lluvia para los años 2022, 2023 y 2024, aprovechando los datos meteorológicos de España para obtener conclusiones a través de una herramienta de reporting.

Este caso de uso proporciona una solución automatizada y eficiente para la integración, procesamiento y análisis de datos meteorológicos, ayudando en la toma de decisiones y en la creación de informes precisos y oportunos.
## Flujo de datos
1. **Obtención de datos:**
    - **Fuentes de Información:**
            - **INE (Instituto Nacional de Estadística):** Relación de provincias y municipios de España.
            - **AEMET (Agencia Española de Meteorología):** Datos meteorológicos de todas las estaciones de España.
    - **Generación de Catálogo de Fechas:** Se crea un catálogo que permita tener las fechas de las mediciones de temperatura y lluvia a nivel mensual para cada estación.

2. **Carga de datos a base de datos (PostgreSQL):**
   Los datos obtenidos de las fuentes (INE, AEMET y el catálogo de fechas) se cargarán en una base de datos en una capa de **tablas Staging**. Esta capa intermedia es utilizada para mantener los datos en su formato bruto y poder realizar la limpieza y validación sin afectar a los sistemas fuente.

3. **Transformación de los datos:**
   Se realizarán los tratamientos necesarios en las tablas Staging, tales como:
     - Limpieza de datos (por ejemplo, valores nulos, duplicados).
     - Cálculos de agregados de temperatura media y acumulación de lluvia a nivel mensual.
     - Creación de claves foráneas y relaciones necesarias para el modelo dimensional.

4. **Carga a capa final en la base de datos:**
   Una vez procesados los datos, se cargan en las capas finales del modelo multidimensional:
     - **Catálogos/Dimensiones:** Información jerárquica y descriptiva (por ejemplo, provincias, municipios, estaciones).
     - **Modelo estrella (ODS):** Factos y medidas agregadas (temperatura media, acumulación de lluvia) por mes.

5. **Cálculo de KPIs:**
   Según los requisitos de tiempo, se tienen dos opciones para los KPIs:
     - **Opción 1: Agregado en la capa ODS:** Se realizan los cálculos de KPIs (por ejemplo, temperatura media anual, acumulación de lluvia mensual) directamente sobre la capa ODS para facilitar y agilizar las consultas.
     - **Opción 2: Cálculos en la herramienta de reporting:** Los KPIs se calculan directamente en la herramienta de reporting, lo que permite mayor flexibilidad, aunque a costa de tiempos de carga más largos.

6. **Análisis de los datos (esta parte la haremos al final cuando veamos PowerBI):**
    - Herramienta de reporting: Utilizando una herramienta de reporting (como Power BI, Tableau, etc.), los usuarios podrán generar informes, tablas y gráficos que permitirán comparar los datos de temperatura y lluvia de los años 2020, 2021 y 2022.  
    - A través de los KPIs y visualizaciones, se podrán sacar conclusiones y hacer predicciones o recomendaciones sobre el comportamiento del clima en las diferentes provincias y municipios de España.
## Tecnologías utilizadas
- **Apache NiFi:** Orquestación de la integración de datos desde las fuentes hasta la base de datos, garantizando un flujo controlado de los datos.
- **PostgreSQL:** Base de datos relacional para almacenamiento de datos procesados y generación del modelo multidimensional.
- **Herramienta de Reporting (ej. Power BI):** Visualización y análisis de los KPIs generados.
## Anexo

**Catálogo de fechas**

-   [Descargar fichero sql generación catálogo de fechas](./assets/Proc Data Cataleg.sql)


**INE**

-   [INE: Relación Provincia-Municipio](https://www.ine.es/daco/daco42/codmun/22codmun.xlsx)

**AEMET**

-   [¿Cómo pedir una API Key?](https://opendata.aemet.es/centrodedescargas/docs/FAQs170621.pdf)

-   [Centro de descargas de Aemet](https://opendata.aemet.es/centrodedescargas/inicio)

-   [Valores climatológicos diários](https://opendata.aemet.es/dist/index.html?#!/valoresclimatologicos/Climatolog%C3%ADas_diarias)