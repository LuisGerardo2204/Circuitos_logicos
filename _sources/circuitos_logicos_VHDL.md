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

# Formas de especificar el comportamiento de un circuito lógico 

La función de un circuito lógico es el proporcionar una o varias salidas en función de una varias entradas, con dos posibles estados uno "1" y cero "0" lógicos. Las maneras de representar la interacción de las entradas para producir la o las salidas deseadas se establecen por medio de ecuaciones booleanas o tablas de verdad. A partir de las expresiones booleanas o las tablas de verdad, se aplican métodos de optimización o simplificación de funciones para obeter las salidas o comportamientos deseados con base en expresiones con el menor número de operaciones y variables involucradas.

* **Tabla de verdad:** Una tabla de verdad indica las combinaciones de las variables de entrada para las cuales la función de salida es igual a un "1" lógico, Por ejemplo:

```{list-table} Tabla de verdad
:header-rows: 1
:align: left
:name: tabla1

* - X
  - Y
  - Z
  - F
  - Minitérmino
* - 0 
  - 0
  - 0
  - 0
  - $m_0$
* - 0
  - 0
  - 1
  - 0
  - $m_1$
* - 0
  - 1
  - 0
  - 1
  - $m_2$
* - 0
  - 1
  - 1
  - 0
  - $m_3$
* - 1
  - 0
  - 0
  - 1
  - $m_4$
* - 1
  - 0
  - 1
  - 1
  - $m_5$
* - 1
  - 1
  - 0
  - 1
  - $m_6$
* - 1
  - 1
  - 1
  - 0
  - $m_7$
```
* **Suma de miniterminos:** El formato de suma de minitérminos es una manera compacta de especificar circuitos lógicos en forma de una ecuación en forma de sumatoria, por ejemplo, para el circuito lógico descrito por la tabla de verdad anterior se tiene la suma de minitérminos:

$$
F=\sum(m_2,m_4,m_5,m_6)
$$ 

* **Expresión booleana:** La expresión booleana se describe mendiante una expresión del álgebra de Boole, por ejemplo, para el caso que se está usando como ejemplo:

$$
F=\overline{X}Y\overline{Z}+X\overline{Y}~\overline{Z}+X\overline{Y}Z+XY\overline{Z}
$$

* **Diagrama esquemático:** Otra forma de especificar un circuito lógico es por medio de un diagrama esquemático, es decir, por medio del diagrama de conexiones de las compuertas lógicas que lo conforman. Por ejemplo, para la función definida por la tabla de verdad {numref}`tabla1`:

```{figure} /images/diagrama1.png
:height: 300px
:name: cl1
Circuito lógico de la función F.
```
La simplificación de la función permite realizar un circuito más sencillo. Utilizando manipulación algebraica se obtiene:

$$
F=(\overline{X}Y+XY)\overline{Z}+X\overline{Y}(Z+\overline{Z})
$$
$$
F=((\overline{X}+X)Y)\overline{Z}+X\overline{Y}
$$
$$
F=Y\overline{Z}+X\overline{Y}
$$

```{figure} /images/diagrama2.png
:height: 150px
:name: cl2
Circuito lógico simplificado de la función F.
```
Una tercer forma de especificar o describir un circuito lógico es utilizando un lenguaje especial y estandarizado. Un lenguaje de descripción muy utilizado es VHDL, cuyas siglas provienen de (Very High Speed Integrated Circuits) Hardware Description Language, por abreviación se utilizan las siglas VHDL.   

## Breve introducción a VHDL

VHDL es un lenguaje de descripción de circuitos electrónicos digitales que utiliza distintos niveles de abstracción. El lenguaje VHDL utiliza una sintaxis poco usual para describir los circuitos lógicos {cite:t}`Tocci2017`. La razón principal de ello es que VHDL se pensó originalmente como un lenguaje para la documentación y simulación de circuitos, no para describir los circuitos para la síntesis.

Es muy útil tener en consideración, como punto de partida, que un circuito o subcircuito descrito mediante VHDL se denomina diseño de entidad (design entity). Una entidad o circuito descrito está compuesto por dos partes principales: 
* La declaración de la entidad, `entity`:donde se declaran las señales de entrada y salida, por lo tanto es el modelo de comunicación o interconexión con el exterior.
* La arquitectura, `architecture`: donde se definen los detalles del circuito, es decir, es la especificación del funcionamiento de una entidad.
  
Aunado a esto, están las bibliotecas, `libraries`, donde se almacenan los elementos de
diseño: tipos de datos, operadores, componentes, funciones, etc. Hay dos bibliotecas que siempre son visibles por defecto: `std` (la estandard) y `work` (la de trabajo) y que no es necesario declarar.
Los elementos de las librerías se organizan en paquetes (Packages) y hay que declararlos para poder utilizarlos.

Los lenguajes de descripción hardware son parecidos a los lenguajes de programación, pero
están más orientados a describir estructuras hardware y sus comportamientos. Se distinguen
fundamentalmente de los lenguajes de programación en que describen operaciones en paralelo
mientras que la mayoría de los lenguajes de programación describen operaciones secuenciales.
Una aplicación obvia para los lenguajes de descripción hardware es proporcionar una alternativa
a los esquemáticos {cite:t}`Mano2005`. Cuando el lenguaje se emplea de esta manera para describir una interconexiónde componentes, se denomina descripción estructural. La descripción estructural se emplea como entrada en la simulación lógica tal y como se haría con un diagrama esquemático. Para poder llevar a cabo esto, es necesario disponer de modelos para cada primitiva. Si se emplea un HDL, entonces estos modelos pueden también escribirse en dicho HDL, con lo que se logra una representación más uniforme y portable para la simulación.


## Representación de datos en VHDL

Como hemos estudiado al principio del curso, los datos numéricos se pueden representar de varias maneras, por ejemplo, el uso del sistema numérico hexadecimal como una manera conveniente de comunicar conjuntos de bits que se traducen en patrones, caracteres o palabras. Las computadoras y los sistemas digitales sólo pueden operar con información binaria (unos y ceros lógicos). Cuando se escribe en HDL, a menudo
necesita utilizar estos distintos formatos de números y la computadora debe poder para entender qué sistema numérico estamos usando. Por ejemplo, $101101_2$ representa binario, $101101_{16}$ representa hexadecimal y $101101$ significa que está expresado en decimal. Cada lenguaje de programación y HDL tiene su propia forma única de identificar los distintos números sistemas, generalmente hecho con un prefijo para indicar el sistema numérico. En la mayoría de los idiomas, se supone que un número sin prefijo es decimal. Cuando Si leemos una de estas designaciones numéricas, debemos pensar en ella como un símbolo.
que representa un patrón de bits binarios. Estos valores numéricos se denominan como escalares o literales. La {numref}`tabla2` resume los métodos para especificar valores en binario, hexadecimal y decimal para VHDL.

```{list-table} Tabla de representaciones
:header-rows: 1
:align: left
:name: tabla2

* - Sistema numérico
  - VHDL
  - Patrón de bits
  - Equivalente decimal
* - Binario
  - B '0100'
  - 0100
  - 4
* - Hexadecimal
  - X '0100'
  - 0000100
  - 4
```

Por ejemplo para expresar el patron de bits $10101$ en sus equivalentes binario, hexadecimal y decimal usando notación de VHDL se procede de la siguienete manera:

* En binario la representación de VHDL es **B '10101'**.
* Al convertir el binario a hexadecimal se obtiene: $10101=15_{16}$
* En VHDL el hexadecimal se representa como: **X '15'**
* El equivalente decimal es $10101=15_{16}=21_{10}$
* el decimal en VHDL se expresa de la misma forma: **25**.





 


