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

    `CREATE SCHEMA COVID; `

## 5. Crear tablas según el script create tables

Ejecutar el script de creación de tablas en la base de datos para definir la estructura.

<div align="center">
<img src="../../img/pbi_covid_dbbeaver.png" alt="pbi caso de uso" 
width="80%" />
</div>

    `DROP TABLE COVID.LKP_SEXO;

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
    );`

## 6. Importar datos de los ficheros

Cargar los datos desde los .csv en las tablas correspondientes del esquema COVID, validando formatos y tipos de datos.

Creando un proceso data factory con actividades de copia. Dónde el origen será un csv con conexión al storage account y el destino el SQL Server.

<div align="center">
<img src="../../img/pbi_covid_datafactory.png" alt="pbi caso de uso" 
width="80%" />
</div>


## 7. Obtener string de conexión a la base de datos (y credenciales)

Recuperar la cadena de conexión, usuario y contraseña desde el portal de Azure o la configuración del servidor para permitir la conexión desde herramientas como Power BI.

> Nota: la base de datos debe estar abierta a internet para permitir el acceso sin restricciones. 


## 8. Crear nueva conexión en PBI a la bbdd

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


Saldrá la lista de tablas a importar, seleccionamos las deseadas. Y hacemos clic en "Cargar". Esta acción realizará la carga de datos en el proyecto que lee de la base de datos en la nube. 


<div align="center">
<img src="../../img/pbi_covid_pbi3.png" alt="pbi caso de uso" 
width="80%" />
</div>


Aparecerá un panel en la derecha dónde se listarán las tablas cargadas, con todos sus atributos. 

<div align="center">
<img src="../../img/pbi_covid_pbi4.png" alt="pbi caso de uso" 
width="80%" />
</div>


## Anexos

### DB Beaver Community
Descargar DB Beaver Community para conectar fácilmente al SQL Server 

[DB Beaver Community](https://dbeaver.io/files/dbeaver-ce-latest-x86_64-setup.exe)

### String sql server jorge

jdbc:sqlserver://bbddjorge.database.windows.net:1433;database=jorgebbdd;user=AQUIELUSER@bbddjorge;password=AQUILAPASSWORD;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;