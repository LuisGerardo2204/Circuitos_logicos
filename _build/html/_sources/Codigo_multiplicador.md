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

# Código VHDL para un multiplicador binario de cuatro bits.

El código VHDL para un multiplicador binario de cuatro bits debe incluir como bloque fundamental a un sumador con acarreo serie como el que se muestra en la {numref}`multiplicador`.

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
 
architecture arq_sumador_serie of sumador_serie is
 
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
 
end arq_sumador_serie;
----------------------------------------------------
-- Se describe la entidad multiplicador que 
-- contiene al sumador_serie como bloque 
-- fundamental
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplicador is
     Port(
         X: in std_logic_vector(3 downto 0);
         Y: in std_logic_vector(3 downto 0);
         P: out std_logic_vector(7 downto 0)     
       );
end multiplicador;

architecture modular of multiplicador is

   component sumador_serie 
        Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
               Y : in STD_LOGIC_VECTOR (3 downto 0);
               C0 : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (3 downto 0);
               C4 : out STD_LOGIC);
   end component;
--- Productos de los terminos con operación lógica AND
signal I0,I1,I2: std_logic_vector(3 downto 0);
--- Las entradas B tienen tres bits de productos AND
signal B0,B1,B2: std_logic_vector(3 downto 0);

begin
-- Y(1) a Y(3) productos AND
I0 <= (X(3) AND Y(1),X(2) AND Y(1),X(1) AND Y(1),X(0) AND Y(1));
I1 <= (X(3) AND Y(2),X(2) AND Y(2),X(1) AND Y(2),X(0) AND Y(2));
I2 <= (X(3) AND Y(3),X(2) AND Y(3),X(1) AND Y(3),X(0) AND Y(3));
-- Productos Y(0) y el producto Y(3) AND '0'
B0 <= ('0', X(3) AND Y(0),X(2) AND Y(0),X(1) AND Y(0));

-- Asciación modular
moulo_1: 
    sumador_serie
       Port map ( X => I0,
                  Y => B0,
                  C0 => '0',
                   C4  => B1(3),
                  S(3) => B1(2), -- La asociación se puede dar en cualquier orden
                  S(2) => B1(1), -- Los elementos individuales de S estan asociados
                  S(1) => B1(0), -- todos estos miembros se entregan continuamente
                  S(0) => P(1)                    
                    );

moulo_2: 
    sumador_serie
       Port map ( X => I1,
                  Y => B1,
                  C0 => '0',
                   C4  => B2(3),
                  S(3) => B2(2), -- La asociación se puede dar en cualquier orden
                  S(2) => B2(1), -- Los elementos individuales de S estan asociados
                  S(1) => B2(0), -- todos estos miembros se entregan continuamente
                  S(0) => P(2)                    
                    );
moulo_3: 
    sumador_serie
       Port map ( X => I2,
                  Y => B2,
                  C0 => '0',
                   C4  => P(7),
                    S => P(6 downto 3)-- Acoplando elementos por formalidad                    
                    );

  P(0) <= X(0) AND Y(0);

end modular;
````

El test bench para probar el circuito multiplicador es el siguiente:

```VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_multiplicador is
end tb_multiplicador;

architecture arq_tb of tb_multiplicador is 


component multiplicador
     Port(
         X: in std_logic_vector(3 downto 0);
         Y: in std_logic_vector(3 downto 0);
         P: out std_logic_vector(7 downto 0)     
       );
end component;


signal test_X, test_Y: std_logic_vector(3 downto 0);
signal test_P: std_logic_vector (7 downto 0);


begin 

DUT: multiplicador
     Port map(
         X => test_X,
         Y => test_Y,
         P => test_P
       );
PRUEBAS:
 Process
    begin
        wait for 100 ns;
        test_X <= "0010";
        test_Y <= "0110"; 
         wait for 100 ns;
        test_X <= "1010";
        test_Y <= "1110"; 
         wait for 100 ns; 
        wait for 100 ns;
        test_X <= "1011";
        test_Y <= "1010"; 
    wait;  
 end process; 
end arq_tb;
````


Una opción diferente para realizar el test bench para el multiplicador de cuatro bits se puede estructurar de tal manera que se elaboren las operaciones en un formato que emula a una tabla de multiplicar.

```VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_multiplicador is
end tb_multiplicador;

architecture arq_tb of tb_multiplicador is 


component multiplicador
     Port(
         X: in std_logic_vector(3 downto 0);
         Y: in std_logic_vector(3 downto 0);
         P: out std_logic_vector(7 downto 0)     
       );
end component;


signal test_X, test_Y: std_logic_vector(3 downto 0);
signal test_P: std_logic_vector (7 downto 0);
use ieee.numeric_std.all;

begin 

DUT: multiplicador
     Port map(
         X => test_X,
         Y => test_Y,
         P => test_P
       );
PRUEBAS:
 Process
    begin
       for i in 0 to 15 loop
           test_X <= std_logic_vector(to_unsigned(i, test_X'length));
            for j in 0 to 15 loop
               test_Y <= std_logic_vector(to_unsigned(j, test_Y'length));
               wait for 10 ns;          
           end loop;
       end loop;
    wait;  
 end process; 
end arq_tb;
````




