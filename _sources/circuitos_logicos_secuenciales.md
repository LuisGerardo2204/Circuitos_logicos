---
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.11.5
    language: es
kernelspec:
  display_name: Octave
  language: Octave
  name: Octave
---

# Circuitos lógicos secuenciales

En los temas anteriores hemos estudiado la lógica combinacional, la lógica combinacional permite la construcción de bloques complejos a través de estructuras básicas más simples para conseguir sistemas digitales para un propósito específico. En muchos sistemas digitales se hace necesario el almacenamiento de información. El contar con elementos que almacenan información permite realizar secuencias de operaciones más flexibles e incluso adaptables. A los circuitos que permiten almacenar información en forma de bits se les conoce como circuitos secuenciales.

La estructura clásica de un circuito secuencial comprende la interconexión de un circuito combinacional con elementos de almacenamiento, el almacenamiento, es por supuesto de información de naturaleza binaria o de bits como se muestra en la {numref}`cs1`. Un circuito lógico secuencial recibe información en forma de datos binarios  a través de las entradas. Estas entradas, junto con el estado actual de los elementos de almacenamiento, determinan el valor binario de la o las salidas.


```{figure} /images/secuencial.png
:height: 200px
:name: cs1
Diagrama de bloques de un circuito lógico secuencial ({cite:t}`Mano2005`).
```

Hay dos tipos principales de circuitos secuenciales o con capacidad de almacenamiento de información. Esta clasificación se realiza con base en el momento en el que se observan las entradas y los cambios en su estado interior. Una clasificación general es la siguiente:

* **Circuitos lógicos secuenciales síncronos:** En estos sistemas digitales el comportamiento se define a partir del conocimiento de sus señales en instantes específicos o discretos de tiempo como se muestra en la {numref}`cs2`.

* **Circuitos lógicos secuenciales asíncronos:** En estos circuitos, el comportamiento final no depende solo de las entradas, sino también del orden en que estas cambian o evolucionan en el tiempo.

Los elementos de almacenamiento empleados en los circuitos secuenciales con entrada de reloj se denominan ``flip-flops``. Un flip-flop es un dispositivo de almacenamiento binario capaz de almacenar un bit de información y presenta un conjunto de parámetros que son del tipo temporal. Los flip-flops suelen recibir sus entradas directamente de un circuito combinacional y presentan una entrada de reloj, esta señal de reloj es generalmente un pulso de tipo cuadrado con 

```{figure} /images/secuencial_sincrono.png
:height: 200px
:name: cs2
Diagrama de bloques de un circuito secuencial síncrono ({cite:t}`Mano2005`).
```

## Latches

El latch es el elemento básico de alamacenamiento, toda vez que permite realizar la operación básica de enclavamiento

```{figure} /images/latch.png
:height: 200px
:name: latch
Diagrama lógico de un latch RS.
```
* **Tabla de verdad:** Una tabla de verdad indica las combinaciones de las variables de entrada para las cuales la función de salida es igual a un "1" lógico, Por ejemplo:

```{list-table} Tabla de verdad del latch RS
:header-rows: 1
:align: left
:name: tabla_RS

* - **$S$**
  - **$R$**
  - **$Q$**
  - **$\overline{Q}$**
  - **Estado**
* - 1 
  - 0
  - 1
  - 0
  - Set
* - 0
  - 0
  - 1
  - 0
  - Set
* - 0
  - 1
  - 0
  - 1
  - Reset
* - 0
  - 0
  - 0
  - 1
  - Reset
* - 1
  - 1
  - 0
  - 0
  - Indefinido
```
El código en VHDL para la descripción de un latch RS hecho con compuertas NOR se presenta a continuación:

``` VHDL
--------------------------------
-- Latch RS en VHDL  
-------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_SR is
    Port ( S : in    STD_LOGIC;
           R : in    STD_LOGIC;
           Q : out   STD_LOGIC);
end latch_SR;

architecture arq of latch_SR is
signal Q2   : STD_LOGIC;
signal notQ : STD_LOGIC;
begin

Q    <= Q2;
Q2   <= R nor notQ;
notQ <= S nor Q2;

end arq;
```
La salida de la simualción en Vivado es la siguiente:

```{figure} /images/salida_RS.png
:height: 300px
:name: sRS
Simulación de la salida del Latch RS en vivado.
```
Una alternativa diferente para describir el mismo circuito lógico de almacenamiento se presenta abajo

``` VHDL
--------------------------------
-- Latch RS en VHDL, opción2
-------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_RS is
    Port ( S : in    STD_LOGIC;
           R : in    STD_LOGIC;
           Q : inout STD_LOGIC); -- En este caso, las salidas son bi-direccionales
end latch_RS;

architecture arq of latch_RS is
signal notQ : STD_LOGIC;
begin

Q    <= R nor notQ;
notQ <= S nor Q;

end arq;
```
La salida de la simulación en Vivado se muestra en la siguiente figura:

```{figure} /images/salida_RS_2.png
:height: 300px
:name: sRS2
Simulación de la salida del Latch RS en vivado.
```

Una segunda configuración para la generación de un latch SR es usando compuertas NAND, en una configuración que se conoce com contraface. Su descripción difiere del latch RS construido con compuertas NOR en el hecho de que se expresa de forma inversa la entrada Set y la Reset como se muestra en la {numref}`latch_NAND`. El latch NAND, tambien se denomina $\overline{S}\overline{R}$ porque exige una señal $0$ para cambiar su estado. La barra sobre las letras indica el hecho de que las entradas deben estar complementadas para actuar sobre el estado del circuito.


```{figure} /images/latch_NAND.png
:height: 200px
:name: latch_NAND
Diagrama lógico de un latch RS con compuertas NAND.
```

* **Tabla de verdad:** Una tabla de verdad indica las combinaciones de las variables de entrada para las cuales la función de salida es igual a un "1" lógico, Por ejemplo:

```{list-table} Tabla de verdad del latch SR con compuertas NAND
:header-rows: 1
:align: left
:name: tabla_RS_NAND

* - **$S$**
  - **$R$**
  - **$Q$**
  - **$\overline{Q}$**
  - **Estado**
* - 0 
  - 1
  - 1
  - 0
  - Set
* - 1
  - 1
  - 1
  - 0
  - Set
* - 1
  - 0
  - 0
  - 1
  - Reset
* - 1
  - 1
  - 0
  - 1
  - Reset
* - 0
  - 0
  - 1
  - 1
  - Indefinido
```


El funcionamiento de los latches básicos NOR y NAND puede modificarse añadiendo una entrada de control adicional que determina cuándo debe cambiar el estado del latch. En la {numref}`latch_NAND_c` se muestra un latch $SR$ con una entrada de control consiste en un latch NAND básico y dos compuertas NAND adicionales. Como lo muestra el diagrama lógico, la entrada adicional $C$ se comporta como una señal habilitadora para las entradas $R$ y $S$. 


```{figure} /images/latch_NAND_c.png
:height: 200px
:name: latch_NAND_c
Diagrama lógico de un latch RS con compuertas NAND y entrada de control``
```


Las salidas de las compuertas NAND permanecen en un nivel lógico $1$ siempre que se cumpla que la entrada de control $C=1$. Esta es una condición que permite almacenar el dato. Cuando la entrada de control $C$ se encuentra en un valor de $1$ lógico, la información o el valor lógico de las entradas $S$ y $R$ afectan dorectamente al latch. El estado set, se alcanza cuando se cumplen las condiciones $S=1$, $R=0$ y $C=1$. Para cambiar al estado reset, las condiciones o valores lógicos de las entradas deben ser tales que: $S=0$, $R=1$ y $C=1$. En cualquier otro caso, cuando $C=0$, el circuito permanece eb su estado actual, por lo tanto, se entiende que la entrada de control $C$ activa o desactiva al circuito. Finalmente, si $C=1$ y las entradas $R$ y $S$ son iguales a cero lógico, el estado del circuito no cambia, como se muestra en la {numref}`tabla_RS_c`.


```{list-table} Tabla de verdad del latch SR con compuertas NAND y entrada de control
:header-rows: 1
:align: left
:name: tabla_RS_c

* - **$C$**
  - **$R$**
  - **$S$**
  - Estado siguiente de $Q$
* - 0 
  - **X**
  - **X**
  - Sin cambio
* - 1
  - 0
  - 0
  - Sin cambio
* - 1
  - 0
  - 1
  - $Q=0$: Estado Reset
* - 1
  - 1
  - 0
  - $Q=1$: Estado Set
* - 1
  - 1
  - 1
  - Indefinido o prohibido
```

