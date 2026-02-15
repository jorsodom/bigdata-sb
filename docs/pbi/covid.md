## 0. Descargar Power BI
Instalar Power BI Desktop desde la web oficial para poder modelar y visualizar los datos posteriormente.

[PowerBI Desktop descarga](https://download.microsoft.com/download/8/8/0/880bca75-79dd-466a-927d-1abf1f5454b0/PBIDesktopSetup_x64.exe)

## 1. Exportar datos OracleSQL
Desde la base de datos Oracle, exportar las tablas necesarias a ficheros `.csv` utilizando el delimitador `;` o `,` para garantizar compatibilidad con procesos de carga posteriores.

## 2. Exportar los ficheros fuera de la VM
Copiar los ficheros `.csv` generados desde la máquina virtual a un entorno accesible (local o almacenamiento en la nube) para su posterior ingestión.
Subirlos a una storage account o s3.

<div align="center">
<img src="../../img/pbi_covid_storageaccount.png" alt="pbi caso de uso" 
width="80%" />
</div>

## 3. Crear base de datos SQL Server en Azure o utilizar la ya existente
Provisionar una base de datos en Azure de tipo relacional, SQL Server o reutilizar una ya disponible para almacenar los datos migrados.

<div align="center">
<img src="../../img/pbi_covid_sqlserverazure.png" alt="pbi caso de uso" 
width="80%" />
</div>

## 4. Crear un esquema
Definir un esquema lógico para organizar las tablas relacionadas con el proyecto:

    CREATE SCHEMA COVID; 

## 5. Crear tablas según el script create tables

Ejecutar el script de creación de tablas en la base de datos para definir la estructura.

<div align="center">
<img src="../../img/pbi_covid_dbbeaver.png" alt="pbi caso de uso" 
width="80%" />
</div>

    DROP TABLE COVID.LKP_SEXO;

    CREATE TABLE COVID.LKP_SEXO (
    C_SEXO VARCHAR(150),
    SEXO VARCHAR(150),
    FECHA_ACT VARCHAR(150)
    );

    DROP TABLE COVID.LKP_GRUPO_EDAD;

    CREATE TABLE COVID.LKP_GRUPO_EDAD (
    C_GRUPO_EDAD VARCHAR(150),
    GRUPO_EDAD VARCHAR(150),
    FECHA_ACT VARCHAR(150)
    );

    DROP TABLE COVID.LKP_PROVINCIA;

    CREATE TABLE COVID.LKP_PROVINCIA (
    C_PROVINCIA VARCHAR(150),
    PROVINCIA VARCHAR(150),
    FECHA_ACT VARCHAR(150)
    );

    DROP TABLE COVID.LKP_ESTAT_ALARMA;

    CREATE TABLE COVID.LKP_ESTAT_ALARMA (
    C_ESTAT_ALARMA INT NOT NULL,
    ESTAT_ALARMA VARCHAR(150),
    FECHA_ACT VARCHAR(150)
    );

    DROP TABLE COVID.LKP_FECHA;

    CREATE TABLE COVID.LKP_FECHA (
    C_DATA VARCHAR(25) NOT NULL,
    D_DATA VARCHAR(150),
    C_DIA VARCHAR(150),
    D_CURTA_DIA VARCHAR(150),
    D_LLARGA_DIA VARCHAR(150),
    C_DIA_SETMANA VARCHAR(150),
    C_MES VARCHAR(150),
    C_ANY_MES VARCHAR(150),
    D_CURTA_MES VARCHAR(150),
    D_LLARGA_MES VARCHAR(150),
    C_SETMANA VARCHAR(150),
    C_TRIMESTRE VARCHAR(150),
    C_SEMESTRE VARCHAR(150),
    C_ANY VARCHAR(150),
    C_DIA_NATURAL VARCHAR(150),
    C_DIA_FESTIU VARCHAR(150),
    C_DIA_FEINA VARCHAR(150),
    ID_CARREGA  VARCHAR(150),
    FECHA_ACT VARCHAR(150)
    );

    DROP TABLE COVID.ODS_COVID;

    CREATE TABLE COVID.ODS_COVID (
    C_DATA VARCHAR(150),
    C_PROVINCIA VARCHAR(150),
    C_SEXO VARCHAR(150),
    C_GRUP_EDAT VARCHAR(150),
    C_ESTAT_ALARMA VARCHAR(150),
    F_NUM_CASOS  VARCHAR(150),
    F_NUM_HOSP  VARCHAR(150),
    F_NUM_UCI VARCHAR(150),
    F_NUM_DEF VARCHAR(150),
    FECHA_ACT VARCHAR(150)
    );

## 6. Importar datos de los ficheros

Cargar los datos desde los .csv en las tablas correspondientes del esquema COVID, validando formatos y tipos de datos.

Creando un proceso data factory con actividades de copia. Dónde el origen será un csv con conexión al storage account y el destino el SQL Server.

<div align="center">
<img src="../../img/pbi_covid_datafactory.png" alt="pbi caso de uso" 
width="80%" />
</div>


## 7. Obtener string de conexión a la base de datos (y credenciales)

Recuperar la cadena de conexión, usuario y contraseña desde el portal de Azure o la configuración del servidor para permitir la conexión desde herramientas como Power BI.

!!! note "Apertura firewall"

    La base de datos debe estar abierta a internet para permitir el acceso sin restricciones. 


## 8. Crear nueva conexión en PBI a la bbdd y importar datos

Abrimos la aplicación de Power BI. Seleccionamos origen de datos `SQL Server`. Seleccionamos modo "Direct Import".

<div align="center">
<img src="../../img/pbi_covid_pbi1.png" alt="pbi caso de uso" 
width="80%" />
</div>

Hay que introducir el servidor y la base de datos (ver anexo). Luego aplicamos en siguiente. Elegimos la opción Base de Datos y introducimos usuario y contraseña. Y conectamos.

<div align="center">
<img src="../../img/pbi_covid_pbi2.png" alt="pbi caso de uso" 
width="80%" />
</div>


Saldrá la lista de tablas a importar, seleccionamos las deseadas. Y hacemos clic en `Cargar`. Esta acción realizará la carga de datos en el proyecto que lee de la base de datos en la nube. 


<div align="center">
<img src="../../img/pbi_covid_pbi3.png" alt="pbi caso de uso" 
width="80%" />
</div>


Aparecerá un panel en la derecha dónde se listarán las tablas cargadas, con todos sus atributos. 

<div align="center">
<img src="../../img/pbi_covid_pbi4.png" alt="pbi caso de uso" 
width="80%" />
</div>


## 9. Definimos el modelo y tipados

En el menu del a izquierda, vamos a `Vista Modelo` y tenemos que establecer las relaciones según el modelo multidimensional.

Conforme vamos estableciendo las relaciones, relacionando por los códigos nos damos cuenta que todas ellas son 1...N, dado que en los registros de la estrella
pueden aparecer N valores de una dimensión.

Hay que establecer las relaciones de la siguiente manera:

| Columna Origen   | Tabla Origen | Columna Destino   | Tabla Destino        |
|------------------|--------------|-------------------|----------------------|
| C_DATA           | ODS_COVID    | C_DATA            | LKP_FECHA            |
| C_PROVINCIA      | ODS_COVID    | C_PROVINCIA       | LKP_PROVINCIA        |
| C_SEXO           | ODS_COVID    | C_SEXO            | LKP_SEXO             |
| C_GRUPO_EDAD     | ODS_COVID    | C_GRUPO_EDAD      | LKP_GRUPO_EDAD       |
| C_ESTAT_ALARMA   | ODS_COVID    | C_ESTAT_ALARMA    | LKP_ESTAT_ALARMA     |


<div align="center">
<img src="../../img/pbi_covid_pbi5.png" alt="pbi caso de uso" 
width="80%" />
</div>

Ahora seleccionamos en el menu de la izquierda `Vista Informe`, y en el menu de la derecha dónde aparecen las tablas y columnas, seleccionamos la tabla LKP_FECHA y hacemos clic botón derecho y entramos en `editar consulta`. Saldrá una nueva ventana dónde es posible editar la tabla/consulta.

Aquí seleccionaremos la columna D_DATA y le damos dónde pone `ABC` a la izquierda del nombre la columna y le decimos que le ponga formato fecha (sin horas). Y hacemos `clic en aplicar y cerrar`.

<div align="center">
<img src="../../img/pbi_covid_pbi6.png" alt="pbi caso de uso" 
width="80%" />
</div>

## 10. Desarrollamos visualizaciones y transformaciones

Los gráficos se realizan para transformar los datos en información comprensible que permita responder preguntas clave de negocio de forma rápida y visual. En lugar de revisar tablas con muchos valores, las visualizaciones permiten identificar tendencias, comparar segmentos (como edad o sexo) y detectar patrones de gravedad o evolución temporal.

Así, cada gráfico ayuda a responder cuestiones concretas, por ejemplo: cómo evoluciona la incidencia en el tiempo, qué grupos de población han sido más afectados o si las medidas adoptadas (como los tramos de estado de alarma) han tenido impacto. En definitiva, los gráficos facilitan la toma de decisiones al convertir los datos en insights claros y accionables.


### Visualización 1: Incidencia acumulada
**Objetivo**: Identificar mensualmente la incidencia acumulada.
**Tipo:** Gráfico de líneas  

- **Eje X:** `C_ANY_MES` de `LKP_FECHA`  
- **Eje Y:** `IncidenciaAcumulada` (medida creada)

<div align="center">
<img src="../../img/pbi_covid_pbi7.png" alt="pbi caso de uso" 
width="80%" />
</div>

---

### Visualización 2: Incidencia acumulada por grupo de edad
**Objetivo**: Identificar mensualmente la incidencia acumulada por grupo de edad.
**Tipo:** Gráfico de líneas.  

- **Eje X:** `C_ANY_MES` de `LKP_FECHA`  
- **Eje Y:** `IncidenciaAcumulada` (medida creada)  
- **Leyenda:** `Grupo Edad`

<div align="center">
<img src="../../img/pbi_covid_pbi8.png" alt="pbi caso de uso" 
width="80%" />
</div>
---

### Visualización 3: Matriz de gravedad

**Objetivo**:  Identificar qué perfiles fueron más afectados.
**Tipo:** Matriz. 

- **Filas:** `Grupo Edad`  
- **Columnas:** `Sexo`  
- **Valores:**  
  - `IncidenciaAcumulada`  
  - `Hospitalizaciones`  
  - `HospitalizacionesUCI`  
  - `Defunciones`  
  - `TasaLetalidad`  

<div align="center">
<img src="../../img/pbi_covid_pbi9.png" alt="pbi caso de uso" 
width="80%" />
</div>

---

### Visualización 4: Mapa
**Objetivo**:  Identificar hospitalizaciones y defunciones según la provincia.
**Tipo:** Mapa.

Para habilitar el componente de mapas y mapas coropléticos:

1. Ir a **Archivo > Opciones y configuración > Opciones**  
2. Seleccionar **Global > Seguridad**  
3. Activar los visuales de mapa y mapa coroplético  
4. Cerrar y volver a abrir Power BI

<div align="center">
<img src="../../img/pbi_covid_pbi10.png" alt="pbi caso de uso" 
width="80%" />
</div>

- **Ubicación:** `Provincia`  
- **Tamaño burbuja:** `Hospitalizaciones`  
- **Información sobre la herraienta:** `Defunciones`  

<div align="center">
<img src="../../img/pbi_covid_pbi11.png" alt="pbi caso de uso" 
width="80%" />
</div>

### Transformaciones

#### Cambio de tipo de datos
- Todas las columnas `F_NUM_*` deben ser de tipo **Número entero**.  
- Pasos:
    1. Ir a **Editar consultas**  
    2. Cambiar el tipo de datos de las columnas `F_NUM_*` a *Número entero*  
    3. **Cerrar y aplicar**

---

#### Creación de medidas en `ODS_COVID`
Crear las siguientes medidas agregadas (SUM):

    `IncidenciaAcumulada = SUM('COVID ODS_COVID'[F_NUM_CASOS])
    Defunciones = SUM('COVID ODS_COVID'[F_NUM_DEF])
    Hospitalizaciones =  SUM('COVID ODS_COVID'[F_NUM_HOSP])
    HospitalizacionesUCI = SUM('COVID ODS_COVID'[F_NUM_UCI])
    TasaHospitalizacion = DIVIDE([Hospitalizaciones], [IncidenciaAcumulada])
    TasaUCI = DIVIDE([HospitalizacionesUCI], [Hospitalizaciones])
    TasaLetalidad = DIVIDE([Defunciones], [IncidenciaAcumulada])
    IndiceGravedad = DIVIDE([Hospitalizaciones] + (2 * [HospitalizacionesUCI]) + (3 * [Defunciones]),[IncidenciaAcumulada])`


## Anexos

### DB Beaver Community
Descargar DB Beaver Community para conectar fácilmente al SQL Server 

[DB Beaver Community](https://dbeaver.io/files/dbeaver-ce-latest-x86_64-setup.exe)

### String sql server jorge

jdbc:sqlserver://bbddjorge.database.windows.net:1433;database=jorgebbdd;user=AQUIELUSER@bbddjorge;password=AQUILAPASSWORD;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;