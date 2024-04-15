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

# Tipos de datos en VHDL

Una parte muy importante del lenguaje de descripción VHDL es el uso de datos y objetos. A un objeto de datos se le pueden asignar valores que son denominados “datos”. La naturaleza y finalidad de cada objeto de datos es muy importante en VHDL y se le debe asignar un "tipo" específico. Ejemplos de Los objetos de datos son señales, variables y constantes. Las señales son como cables en un circuito de hardware que pueden tener un valor de 1 o 0 conectado a ellos. Sin embargo, a diferencia de los cables en un circuito, el valor de una señal será “recordado” hasta que se actualice explícitamente. Una señal a la que se le ha asignado un valor permanecerá en ese valor a menos que se le asigne un valor diferente. El operador utilizado para asignar un valor a una variable o señal en VHDL es `<=`.

Las variables en VHDL son similares a las variables de cualquier otro lenguaje de programación 
Son entendibles como un almacen para un valor hasta el siguiente momento o evento, en el cual es necesario que su valor cambia. Las variables siempre se declaran y modifican dentro
un proceso. El operador utilizado para asignar un valor a una variable es `:=`. Las constantes son simplemente nombres que se asignan permanentemente para representar un valor. Esta práctica puede hacer que el código sea mucho más fácil de entender. A cada objeto de datos se le debe asignar un "tipo" de datos. Los tipos de datos incluidos en VHDL son `BIT`, `BIT_VECTOR` e `INTEGER`. Un `BIT` puede tener valores de '0' o '1'. Un `BIT_VECTOR` es un grupo de bits, cada uno de los cuales puede tener un valor de '0' o '1'. Un `INTEGER` puede tener cualquier valor entero con signo (es decir, -3, -2, -1, 0, 1, 2, etc). VHDL es muy particular en cuanto a las definiciones de cada tipo de objetos de datos. El tipo "bit_vector" describe una matriz de bits individuales. Esto es interpretado de manera diferente que un número binario de ocho bits (llamado escalar), que tiene el tipo entero. Como una desventaja, VHDL no permite asignar un valor entero a una señal `BIT_VECTOR` directamente porque no son el mismo "tipo". Los datos pueden representarse se muestran en la {numref}`tabla3`. Es necesario tomar en cuenta que el compilador no permitirá tomar un número de un teclado declarado como un número entero y conectarlo a
cuatro LEDs que se declaran como salidas `BIT_VECTOR`. Observe en la {numref}`tabla3`, en Valores posibles, los objetos de datos `BIT` y `STD_LOGIC` individuales (por ejemplo, señales, variables, entradas y salidas) se designan entre comillas simples, mientras que los valores asignados a los tipos `BIT_VECTOR` y `STD_LOGIC_VECTOR` son cadenas de valores de bits válidos entre comillas dobles.


```{list-table} Tipos de datos en VHDL
:header-rows: 1
:align: left
:name: tabla3

* - Tipo de dato
  - Declaración
  - Valores posibles
  - Ejmeplo de uso
* - `BIT` 
  -  w :OUT_BIT
  -  '0' '1'
  -  w <= '0'
* - `STD_LOGIC`
  - driver: STD_LOGIC
  - '0' '1' 'z' 'x' '-'
  -  driver <='1'
* - `BIT_VECTOR`
  - dato_dato :BIT_VECTOR(3 DOWNTO 0); 
  - '0110' '1001' '1111'
  - digito <= dato_bcd 
* - `STD_LOGIC_VECTOR`
  - busd :STD_LOGIC_VECTOR(3 DOWNTO 0);
  - ''0Z1X''
  - IF rd= '0' THEN busd <= 'zzz'
* - `INTEGER` 
  - y :INTEGER RANGE -10 TO 10
  - -10...-1,0,1,2...10
  - IF z > 5 THEN...
```
Cuando se estandarizó VHDL a través del IEEE, muchos tipos de datos fueron creados al mismo tiempo. Los más utilizados son `STD_lOGIC`, que es una expansión del tipo `BIT`, y `STD_LOGIC_VECTOR`,
que es una expansión del `BIT_VECTOR`.  Los valores posibles para un tipo `STD_LOGIC` o para cualquier elemento en un `STD_LOGIC_VECTOR` se dan en la {numref}`tabla4`. Por ahora, mostraremos ejemplos usando valores de solo '1' y '0' lógicos.

```{list-table} Tipos de valores STD
:header-rows: 0
:align: left
:name: tabla4

* - '1'
  -  **1** lógico 
* - '0' 
  -  **0** lógico
* - 'z'
  - Alta impedancia
* - '-'
  - Indiferente (don't care); 
* - 'U'
  - No inicializado
* - 'X' 
  -  Indeterminado
* - 'W' 
  -  Indeterminad
* - 'L'  
  -  0 débil
* -  'H'
  - 1 débil

```

# Representación de tablas de verdad en VHDL

Como primer ejemplo, reperesentaremos una tabla de verdad para una función $F(X,Y,Z)$. Una tabla de verdad permite al diseñador especificar el funcionamiento del circuito, como se menciona en la introducción. Usaremos la tabla de verdad especificada en La {numref}`tabla1`. El punto principal
de este ejemplo es dar una introducción a VHDL. Las entradas se definen en la declaración `ENTITY` como tres entradas independientes  $X$, $Y$ y $Z$. Si se elabora una tabla de verdad, primero se decide que bit colocar a la derecha (LSB) y cuál colocar a la izquierda (MSB). El operador de concatenación es
“&”. Una señal se declara como `BIT_VECTOR` para recibir el conjunto ordenado de bits de entrada y se utiliza para comparar el valor de la entrada con las literales de cadena contenida entre comillas. A la salida $F$ se le asigna `<=` un valor de bit '0' o '1'. VHDL es muy estricto en la forma en que nos permite asignar y comparar objetos. como señales, variables, constantes y literales. La salida $F$ es un `BIT`, y por lo que se le debe asignar un valor de '0' o '1'. La señal in_bits es de tres bits.

``` VHDL
--------------------------------------------------------------------
--- Ejemplo de una tabla de verdad en VHDL
--------------------------------------------------------------------

entity funcion is
    Port ( X,Y,Z :IN BIT;  -- X es el bit más significativo
           F :OUT BIT);
end funcion;

architecture tabla_verdad of funcion is

signal bits_entrada :BIT_VECTOR(2 DOWNTO 0);

begin
bits_entrada <= X & Y & Z; -- Se concatenan los bits de entrada

with bits_entrada select
              F <= '0' when "000",
                   '0' when "001",
                   '1' when "010",
                   '0' when "011", --Tabla de verdad
                   '1' when "100",
                   '1' when "101",
                   '1' when "110",
                   '0' when "111";
end tabla_verdad;

```
El siguiente video muestra la simulación de la tabla de verdad anterior en vivado.


<div align='center'>
<video controls autoplay muted="true" loop="true" width="600">
    <source src="./_static/videos/video1.mp4 " type="video/mp4">
</video>
</div>



 


