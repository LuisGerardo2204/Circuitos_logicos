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
El código VHDL para la descripción de un latch $\overline{S}\overline{R}$, elaborado con compuertas NAND se muestra a continuación:


``` VHDL
-------------------------------------------
-- Latch RS en VHDL, con compuertas NAND
------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_SR is
    Port ( R : in    STD_LOGIC;
           S : in    STD_LOGIC;
           Q : out   STD_LOGIC);
end latch_SR;

architecture arq of latch_SR is
signal Q2   : STD_LOGIC;
signal notQ : STD_LOGIC;
begin

Q    <= Q2;
Q2   <= S nand notQ;
notQ <= R nand Q2;

end arq;
```
La salida de la simulación en Vivado se muestra en la siguiente figura:

```{figure} /images/salida_RS_nand.png
:height: 300px
:name: sRSnand
Simulación de la salida del Latch RS en vivado.
```


El funcionamiento de los latches básicos NOR y NAND puede modificarse añadiendo una entrada de control adicional que determina cuándo debe cambiar el estado del latch. En la {numref}`latch_NAND_c` se muestra un latch $SR$ con una entrada de control consiste en un latch NAND básico y dos compuertas NAND adicionales. Como lo muestra el diagrama lógico, la entrada adicional $C$ se comporta como una señal habilitadora para las entradas $R$ y $S$. 


```{figure} /images/latch_NAND_c.png
:height: 200px
:name: latch_NAND_c
Diagrama lógico de un latch RS con compuertas NAND y entrada de control
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
  - 1
  - 0
  - $Q=0$: Estado Reset
* - 1
  - 0
  - 1
  - $Q=1$: Estado Set
* - 1
  - 1
  - 1
  - Indefinido o prohibido
```
El código VHDL para la descripción de un latch $\overline{S}\overline{R}$, son entrada de control $C$, elaborado con compuertas NAND se muestra a continuación:


``` VHDL
-------------------------------------------
-- Latch RS en VHDL, con compuertas NAND 
-- Y entrada de control
------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_SR is
    Port ( R : in    STD_LOGIC;
           S : in    STD_LOGIC;
           C:  in    STD_LOGIC;
           Q : out   STD_LOGIC;
        notQ : out   STD_LOGIC);
end latch_SR;

architecture arq of latch_SR is
signal Q2   : STD_LOGIC;
signal noQ : STD_LOGIC;
begin

Q    <= Q2;
Q2   <= (S nand C) nand noQ;
noQ <= (R nand C) nand Q2;
notQ <= noQ;
end arq;
```

La salida de la simulación en Vivado se muestra en la siguiente figura:

```{figure} /images/salida_RS_nand_c.png
:height: 300px
:name: latch_Rs_NAND_c
Simulación de un latch RS con compuertas NAND y entrada de control
```
## Latch D

El latch D, es el más comun de los elementos de almacenamiento binario, dado su funcionamiento transparente. Una manera de eliminar el estado indefinido no deseable en el latch SR es asegurar que las entradas S y R nunca sean iguales a 1 al mismo tiempo. Esto se consigue con el latch D de la {numref}`latch_NAND_D`. Este latch sólo tiene dos entradas: $D$ (dato) y $C$ (control). Si la entrada de control es $0$ lógico, el latch tiene ambas entradas a nivel $1$ lógico, y el circuito no puede cambiar de estado, sin importar el valor de la entrada $D$.

```{figure} /images/latch_NAND_D.png
:height: 200px
:name: latch_NAND_D
Diagrama lógico de un latch D con compuertas NAND
```
La tabla de verdad para el latch D se muestra en la {numref}`tabla_latch_D`. El latch D recibe su nombre de su capacidad para retener el dato en su interior. La información binaria presente en la entrada de datos del latch D se transfiere a la salida $Q$ cuando se habilita con un $1$ lógico la entrada de control. La salida sigue a los cambios en la entrada de datos, con tal de que la entrada de control esté habilitada. Cuando se deshabilita la entrada de control $0$ lógico, la información
binaria que estaba presente en la entrada de datos en el momento de la transición se retiene en la salida $Q$ hasta que la entrada de control vuelva a habilitarse.

```{list-table} Tabla de verdad del latch SR con compuertas NAND y entrada de control
:header-rows: 1
:align: left
:name: tabla_latch_D

* - **$C$**
  - **$D$**
  - Estado siguiente de $Q$
* - 0 
  - **X**
  - Sin cambio
* - 1
  - 0
  - $Q=0$: Estado Reset
* - 1
  - 1
  - $Q=1$: Estado Set
```
El código VHDL del latch D con entrada de control se muestra abajo:

``` VHDL
-------------------------------------------
-- Latch D en VHDL, con compuertas NAND 
-- Y entrada de control
------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_D is
    Port ( D : in    STD_LOGIC;
           C:  in    STD_LOGIC;
           Q : out   STD_LOGIC;
        notQ : out   STD_LOGIC);
end latch_D;

architecture arq of latch_D is
signal Qaux   : STD_LOGIC;
signal noQ : STD_LOGIC;
signal S : STD_LOGIC;
signal R : STD_LOGIC;
begin

Q    <= Qaux;
S <= D nand C;
Qaux  <= S nand noQ;
R <= not (D) nand C;
noQ  <= R nand Qaux;
notQ <= noQ;

end arq;
```

La salida de la simulación en Vivado se muestra en la siguiente figura:

```{figure} /images/salida_D.png
:height: 300px
:name: salida_latch_D
Simulación de un latch D con compuertas NAND y entrada de control
```

## Flip-flops

El estado de un latch en un flip-flop puede cambiar cuando hay un cambio, aun  momentáneo en el  valor de la entrada de control. Este cambio se denomina disparp El latch D con pulsos de reloj en su entrada de control se dispara cada vez que aparece un pulso con valor $1$ lógico. Mientras que el pulso permanezca en el nivel activo $1$, cualquier cambio en la entrada de datos cambiará el estado del latch. En este sentido, como ya se mencionó, el latch es transparente, ya que su valor de entrada puede verse directamente en la salida. Cuando los latches se emplean como elementos de almacenamiento aparece uninconveniente de consideracióna. Las transiciones de estado de los latches empiezan en cuanto  el pulso de reloj cambia al nivel $1$  lógco.  Un nuevo estado aparece en la salida del latch mientras el pulso todavía esté activo. Esta salida está conectada a las entradas de algunos otros latches mediante un circuito combinacional. Si las entradas aplicadas a los latches cambian mientras el pulso de reloj todavía esten en un valor $1$ lógico los latches responderán a los nuevos valores de estado de los otros latches en lugar de a los valores de estado originales, y aparecerán una sucesión de cambios de estado en lugar de uno solo. El resultado es una situación no determinínstica o impredecible.

Para resolver este problema, los latches suelen combinarse para formar un flip-flop. Una manera es combinar dos latches de manera tal que las entradas se presenten al flip-flop cuando haya un pulso de reloj en su estado de control y la otra manera es forzando a que el estado del flip-flop cambie solo en ausencia del pulso de reloj. Un circuito lógico de esta naturaleza se conoce como flip-flip maestro-esclavo. Una alternativa más para crear un flip-flop es diseñarlo de tal manera que solo se dispare durante una transición o cambio de $0$ a $1$ o de $1$ a $0$ lógico. A esta configuración se le conoce como flip-flop disparado por flanco.

## Flip-flop maestro-esclavo

En la {numref}`ff_maestro_esclavo` se muestra un flip-flop SR maestro-esclavo formado por dos latches y un inversor.

```{figure} /images/ff_maestro_esclavo.png
:height: 200px
:name: ff_maestro_esclavo
Flip-fliop maestro-esclavo con latches SR
```
El código VHDL del latch RS en su configuración maestro-esclavo se muestra abajo:

``` VHDL
-------------------------------------------
-- Latch RS maestro-esclavo
------------------------------------------
-------------------------------------------
-- Latch RS en VHDL, con compuertas NAND 
-- Y entrada de control
------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_SR is
    Port ( S : in    STD_LOGIC;
           C : in    STD_LOGIC;
           R:  in    STD_LOGIC;
           Q : out   STD_LOGIC;
        notQ : out   STD_LOGIC);
end latch_SR;

architecture arq of latch_SR is
signal Q2   : STD_LOGIC;
signal noQ : STD_LOGIC;
begin
Q    <= Q2;
Q2   <= (S nand C) nand noQ;
noQ <= (R nand C) nand Q2;
notQ <= noQ;
end arq;
---------------------------------------------------
-- Se describe la entidad flip-flop RS
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity ff_RS is
Port ( S : in STD_LOGIC;
       C : in STD_LOGIC;
       R : in STD_LOGIC;
       Q : out STD_LOGIC;
       notQ : out STD_LOGIC);
end ff_RS;
 
architecture arq of ff_RS is
-- Declaración del uso del latch RS
-- como bloque básico
component latch_SR
 Port (    S : in    STD_LOGIC;
           C : in    STD_LOGIC;
           R:  in    STD_LOGIC;
           Q : out   STD_LOGIC;
        notQ : out   STD_LOGIC);
end component;
 
-- Señales intermedias
signal Y,noY: STD_LOGIC;
signal noC: STD_LOGIC ; 
begin
noC <= not(C);

-- Mapeo de puertos
latch1: latch_SR port map(S,C,R,Y,noY); 
latch2: latch_SR port map(Y,noC,noY,Q,notQ);

end arq;
```
El circuito lógico sintetizado es el siguiente:

```{figure} /images/ff_RS_sintesis.png
:height: 300px
:name: ff_RS_sintesis
Sintesis en vivado de un flip-flop RS maestro-esclavo
```
Es posible observar que en el bloque se encuentra incluido un latch RS a nivel compuerta:

```{figure} /images/ff_RS_sintesis_detalle.png
:height: 300px
:name: ff_RS_sintesis_detalle
Sintesis en vivado de un flip-flop RS maestro-esclavo
```

El test bench para el flip-flop maestro-esclavo es el siguiente:

```VHDL
------------------------------------------------
-- Testbench o archivo banco de pruebas 
--    para el flip-flop RS maestro-esclavo
-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ff_test is
end ff_test; -- Cuando se escribe un archivo
-- para pruebas se usa una entidad vacía

architecture arq_test of ff_test is

--------------------------------------------------------------
----- Se usa una estructura para 
---   declarar o invocar a la entidad o circuito
---   lógico bajo prueba con todas sus entradas y salidas
---------------------------------------------------------------
 component ff_RS  is
Port ( S : in STD_LOGIC;
       C : in STD_LOGIC;
       R : in STD_LOGIC;
       Q : out STD_LOGIC;
       notQ : out STD_LOGIC);
 end component;
---------------------------------------------------------------------- 
    -- Señales internas  
  -- usadas para la simulación
  signal test_S: std_logic; 
  signal test_C: std_logic; 
  signal test_R: std_logic; 
  signal test_Q: std_logic;
  signal test_noQ: std_logic;
----------------------------------------------------------------------
begin
-----------------------------------------------------------------
-- En esta parte se declara el circuito lógico bajo prueba
------------------------------------------------------------------
   DUT: ff_RS -- Entidad bajo prueba Design Under Test (DUT)
   port map(R => test_R,
            C => test_C,
            S => test_S,
            Q => test_Q,
           notQ => test_noQ);
------------------------------------------------------
   process
      begin
           test_R <= '0'; -- Parte inicial de la prueba
           test_S <= '0';
           test_C <= '0';
           wait for 50 ns; -- Se genera un retardo, 
           test_R <= '0';
           test_S <= '0';
           test_C <= '1'; -- La señal C alterna entre 0 y 1 
           wait for 50 ns;-- Para emular a un reloj
           test_R <= '0'; 
           test_S <= '1';
           test_C <= '0';
           wait for 50 ns; 
           test_R <= '0'; 
           test_S <= '1';
           test_C <= '1';
           wait for 50 ns;
           test_R <= '0'; 
           test_S <= '1';
           test_C <= '0';
           wait for 50 ns; 
           test_R <= '0'; 
           test_S <= '0';
           test_C <= '1';
           wait for 50 ns;  
           test_R <= '1'; 
           test_S <= '0';
           test_C <= '0';
           wait for 50 ns;  
           test_R <= '1'; 
           test_S <= '0';
           test_C <= '1';
           wait for 50 ns; 
           test_R <= '0'; 
           test_S <= '1';
           test_C <= '0';
           wait for 50 ns;
           test_R <= '0'; 
           test_S <= '1';
           test_C <= '1';
           wait for 50 ns;-- El ciclo se repite a partir de aquí           
     end process;  
end arq_test;
```
La salida de la simulación en Vivado se muestra en la siguiente figura:

```{figure} /images/salida_ff_RS.png
:height: 300px
:name: salida_ff_RS
Simulación de un flip-flop RS maestro-esclavo
```
## Flip-flops disparados por flancos

Un flip-flop disparado por flanco es un circuito lógico secuencial que ignora a la señal de reloj mientras está en un nivel constante y sólo realiza un cambioa durante una transición de la señal de reloj, este cambio se conoce tambien como un disparo del flip-flop.

Un flip-flop D maestro-esclavo puede construirse a partir de un flip-flop SR maestro-esclavo al reemplasar al latch RS de la entrada por un latch D como los estudiados anteriormente, como se muestra en la {numref}``ff_D_negativo``, este elemento secuencial se activa cuando la señal de reloj trancisiona de $1$ a $0$ lógico, lo que se conoce como un flanco de bajada de señal o flanco negativo.

```{figure} /images/ff_maestro_esclavo_D.png
:height: 200px
:name: ff_D_negativo
Flip-flop disparado por flanco negativo
```
Un flip-flop disparado o activado por flanco positivo, es decir, cuando la señal de reloj $C$ transiciona de $0$ a $1$ lógico se obtiene con la modificaión al circuito mostrado en la  {numref}``ff_D_negativo`` para obtener el diagrama lógico mostrado en la {numref}``ff_D_positivo``. 

```{figure} /images/ff_maestro_esclavo_D_positivo.png
:height: 200px
:name: ff_D_positivo
Flip-flop disparado por flanco positivo
```

