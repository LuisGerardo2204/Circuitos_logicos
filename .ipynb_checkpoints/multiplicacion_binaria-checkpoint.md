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

# Multiplicación binaria


La multiplicación de números binarios se realiza de la misma manera que con los números decimales. El multiplicando se multiplica por cada bit del multiplicador, empezando por el bit menos significativo. Cada una de estas multiplicaciones forma un producto parcial. Cada uno de estos productos parciales se desplaza un bit a la izquierda. El producto final se obtiene de la suma de los productos parciales.

$$
\begin{eqnarray}
&~X_3 X_2 X_1 X_0\\
&\times Y_3 Y_2 Y_1 Y_0\\
&\overline{~~~~~~~~~~~~~~~~~~~~~}\\
&X_3Y_0~~X_2Y_0~~X_1Y_0~~X_0Y_0~~~~~~~~~~~~~~~~~~~~\\
&X_3Y_1~~X_2Y_1~~X_1Y_1~~X_0Y_1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\\
&X_3Y_3~~X_2Y_2~~X_1Y_2~~X_0Y_2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\\
&X_3Y_3~~X_2Y_3~~X_1Y_3~~X_0Y_3~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\\
&\overline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\\
&P_7~~~~~~~P_6~~~~~~~P_5~~~~~~~P_4~~~~~~~P_3~~~~~~~P_2~~~~~~~P_1~~~~~~~P_0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\end{eqnarray}
$$

Un ejemplo de la multiplicación de dos números de 4 bis se muestra abajo. La multiplicación de los números $X=1011$ y $Y=1010$ equivale a $P=01101110$, en decimal se tendría el producto: $P=10_{10}\times 11_{10}=156_{10}$.

$$
\begin{eqnarray}
&~~~~~1011\\
&\times 1010\\
&\overline{~~~~~~~~~~~~~~~~~}\\
&0~~0~~0~~0\\
&1~~0~~1~~1~~~~~~~~\\
&0~~0~~0~~0~~~~~~~~~~~~~~~~\\
&1~~0~~1~~1~~~~~~~~~~~~~~~~~~~~~~~~\\
&\overline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}~~~~~~~~~~~~~~\\
&0~~1~~1~~0~~1~~1~~1~~0~~~~~~~~~~~~~~~~
\end{eqnarray}
$$


El diagrama de bloques del circuito multiplicador de 4 bits se muestra abajo:

```{figure} /images/multiplicador.png
:height: 750px
:name: multiplicador
Diagrama de bloques de un multiplicador binario de 4 bits.
```

El código VHDL del multiplicador binario integra los módulos descritos en la sección anterior, integra tres sumadores de cuatro bits con acarreo serie y los respectivos sub módulos de sumador completo de dos bits.


```VHDL
--------------------------------------------------
-- Código VHDL para la descripción de 
--    umultiplicadoro 
ie de dos números de 4 bits
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
       C4 : out STD_LOGIC_sumador_serie_sumador_serie);
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
Sc4_sumador_serie_sumador_serie: sumador_completo port map( X(3), Y(3), c3, S(3), C4);
 
end arq;


```
El testbench para el multiplicador incluye 
 
```VHDL
library ieee;
use ieee.std_logic_1164.all;


```

