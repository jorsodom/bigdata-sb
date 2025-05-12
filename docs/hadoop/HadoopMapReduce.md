# MapReduce

## 1. ¿Qué es MapReduce?

**MapReduce** es un modelo de programación distribuido que permite procesar grandes cantidades de datos de forma paralela en un clúster Hadoop. Utiliza dos fases principales:

* **Map** ➔ divide el trabajo en pequeñas partes y las ejecuta en paralelo.
* **Reduce** ➔ combina los resultados en una salida final.

> ✔️ Se apoya en HDFS para leer los bloques y procesarlos cerca de donde residen, para minimizar el movimiento de datos.

---

## 2. Versiones de MapReduce

### MapReduce V1 (Primera versión)

* **Monolítica**: gestiona tanto la computación como los recursos del clúster.
* **Solo** soporta trabajos tipo *batch* (procesamiento por lotes).
Tiene problemas de:
  * **Escalabilidad** ➔ falla al superar \~5000 nodos.
  * **Rendimiento** ➔ mal desempeño en aplicaciones interactivas o en tiempo real.
  * **Gestión de recursos** ➔ centralizada y limitada.

#### Componentes V1:

**JobTracker** (Maestro):
  * Gestiona la planificación y ejecución de trabajos MapReduce.
  * Asigna recursos y monitoriza tareas.
**TaskTracker** (Esclavo):
  * Ejecuta las tareas asignadas por el JobTracker.
  * Informa sobre el estado de las tareas.

---

### MapReduce V2 (YARN)

Introduce **YARN** (*Yet Another Resource Negotiator*), que separa la gestión de recursos y el procesamiento.
Admite otros modelos de procesamiento, no solo batch: streaming, SQL interactivo, machine learning, etc.
Mucho más eficiente y escalable.

#### Componentes V2 (YARN):

**ResourceManager (RM)**:

  * Es el maestro de YARN.
  * Gestiona los recursos globales del clúster.
**NodeManager (NM)**:

  * Corre en cada nodo esclavo.
  * Administra recursos y contenedores en el nodo específico.
**ApplicationMaster (AM)**:

  * Uno por cada aplicación o trabajo lanzado.
  * Gestiona la vida y planificación del trabajo concreto.
  * Pide recursos al ResourceManager y coordina los NodeManagers.

#### Ventajas YARN:

* Separa recursos y computación ➔ mayor eficiencia.
* Admite otros frameworks además de MapReduce (como Spark, Tez, Flink).
* Escala mejor en clusters grandes.

---

## 3. Funcionamiento detallado de MapReduce

### Fases

#### 1. **Map**

* Cada fichero se divide en bloques HDFS.
* Cada bloque es procesado por un **Mapper**.
* Mappers suelen ejecutarse en el nodo donde reside el bloque (*data locality*).
* Generan pares clave-valor intermedios.

#### 2. **Shuffle and Sort**

* Reorganiza y agrupa los datos por clave.
* Los datos intermedios son transferidos a los nodos donde se ejecutarán los Reducers.
* Es un paso costoso en red, pero esencial para agrupar las claves.

#### 3. **Reduce**

* Cada **Reducer** procesa todas las claves asignadas.
* Combina, suma, cuenta o realiza la operación deseada.
* Genera la salida final, que se guarda normalmente en HDFS.

---

## 4. Comparativa

| MapaReduce V1                     | YARN (V2)                             |
| --------------------------------- | ------------------------------------- |
| Solo Batch                        | Batch + streaming + ML                |
| Mala escalabilidad (>5000 nodos)  | Escala a miles de nodos sin problemas |
| Gestión centralizada (JobTracker) | Gestión distribuida (RM + AM)         |
| Solo MapReduce                    | Admite Spark, Hive, Flink…            |

---

## 5. Prácticas recomendadas

| Práctica       | Qué Aprenderás                                                                              |
| -------------- | ------------------------------------------------------------------------------------------- |
| **Práctica 8** | Configuración de YARN, asignación de recursos, y cómo lanzar trabajos MapReduce sobre YARN. |
| **Práctica 9** | MapReduce con WordCount |
| **Práctica 10** | MapReduce con "Contar palabras.java" |

---

## 6. ¿Por qué YARN mejora MapReduce?

En **V1**, todo dependía del JobTracker, creando un *cuello de botella*.
En **V2 (YARN)**:
  * El ResourceManager solo asigna recursos.
  * Cada ApplicationMaster gestiona su propia aplicación ➔ paralelismo y escalabilidad.

Además, frameworks modernos como **Apache Spark** se ejecutan sobre YARN, aprovechando su gestión de recursos pero sin estar atados al viejo modelo MapReduce.

---

## 7. Resumen visual

```
MapReduce V1:
 [JobTracker] ---> [TaskTrackers]
  (Gestión + Computación juntas)

YARN (MapReduce V2):
 [ResourceManager] ---> [NodeManagers]
        |
   [ApplicationMaster]
        |
     [Map & Reduce Tasks]
```

<div align="center">
<img src="../../img/hadoop/hadoop_MapReduce.png" alt="HadoopMapReduce" 
width="80%" />
</div>
