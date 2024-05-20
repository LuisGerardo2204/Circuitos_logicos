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

# Análisis de circuitos secuenciales

Los diferentes tipo de latches y flip-flops tienen asignada una simbología estándar para una fácil incluisón en diagrámas lógicos de alta complejidad, en los que sería imposible incluir su especificación a nivel de compuertas lógicas. 


$$
Q(t+1)=S(t)+\overline{R}(t)Q(t)
$$

donde $Q(t+1)$ es el estado siguiente, $Q(t)$ es el estado actual y las entradas $S(t)$ y $R(t)$ son las entradas Set y Reset respectivamente. 

```{figure} /images/secuencial_1.png
:height: 400px
:name: logico_secuencial
Circuito lógico secuencial ({cite:t}`Mano2005`).
```

El código VHDL para la descripción de un flip-flop RS, usando estructuras de desición y un proceso basado en eventos para la inclusión de una entrada de reloj es la siguiente:

```VHDL
----------------------------------------------------
-- Descripción de un circuito secuencial, basado en 
--         flip-flop D
------------------------------------------------------
-- Primero se describe la entidad básica que es el 
-- flip-flop D
-----------------------------------------------------
library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity ff_D is
PORT( D,CLK: in std_logic;
  Q: out std_logic;
noQ: out std_logic);
end ff_D;

architecture arq of ff_D is
begin
process(CLK)
begin
if(CLK='1' and CLK'EVENT) then
Q <= D;
noQ <= NOT D; 
end if;
end process;
end arq;
-----------------------------------------------------------------
----  Después se describe la estructura del circuito secuencial
---      completo, que incluye la parte combinacional
-----------------------------------------------------------------
library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;


entity secuencial is
PORT( X,CLK: in std_logic;
    Y: out std_logic);
end secuencial;

architecture arq of secuencial is

component ff_D
PORT( D,CLK: in std_logic;
  Q: out std_logic;
noQ: out std_logic);
end component;
signal A,noA,B,noB,DA,DB: STD_LOGIC;

begin


DA <= (A and X)or(B and X);
DB <= noA and X;
--- Mapeo de puertos con la interconexión de los flip-flops 
ff_A: ff_D port map(DA,CLK,A,NoA);
ff_B: ff_D port map(DB,CLK,B,noB);

Y <= (A or B)and (not X);
end arq;


````


```{list-table} Tabla de verdad del latch RS
:header-rows: 1
:align: left
:name: tabla_secuencial_1

* -
  - Estado Actual
  -
  - Entrada
  -
  - Estado futuro
  -
  - Salida
* -
  - **A**
  - **B**
  - **X**
  -
  - **A**
  - **B**
  - **Y**
* -
  - 0
  - 0
  - 0
  -
  - 0
  - 0
  - 0
* -
  - 0
  - 0
  - 1
  -
  - 0
  - 1
  - 0
* -
  - 0
  - 1
  - 0
  -
  - 0
  - 0
  - 1
* -
  - 0
  - 1
  - 1
  -
  - 1
  - 1
  - 0
* -
  - 1
  - 0
  - 0
  -
  - 0
  - 0
  - 1  
* -
  - 1
  - 0
  - 1
  -
  - 1
  - 0
  - 0
* -
  - 1
  - 1
  - 0
  -
  - 0
  - 0
  - 1
* -
  - 1
  - 1
  - 1
  -
  - 1
  - 0
  - 0  
```

