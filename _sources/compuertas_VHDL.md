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

# Compuertas Lógicas en VHDL

El objetivo de esta práctica es aprender a utilizar las compuertas lógicas básicas en VHDL. Las compuertas lógicas son el elemento básico de los sistemas digitales, en la {numref}`tabla5` se resume el comportamiento o salida de la compuertas básicas en funcion de sus entradas.


```{list-table} Tabla de verdad de las compuertas básicas
:header-rows: 1
:align: left
:name: tabla5

* - A
  - B
  - AND
  - OR
  - NAND
  - NOR
  - XOR
  - XNOR
* - **0**
  - **0**
  - 0
  - 0 
  - 1
  - 1
  - 0
  - 1
* - **0**
  - **1**
  - 0
  - 1 
  - 1
  - 0
  - 1
  - 0
* - **1**
  - **0**
  - 0
  - 1 
  - 1
  - 0
  - 1
  - 0
* - **1**
  - **1**
  - 1
  - 1 
  - 0
  - 0
  - 0
  - 1
```
En la figura {numref}`compuertas` se muestra el circuito lógico para la prueba de múltiples compuertas lógicas. el código en VHDL para simular su comportamiento se muestra abajo.

# Formato en el lenguage VHDL y sintaxis

Como cualquier lenguage computacional, VHDL tiene propiedades únicas similares a los lenguajes de programación comunes como C#, Java, Python. De la misma manera en la que se estudia gramática cuando se aprende un lenguaje nuevo, un lenguaje que está destinado para se utilizado en una computadora, requiere reglas específicas de sintaxis. La descripción de circuitos lógicos en su forma básica, involucra los siguientes elementos básicos: 

1. La definición de las entradas y salidas, comúnmente identificadas como puertos, en este punto se especifican sus características particulares.
2. La definición de la manera en que interactúan o cómo responden el sistema digital ante las entradas y sus cambios.

Por ejemplo, considérese el diagrama lógico de una compuerta OR mostrado en la {numref}`compuertaOR`

```{figure} /images/compuerta.png
:height: 150px
:name: compuertaOR
Compuerta OR.
```

Dada la universalidad de la simbología utilizada para describirlo, cualquier ingeniero en sistemas computacionales o electrónica será capaz de interpretarlo, de la misma manera, el lenguaje VHDL tiene un caracter específico e independiente del idioma que hable el ingeniero que lo escribe o interpreta.

```{note}
En un lenguaje de descripicón basado en texto, como lo es VHDL, la descripción del sistema digital se realiza en los siguientes bloques principales:

* **Documentación**: Se incluyen las especificaciones y comentarios concernientes al sistema digital que se está describiendo, también información de la vesrión, datos del autor, fechas, etc. 
* **Definicion de entradas y salidas**: En esta sección se escriben las características de los puertos de entrada y salida del sistema digital, se especifica si son bits o vectores y se especifica si fungen como entradas, salidas o cumplen ambas funciones.
* **Descripción funcional**: En esta parte del código de descripción del Hardware se describe la reacción o proceso que deben tener las entradas para producir la salida deseada o especificada por diseño.
```

Con respecto a la especificación de entradas y salidas de un sistema digital en VHDL, el circuito lógico debe describirse mediante un nombre que se le asigna. Las entradas y salidas deben nombrarse de acuerdo con la naturaleza del puerto al que pertenecen. Resulta de mucha utilidad respoder las siguientes preguntas en el momento en el que se realiza dicha asignación; ¿Se trata de un solo bit, proveniente de un interruptor simple?, ¿Se trata de una entrada compuesta, porveniente de un conjunto de Dip Switch?. El lenguaje de descripción debe mostrar la naturaleza de las entradas y salidas. Por otra parte, el **modo** de un puerto define si se trata de una entrada, una salida o ambas. Si se trata de un solo bit, la entrada o salida solo puede adquirir los valores "0" y "1" lógicos, mientras que si se trata de una entrada tipo Dip Switch como la expuesta anteriormente, al ser de cuatro bits, podrá adquirir 16 valores diferentes, o bien, en binario $0000_2-1111_2$ ({cite:t}`Tocci2017`). 

El siguiente ejemplo ilustra la especificación de un sistema digital simple en VHDL, para el caso particular de una compuerta **OR**. Este ejemplo sirve tambén como la introducción a la lógica booleana en el contexto de VHDL.

``` VHDL
--------------------------------
--Compuerta OR en VHDL  
-- Esta es la parte de la documentación.
-------------------------------
entity compuerta_OR is -- Esta es la parte de la definición de entradas y salidas.
   port(
   X,Y : IN BIT; -- Entradas simples.
   F :OUT BIT -- Salida simple.
   );
end compuerta_OR;

architecture arq of compuerta_OR is
begin 
-- Esta es la descripción funcional.
F <= X OR Y;
end arq; 
```
En el código anterior, la declaración `entity` puede ser vista como un bloque o caja negra con dos entradas y una salida, es decir, existe algo que encierra o agrupa al circuito cuyo comportamiento se trata de describir o especificar. En VHDL, la parlabra reservada `port` le indica al compilador que se están definiendo entradas y salidas a este bloque o caja negra. Los nombres que se asignan a las entradas, se enlistan separadas por comas **,** y se terminan de enlistar usando punto y coma **;**, además de incluir una descripción del modo y tipo de entrada (**:IN BIT**). La declaración `arquitectura` se usa para describir la operación de lo que se encuentra dentro del bloque. Es tarea del diseñador darle un nombre signifiativo que ofrezca información de la naturaleza inherente al sistema digital que se está describiendo. Cada bloque `entity` que se crea, debe tener al menos una descripción `architecture` asociada, de manera que es posible entender que las palabras reservadas **OF** e **IS**, son clave en la declaración del sistema digital. El cuerpo de la arquitectura o bloque `architecture` se encuentra contenida entonces entre las palabras reservadas **BEGIN** y **END**, indicado así los alcances del comportamiento deseado para el sistema digital que se describe como un bloque. El nombre que se ha asignado a la arquitectura, se escribe seguido de la palabra reservada **END** para indicar el término de la descripción. Esta línea de código termina con punto y coma **;**. Dentro del cuerpo de la arquitectura se especifica el comportamiento, contenido entre las palabras reservadas **BEGIN** y **END**. Es importante mencionar que en VHDL, la asignación `<=` se denomina como una asignación **concurrente**, esto significa que todas las sentencias que se encuentran contenidas en la arquitectura, es decir entre las palabras **BEGIN** y **END** se evaluan de forma constante y al mismo tiempo (de forma concurrente), por lo tanto, el orden en que se escriban no hace ninguna diferencia ({cite:t}`Tocci2017`). 
 
## Señales intermedias

A menudo es necesario utilizar puntos de señal o puntos de prueba en los sistemas digitales. Estos puntos de prueba se encuentran dentro del circuito lógico principal del sistema digital, como se muestra en la {numref}`intermedias`.

```{figure} /images/intermedias.png
:height: 250px
:name: intermedias
Señales intermedias en un circuito lógico.
```
En el siguiente código se muestra la descripción del circuito lógico mostrado en la {numref}`intermedias` en el lenguaje VHDL, para fines ilustrativos de lo expuesto referente a las señales intermedias.

``` VHDL
-------------------------------------------
-- Circuito lógico con señales intermedias  
-------------------------------------------
entity circuito_logico is 
   port(
   X,Y,Z : IN BIT; -- Entradas simples.
   F :OUT BIT -- Salida simple.
   );
end circuito_logico;

architecture arq of circuito_logico is

signal f1,f2 : BIT;

begin 

f1 <= NOT X AND Y AND NOT Z;
f2 <= X AND (NOT Y) AND NOT Z;
F <= F1 OR F2;

end arq; 
```
La salida de la simulación en el software vivado que se aprecia en la {numref}`sim_intermedias`  muestra el uso de las señales intermedias y el comportamiento de la salida global **F** del circuito lógico de la {numref}`intermedias`.

```{figure} /images/sim_intermedias.png
:height: 350px
:name: sim_intermedias
Simulación en vivado del código VHDL.
```

# Práctica de compuertas en VHDL

La sintaxis de las compuertas básicas en VHDL se presenta en la siguiente práctica. Considere el circuito lógico de la {numref}`compuertas`, el circuito no cumple ninguna función en particular, simplemente agrupa en el arreglo de bits **F** la salida de las operaciones lógicas básicas aplicadas a las entradas **X** y **Y**. Para generar las combinaciones de las entradas y producir la simulación de una tabla de verdad, se utiliza la instrucción ``Force Clock`` en el software vivado. Al bit más significativo se le asigna el periodo más grande. El periodo asignado al bit más significativo se divide a la mitad según se asigna un reloj para emular la tabla de verdad hasta llegar al bit o señal de entrada menos significativo como se muestra en la {numref}`relojes`.




```{figure} /images/relojes.png
:height: 350px
:name: relojes
Simulación de tablas de verdad usando relojes.
```
Para poner a prueba lo expuesto anteriormente y hacer una práctica relacionada con la especifiación y la sintaxis de las compuertas lógicas en VHDL, se utiliza el diagrama lógico de la {numref}`compuertas` y el código debajo de la misma.


```{figure} /images/diagrama3.png
:height: 450px
:name: compuertas
Simulación de compuertas básicas en VHDL.
```

``` VHDL
--------------------------------
--Compuertas básicas en VHDL
-------------------------------
library IEEE;
use IEEE.std_logic_1164.all; -- Librería para variables lógicas estandard

entity compuertas_basicas is
   port(
   X,Y :in std_logic; -- Entradas simples
   F :out std_logic_vector(8 downto 1) -- Salidas almacenadas en un arreglo
   );
end compuertas_basicas;

architecture arq of compuertas_basicas is

begin 

F(1) <= NOT X; -- Compuerta not
F(2) <= NOT Y; -- Compuerta not
F(3) <= X AND Y; -- Compuerta AND
F(4) <= X NAND Y; -- Compuerta NAND
F(5) <= X OR Y; -- Compuerta OR
F(6) <= X NOR Y; -- Compuerta NOR
F(7) <= X XNOR Y; -- Compuerta XOR
F(8) <= X XOR Y; -- Compuerta XNOR

end arq; 

```
La salida de la simulación del código anterior se muestra en la {numref}`sim_compuertas`


```{figure} /images/sim_compuertas.png
:height: 350px
:name: sim_compuertas
Simulación en vivado del conjunto de compuertas lógicas.
```

 


