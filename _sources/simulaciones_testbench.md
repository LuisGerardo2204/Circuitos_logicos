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

# Uso del testbench o banco de pruebas en simulaciones


Cuando el código necesario para la descripción de un circuito lógico en VHDL ha sido generado correctamente se procede a su simulación por medio de algún software en específico como lo hemos hecho en las secciones anteriores. La prueba del código se lleva a cabo asignando valores de prueba a las entradas del sistema digital desrito. Estos valores de prueba pueden ser constantes o relojes según convenga a la prueba. Existe una manera alternativa para asignar los valores de prueba a las variables o puertos de entrada, esta forma alternativa permite cierta automatización del proceso de simulación, evitando la necesidad de especificar patrones a las entradas haciendo uso de la interfaz gráfica del software intérprete del lenguaje VHDL.

Un testbench es un archivo especial que tiene la estructura de un programa que contiene las especificaciones necesarias para asignar valores de prueba a las entradas del sistema digital y evaluar o simular su comportamiento. El archivo testbench es una maera de emular o imitar un banco de pruebas de electrónica. Para ilustrar la aplicación de un testbench usaremos un ejemplosencillo que consiste en un comparador simple de dos entradas de un solo bit, cuya tabla de verdad se muestra abajo:

```{list-table} Tabla de verdad de un circuito semi-sumador 
:header-rows: 2
:align: left
:name: comparador_unbit

* - 
  - Entradas
  - Salida
* - X
  - Y
  - I
* - **0**
  - **0**
  - 1
* - **0**
  - **1**
  - 0
* - **1**
  - **0**
  - 0
* - **1**
  - **1**
  - 1
```

Para este ejmplo en particular, asumiremos que solo podemos usar compuertas básicas **AND**, **OR**, **NOT** y **XOR**, con el fin de repasar algunos conceptos importantes. Una forma de representar al circuito lógico resultante es por medio de la expresión booleana:

$$
I=XY+\overline{X}~\overline{Y}
$$

Una posible descripción en VHDL para el circuito resultante es: 

```VHDL
------------------------------------------------
-- Descripción de un circuito comparador de un bit
-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

 
entity comparador is
  port (
    X,Y  : in std_logic; -- Entradas
    I  : out std_logic -- Salida I, por designar iguales
    );
end comparador;
 
architecture arq of comparador is
 signal intermedia_0, intermedia_1: std_logic; -- Señales intermedias  
begin

  I <= intermedia_0 OR intermedia_1;-- La salida I es el resultado de la
                                 -- operación OR de las señales intermedias
  intermedia_0  <= (NOT X) AND (NOT Y);
  intermedia_1 <= X AND Y;
end arq;
```
El circuito lógico equivalente a esta descripción se muestra en la figura de abajo:

```{figure} /images/comparador.png
:height: 200px
:name: comparador1
Circuito circuito comparador de dos bits
```
La salida de la simulación en vivado, usado el método tradicional, es decir, generando una tabla de verdad o combinaciones de las variables de entrada **X** e **Y** es:

```{figure} /images/salida_comp_1.png
:height: 400px
:name: salida_comp1
Simulación del comaprador de dos bits.
```
El archivo especial que permite una simulación automática, es decir, sin la necesidad de usar la parte gráfica de la interfaz de vivado, es decir, sin la necesidad de usar la herramientao `Force clock` se muestra a continuación:


```VHDL
------------------------------------------------
-- Testbench o archivo banco de pruebas 
--    para el comparador de 2 bits
-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity comparador_test is
end comparador_test; -- Cuando se escribe un archivo
-- para pruebas se usa una entidad vacía

architecture arq_test of comparador_test is

--------------------------------------------------------------
----- Se usa una estructura comparador para 
---   declarar o invocar a la entidad o circuito
---   lógico bajo prueba con todas sus entradas y salidas
---------------------------------------------------------------
 component comparador is
  port (
    X,Y  : in std_logic; -- Entradas
    I  : out std_logic -- Salida I, para designar iguales
    );
 end component;
---------------------------------------------------------------------- 
  signal test_in: std_logic_vector(1 downto 0); 
  signal test_out: std_logic;  -- Señales internas  
  -- usadas para la simulación
----------------------------------------------------------------------
begin
-----------------------------------------------------------------
-- En esta parte se declara el circuito lógico bajo prueba
------------------------------------------------------------------
   DUT: comparador -- Entidad bajo prueba Design Under Test (DUT)
   port map(X => test_in(1),
            Y => test_in(0),
            I => test_out);
------------------------------------------------------
   process
      begin
         -- Vector de pruebas 0
           test_in <= "00"; -- Parte inicial de la prueba
           wait for 200 ns; -- Se genera un retardo, 
--       similar a la herramienta force clock 
--    para poder generar las combinaciones de las entradas
         -- Vector de pruebas 1
            test_in <= "01"; -- combinación 1
            wait for 200 ns;
        -- Vector de pruebas 2
            test_in <= "10";
            wait for 200 ns;
        -- Vector de pruebas 3
            test_in <= "11";
            wait for 200 ns; -- El ciclo se repite a partir de aquí           
     end process;  
end arq_test;

```
El video de abajo muestra el procedimiento completo para simular un sistema digital descrito en VHDL en vivado, usando los archivos de descripción de hardware y el testbench anteriores.

<div align='center'>
<video controls autoplay muted="true" loop="true" width="600">
    <source src="./_static/videos/salida_comp_tb.mp4 " type="video/mp4">
</video>
</div>

## Simulacion de los circuitos aritméticos

A continuación se muestra el código de los archivos test bench o banco de pruebas para los circuitos lógicos aritméticos anteriormente descritos, cuya simulación se realizó de manera manual, esta vez se harán de manera automática utilizando los archivos testbench.


### Simulación del medio sumador 

El archivo de descripción para el medio sumador o semi-sumador, mostrado en la {numref}`semi_suma` es el siguiente:

``` VHDL
-------------------------------------------------------------------------------
-- Descripción VHDL de un semi-sumador
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity semi_sumador is
  port (
    X  : in std_logic;
    Y  : in std_logic;
    S  : out std_logic;
    C  : out std_logic
    );
end semi_sumador;
 
architecture arq of semi_sumador is
begin
  S  <= X xor Y;
  C <= X and Y;
end arq;
```

Mientras que el contenido del archivo test bench es el siguiente:

```VHDL
------------------------------------------------
-- Testbench o archivo banco de pruebas 
--    para el comparador de 2 bits
-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity semi_sumador_test is
end semi_sumador_test; -- Cuando se escribe un archivo
-- para pruebas se usa una entidad vacía

architecture arq_test of semi_sumador_test is

--------------------------------------------------------------
----- Se usa una estructura comparador para 
---   declarar o invocar a la entidad o circuito
---   lógico bajo prueba con todas sus entradas y salidas
---------------------------------------------------------------
 component semi_sumador is
  port (
    X  : in std_logic;
    Y  : in std_logic;
    S  : out std_logic;
    C  : out std_logic
    );
 end component;
---------------------------------------------------------------------- 
  signal test_in: std_logic_vector(1 downto 0); 
  signal test_out: std_logic_vector(1 downto 0);  -- Señales internas  
  -- usadas para la simulación
----------------------------------------------------------------------
begin
-----------------------------------------------------------------
-- En esta parte se declara el circuito lógico bajo prueba
------------------------------------------------------------------
   DUT: semi_sumador -- Entidad bajo prueba Design Under Test (DUT)
   port map(X => test_in(1),
            Y => test_in(0),
            S => test_out(1),
            C => test_out(0));
------------------------------------------------------
   process
      begin
         -- Vector de pruebas 0
           test_in <= "00"; -- Parte inicial de la prueba
           wait for 200 ns; -- Se genera un retardo, 
--       similar a la herramienta force clock 
--    para poder generar las combinaciones de las entradas
         -- Vector de pruebas 1
            test_in <= "01"; -- combinación 1
            wait for 200 ns;
        -- Vector de pruebas 2
            test_in <= "10";
            wait for 200 ns;
        -- Vector de pruebas 3
            test_in <= "11";
            wait for 200 ns; -- El ciclo se repite a partir de aquí           
     end process;  
end arq_test;
```
La salida en Vivado de la simulación se muestra en la figura {numref}`semi_suma_salida_tb`.

```{figure} /images/salida_semi_suma_tb.png
:height: 400px
:name: semi_suma_salida_tb
Simulación del semi-sumador.
```
### Simulación del sumador completo.

El archivo de descripción para el medio sumador o semi-sumador, mostrado en la {numref}`sumador_completo` es el siguiente:

```VHDL
------------------------------------------------
-- Descripción de un circuito sumador completo
-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity sumador_completo is
  port (
    X  : in std_logic;
    Y  : in std_logic;
    Z  : in std_logic;
    S  : out std_logic;
    C  : out std_logic
    );
end sumador_completo;
 
architecture arq of sumador_completo is
begin
  S  <= (X xor Y xor Z);
  C <= (X and Y) or (Z and (X or Y));
end arq;

```
Mientras que el contenido del archivo test bench es el siguiente:

```VHDL
------------------------------------------------
-- Testbench o archivo banco de pruebas 
--    para el comparador de 2 bits
-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity sumador_completo_test is
end sumador_completo_test; -- Cuando se escribe un archivo
-- para pruebas se usa una entidad vacía

architecture arq_test of sumador_completo_test is

--------------------------------------------------------------
----- Se usa una estructura comparador para 
---   declarar o invocar a la entidad o circuito
---   lógico bajo prueba con todas sus entradas y salidas
---------------------------------------------------------------
 component sumador_completo is
  port (
    X  : in std_logic;
    Y  : in std_logic;
    Z  : in std_logic;    
    S  : out std_logic;
    C  : out std_logic
    );
 end component;
---------------------------------------------------------------------- 
  signal test_in: std_logic_vector(2 downto 0); 
  signal test_out: std_logic_vector(1 downto 0);  -- Señales internas  
  -- usadas para la simulación
----------------------------------------------------------------------
begin
-----------------------------------------------------------------
-- En esta parte se declara el circuito lógico bajo prueba
------------------------------------------------------------------
   DUT: sumador_completo -- Entidad bajo prueba Design Under Test (DUT)
   port map(X => test_in(2),
            Y => test_in(1),
            Z => test_in(0),
            S => test_out(0),
            C => test_out(1));
------------------------------------------------------
   process
      begin
         -- Vector de pruebas 0
           test_in <= "000"; -- Parte inicial de la prueba
           wait for 200 ns; -- Se genera un retardo, 
--       similar a la herramienta force clock 
--    para poder generar las combinaciones de las entradas     
         -- Vector de pruebas 1
            test_in <= "001"; -- combinación 1
            wait for 200 ns;
        -- Vector de pruebas 2
            test_in <= "010";
            wait for 200 ns;
        -- Vector de pruebas 3
            test_in <= "011";
            wait for 200 ns; 
        -- Vector de pruebas 4
            test_in <= "100";
            wait for 200 ns; 
        -- Vector de pruebas 5
            test_in <= "101";
            wait for 200 ns; 
        -- Vector de pruebas 6
            test_in <= "110";
            wait for 200 ns; 
        -- Vector de pruebas 7
            test_in <= "111";
            wait; -- La prueba termina aquí y ya no se repite            
     end process;  
end arq_test;

```
La salida en Vivado de la simulación se muestra en la figura {numref}`salida_suma_comp`.

```{figure} /images/salida_suma_tb.png
:height: 400px
:name: salida_suma_comp
Simulación del sumador completo.
```

## Sumador con acarreo serie

Un sumador binario paralelo es un circuito digital que realiza la suma aritmética de dos números
binarios empleando sólo lógica combinacional({cite:t}`Mano2005`). El sumador paralelo es un conjunto de $n$ sumadores completos posicionados en paralelo, de manera tal que todos los bits de ambos sumandos se presentan simultáneamente en paralelo en las entradas para calcular la suma. Los $n$ sumadores completos
se conectan uno detrás del otro (en cascada), con la salida del acarreo de un sumador completo conectada a la entrada de acarreo del siguiente sumador completo. Es posible que aparezca un acarreo  con valor "1"
cerca del bit menos significativo del sumador tal que se propaga a través del resto de los sumadores completos hacia el bit más significativo. Un circuito lógico combinacional como este se denomina sumador
con acarreo serie (en inglés se denomina ripple carry adder). La {numref}`sumador_bloques` muestra la interconexión típica, en forma de diagrama de bloques, para construir un sumador de 4 bits con acarreo serie. Los bits del primer sumando **$X$** y los del segundo sumando **$Y$** son designados mediante subíndices en orden creciente de derecha a izquierda, de modo que el subíndice 0 denota el bit menos significativo o con menor ponderación. Los acarreos se conectan en serie a través de los sumadores completos. El acarreo de entrada del sumador pararelo es **$C_0$**, y el acarreo de salida es **$C_4$**. Un sumador de $n$ bits con acarreo serie requiere $n$ sumadores completos, con cada salida de acarreo conectada a la entrada de acarreo el siguiente sumador completo de orden inmediato superior. Por ejemplo, considere los dos números binarios $X=1011$ y $Y=0011$. Su suma, $S=1110$, se puede realizar utilizando un sumador completo de completo bits con acarreo serie como se muestra en la {numref}`suma_binaria`.

```{figure} /images/sumador_bloques.png
:height: 200px
:width: 800px
:name: sumador_bloques
Diagrama de un sumador con acarreo serie.
```

```{figure} /images/suma_binaria.png
:height: 250px
:name: suma_binaria
Suma de dos números de cuatro bits.
```

### Simulación del sumador con acarreo serie

La descripción en VHDL del sumador en serie incluye a la drscripción del sumador completo. Es posible hacer uso de módulos ya analizados y simulados para conseguir la construcción o descripción de un sistema digital más complejo en el contexto de la lógica combinacional, los sistemas digitales complejos, incluso los microprocesadores de las computadoras son circitos lógicos combinacionales que incorporan infinidad de subsiseños. El código VHDL para el sumador serie se muestra abajo:

```VHDL
--------------------------------------------------
-- Código VHDL para la descripción de 
--    un sumador con acarreo 
-- serie de dos números de 4 bits
--------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------  
-- Se usa la descripción de un bloque 
--   básico el cual es un sumador completo
--------------------------------------------------
entity sumador_completo is
 Port (  X : in STD_LOGIC;
         Y : in STD_LOGIC;
         Z : in STD_LOGIC;
         S : out STD_LOGIC;
         Cout : out STD_LOGIC);
end sumador_completo;
-- Se describe la arquitectura a nivel compuerta 
architecture nivel_compuerta of sumador_completo is
 
begin
 
 S <= X XOR Y XOR Z ;
 Cout <= (X AND Y) OR (Z AND X) OR (Z AND Y) ;
 
end nivel_compuerta; 
----------------------------------------------------
-- Se describe la entidad sumador serie que 
-- contiene al sumador completo como bloque 
-- fundamental
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity sumador_serie is
Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
       Y : in STD_LOGIC_VECTOR (3 downto 0);
       C0 : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       C4 : out STD_LOGIC);
end sumador_serie;
 
architecture arq of sumador_serie is
 
-- Declaración del uso del sumador completo
-- como bloque básico
component sumador_completo
 Port (  X : in STD_LOGIC;
         Y : in STD_LOGIC;
         Z : in STD_LOGIC;
         S : out STD_LOGIC;
      Cout : out STD_LOGIC);
end component;
 
-- Acarreos intermedios
signal c1,c2,c3: STD_LOGIC;
 
begin
 
-- Mapeo del sumador completo 4 veces, usado etiquetas 
-- Sc para interconectar los bloques
Sc1: sumador_completo port map( X(0), Y(0), C0, S(0), c1);
Sc2: sumador_completo port map( X(1), Y(1), c1, S(1), c2);
Sc3: sumador_completo port map( X(2), Y(2), c2, S(2), c3);
Sc4: sumador_completo port map( X(3), Y(3), c3, S(3), C4);
 
end arq;
```
El contenido del archivo test bench incluye al sumador serie como un componente, el cual se utiliza para declarar al diseño bajo prueba (DUT), el código VHDL del test bench es el siguiente:

```VHDL
library IEEE;
USE ieee.std_logic_1164.ALL;
 
entity tb_sumador_serie is
end tb_sumador_serie;
 
architecture arq of tb_sumador_serie is
 
-- Declaración del diseño bajo prueba DUT
 
component sumador_serie
Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
       Y : in STD_LOGIC_VECTOR (3 downto 0);
       C0 : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       C4 : out STD_LOGIC);
end component;
------------------------------------------------
--   Entradas
--  en este caso es importante usar valores por defecto
--- para iniciar la simulación, usanod la asignación
--- especial := (others => '0') para vectores de bits
---- y := '0' para bits.
-------------------------------------------------
signal test_X : std_logic_vector(3 downto 0):= (others => '0');
signal test_Y : std_logic_vector(3 downto 0):= (others => '0');
signal test_C0 : std_logic:= '0';
 
--Salidas
signal test_S : std_logic_vector(3 downto 0);
signal test_Cout : std_logic;
 
begin
 
-- Inicializaciond del DUT
DUT: sumador_serie 
Port map (
X => test_X,
Y => test_Y,
C0 => test_C0,
S => test_S,
C4 => test_Cout
);
 
-- Proceso de pruebas
process
begin
-- Mantener reset inical por 100ns
wait for 100 ns;
-- Se prueban varias combinaciones de 
-- sumandos
test_X <= "0110";
test_Y <= "1100";
--- 
wait for 100 ns;
test_X <= "1111";
test_Y <= "1100";
 
wait for 100 ns;
test_X <= "0110";
test_Y <= "0111";
 
wait for 100 ns;
test_X <= "0110";
test_Y <= "1110";
 
wait for 100 ns;
test_X <= "1111";
test_Y <= "1111";

wait;

end process;

end;
```

La salida en Vivado de la simulación se muestra en la figura {numref}`salida_suma_serie_sim`.

```{figure} /images/suma_serie_sim.png
:height: 350px
:name: salida_suma_serie_sim
Simulación del sumador con acarreo serie.
```
