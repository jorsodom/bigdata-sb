# Modelo Multidimensional (OLAP)

## Conceptos fundamentales

El modelo multidimensional es la base para el diseño de **Almacenes de Datos (Data Warehouses)**, cuyo objetivo es soportar el análisis de información para la toma de decisiones. A diferencia de los modelos transaccionales (OLTP), el modelo multidimensional busca optimizar la rapidez y simplicidad de las consultas.

El diseño de estos modelos se basa en transformar las **preguntas del negocio** en dos componentes esenciales: **Hechos** y **Dimensiones**.

## Componentes clave

### 1. Tabla de Hechos (*Fact Table*)

La tabla de hechos es la **tabla principal o central** del modelo dimensional.

*   **Propósito:** Registra los **eventos del negocio** que se desean analizar, como las **compras** o las ventas.
*   **Métricas o Indicadores:** Contiene los **valores numéricos, medibles y cuantitativos** del evento que se van a analizar (por ejemplo, el financiamiento invertido o el total de películas producidas). Estos valores son generalmente **agregables**.
*   **Granularidad:** Los hechos se registran a un alto nivel de **atomicidad** o **mínima expresión**, lo que se conoce como granularidad.

### 2. Tablas de Dimensiones (*Dimension Tables*)

Las dimensiones proporcionan el **contexto** o la **perspectiva de análisis del hecho**. Son atributos que describen los datos indicados en los hechos (metadatos).

*   **Contenido:** Las dimensiones contienen la información **descriptiva** de los hechos. Aunque suelen tener menos registros que la tabla de hechos, cada registro puede tener un gran número de atributos descriptivos.
*   **Ejemplos comunes:** Los contextos típicos incluyen el tiempo (fecha, mes, año), la geografía (país, provincia, ciudad), los productos, o los proveedores.
*   **Jerarquías:** Las dimensiones a menudo contienen **jerarquías** o relaciones internas. Por ejemplo, a partir de una dimensión base como la fecha de estreno, se pueden derivar el trimestre, el mes, el año y la década.

## Esquemas comunes

El modelo multidimensional se representa típicamente mediante dos esquemas:

### Esquema en Estrella (*Star Schema*)
El **Esquema en Estrella** es el modelo dimensional ideal por su **simplicidad y velocidad** para el análisis (OLAP).

*   **Estructura:** Una tabla de hechos central está **rodeada** por tablas de dimensiones.
*   **Ventajas:** Las consultas (*JOINs*) solo involucran a la tabla de hechos y a las de dimensiones, simplificando la consulta y mejorando el rendimiento. Se considera el esquema **ideal** para la visualización de datos.

### Esquema en Copo de Nieve (*Snowflake Schema*)
Este esquema es **más complejo** y se presenta cuando las dimensiones están **normalizadas** (una dimensión tiene más de una tabla asociada).

*   **Desventaja:** La tabla de hechos **no está relacionada directamente** a todas las tablas que componen el modelo de datos, lo que requiere uniones (JOINs) encadenadas y más complejas. Su objetivo principal es **disminuir el almacenamiento**.

---

## EJERCICIO. Diseño del modelo Multidimensional de Compras

Para construir el **Modelo Multidimensional de Compras**, se deben seguir los pasos de la metodología analítica, identificando el hecho, los indicadores y las dimensiones necesarias para responder a las preguntas gerenciales.

Dado el siguiente modelo de datos transaccional:

<div align="center">
<img src="../../img/modelomultidimensional-01.png"  alt="Data Analytics"
width="70%" />
</div>

### 1. Identifica las tablas de Hechos

El hecho principal objeto de análisis en este contexto es:

*   **Hecho (Fact):** **Compras** (registrando la adquisición de bienes o servicios).

### 2. Identifica posibles Hechos y sus posibles calculos

Los cálculos (o métricas) son los valores numéricos que la gerencia desearía analizar en función del evento "Compra".

| Criterio | Ejemplos de Indicadores (Medidas) |
| :--- | :--- |
| **Cuantificación** | **Número de unidades** compradas |
| **Financiero** | **Costo total** de la compra, **Costo promedio** |
| **Contable** | Impuestos aplicados, Descuentos obtenidos |

### 3. Identifica las Dimensiones/Catalogos

Las dimensiones definen las perspectivas de análisis para desagregar los indicadores de Compras (el contexto de *quién*, *qué*, *cuándo* y *dónde*).

| Dimensión Común | Atributos Descriptivos Típicos |
| :--- | :--- |
| **Tiempo/Calendario** | Fecha de compra, Mes, Trimestre, Año (Dimensión temporal base). |
| **Producto/Ítem** | Nombre del producto, Categoría, Marca, Tipo de ítem. |
| **Proveedor** | Nombre del proveedor, País de origen, Tipo de proveedor. |
| **Geográfica/Almacén** | Ubicación de la recepción (Almacén, País, Ciudad, Provincia). |
| **Empleado/Comprador**| Nombre del empleado, Departamento. |

*Nota: Identificar jerarquías dentro de estas dimensiones es clave para el diseño.*

### 4. Construir el modelo multidimensional

El diseño recomendado es el **Esquema en Estrella**, debido a su simplicidad para las consultas analíticas.

**Estructura:**

La tabla central de **Hechos (Compras)** contendrá los indicadores (Costo Total, Cantidad Comprada) y las claves foráneas que se conectan a cada una de las dimensiones identificadas (Dimensión Tiempo, Dimensión Proveedor, Dimensión Producto, etc.).

*   **Tabla de Hechos (Fact\_Compras):**
    *   `ID_Hecho\_Compra` (Clave Sustituta)
    *   `ID\_Tiempo` (FK a Dim\_Tiempo)
    *   `ID\_Proveedor` (FK a Dim\_Proveedor)
    *   `ID\_Producto` (FK a Dim\_Producto)
    *   `Costo\_Total` (Métrica)
    *   `Cantidad\_Comprada` (Métrica)

*   **Tablas de Dimensiones (Dim\_Proveedor, Dim\_Producto, Dim\_Tiempo, etc.):** Contienen la información descriptiva.

<div align="center">
<img src="../../img/modelomultidimensional-02.png"  alt="Data Analytics"
width="70%" />
</div>

 solución diagrama

### 5. Describe textualmente el modelo y que contiene

El modelo multidimensional de Compras está diseñado como un **Esquema en Estrella** (o Copo de Nieve, si se normalizan las dimensiones). El propósito de este modelo es analizar los **hechos de compra** (la actividad central del negocio).

*   **Contenido:** El modelo se centra en el hecho **Compra**, midiendo indicadores como el **costo total** y la **cantidad de unidades** adquiridas.
*   **Análisis:** Estos indicadores pueden ser analizados según diferentes perspectivas, como **cuándo** se compró (Dimensión Tiempo), **qué** se compró (Dimensión Producto) y **a quién** se le compró (Dimensión Proveedor).
*   **Beneficio:** Permite a los gerentes generar informes dinámicos y responder a preguntas como: "¿Cuánto gastamos en la Categoría X de productos durante el último trimestre, y a qué proveedores?".

### 6. Analizar otras posibilidades de diseños

Además del diseño base, se pueden considerar alternativas para mejorar la eficiencia del análisis:

1.  **Esquema en Copo de Nieve (*Snowflake*):** Si se requiere reducir la redundancia en las dimensiones, se podría normalizar una dimensión. Por ejemplo, la Dimensión Proveedor podría separarse en una tabla de Proveedores y una tabla de Ubicaciones Geográficas del Proveedor.
2.  **Data Marts (DM):** Si este modelo de Compras es solo una parte de un *Data Warehouse* más grande (que incluye Ventas, Inventario, etc.), podría definirse como un **Data Mart** específico para el departamento de Compras.
3.  **Capas Agregadas:** Se pueden incluir tablas con **datos precalculados** (*agregados*). Por ejemplo, una tabla agregada podría contener el "Costo Total Mensual por Categoría de Producto" para acelerar los informes de resumen.

#### ENTREGABLE 

Hay que facilitar un documento con todos los puntos del ejercicio y el diseño. 