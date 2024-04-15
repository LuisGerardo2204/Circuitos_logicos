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
         -- Vector de pruebas 0
            test_in <= "000"; -- combinación 1
            wait for 200 ns;         
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
            wait; -- La prueba termia aquí y ya no se repite            
     end process;  
end arq_test;

```
```{figure} /images/salida_suma_tb.png
:height: 400px
:name: salida_suma_comp
Simulación del sumador completo.
```