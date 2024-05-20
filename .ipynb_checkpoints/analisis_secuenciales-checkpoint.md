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

# Flip-flops con símbolos gráficos estándar

Los diferentes tipo de latches y flip-flops tienen asignada una simbología estándar para una fácil incluisón en diagrámas lógicos de alta complejidad, en los que sería imposible incluir su especificación a nivel de compuertas lógicas. 

## Flip-flop RS

En la {numref}`ff_RS` se presenta la simbología básica para los latches y flip-flops del tipo RS, mientras que la tabla de verdad de estos latches y flip-flops es la {numref}`tabla_RS_ff`. La expresión lógica, en términos del álgebra de Boole que describe al comportamiento de un flip-flop se conoce como ecuación característica, para el caso del flip-flop SR o RS es la siguiente:


$$
Q(t+1)=S(t)+\overline{R}(t)Q(t)
$$

donde $Q(t+1)$ es el estado siguiente, $Q(t)$ es el estado actual y las entradas $S(t)$ y $R(t)$ son las entradas Set y Reset respectivamente. 

```{figure} /images/flip_flops_RS.png
:height: 400px
:name: ff_RS
Latches y flip-flops RS, (a) latch RS, (b) flip-flop RS disparado por flanco positivo, (c) latch RS controlado por señal negada y (d) flip-flop RS disparado por flanco negativo ({cite:t}`Mano2005`).
```

```{list-table} Tabla de verdad del latch RS
:header-rows: 1
:align: left
:name: tabla_RS_ff

* - **$S$**
  - **$R$**
  - **$Q(t+1)$**
  - **Operación**
* - 0
  - 0
  - X
  - No cambia
* - 0
  - 1
  - 0
  - Reset
* - 1
  - 0
  - 1
  - Set
* - 1
  - 1
  - X
  - Indefinido  
```
El código VHDL para la descripción de un flip-flop RS, usando estructuras de desición y un proceso basado en eventos para la inclusión de una entrada de reloj es la siguiente:

```VHDL
----------------------------------------------------
-- Descripción de un flip-flop RS
---------------------------------------------------
library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity ff_SR is
PORT( S,R,CLK: in std_logic;
Q, noQ : out std_logic);
end ff_SR;

Architecture arq of ff_SR is
begin
PROCESS(CLK)
variable tmp: std_logic;
begin
-- El proceso de detectar el reloj se 
-- describe abajo:
if(CLK='1' and CLK'EVENT) then 
-- El flanco que se detecta es el positivo
-- o de subida
if(S='0' and R='0')then
tmp:=tmp;
elsif(S='1' and R='1')then
tmp:='Z';
elsif(S='0' and R='1')then
tmp:='0';
else
tmp:='1';
end if;
end if;
Q <= tmp;
noQ <= not tmp;
end PROCESS;
end arq;

````
La salida de la simualción en Vivado es la siguiente:

```{figure} /images/salida_RS_clock.png
:height: 300px
:name: sRS_clk
Simulación de la salida del flip-flop RS en vivado.
```

## Flip-flop D

El diagrama lógico estándar de un flip-flop tipo D se muestra en la {numref}`FF_D`,  cuya ecuación característica es la siguiente:

$$
Q(t+1)=D(t)
$$

```{figure} /images/FF_D.png
:height: 400px
:name: FF_D
Latches y flip-flops D, (a) latch D, (b) flip-flop D disparado por flanco positivo, (c) latch controlado por señal negada y (d) flip-flop D disparado por flanco negativo ({cite:t}`Mano2005`).
```


La tabla de funcionamiento del flip-flop es la que se muestra en la {numref}`tabla_ff_D`

```{list-table} Tabla de verdad del flip-flop D
:header-rows: 1
:align: left
:name: tabla_ff_D

* - D
  - $Q(t+1)$
  - Operación
* - 0  
  - 0
  - Reset
* - 1
  - 1
  - Set
```

El código VHDL para la descripción de un flip-flop D, usando estructuras de desición y un proceso basado en eventos para la inclusión de una entrada de reloj es la siguiente:

```VHDL
----------------------------------------------------
-- Descripción de un flip-flop D
---------------------------------------------------
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
````
La salida de la simualción en Vivado es la siguiente:

```{figure} /images/salida_D_clock.png
:height: 300px
:name: D_clk
Simulación de la salida del flip-flop D en vivado.
```
## Flip-flop JK

El diagrama lógico estándar de un flip-flop JK se muestra en la {numref}`FF_JK`,  cuya ecuación característica es la siguiente:

$$
Q(t+1)=J(t)\overline{Q}(t)+\overline{K}Q(t)
$$

```{list-table} Tabla de verdad del flip-flop JK
:header-rows: 1
:align: left
:name: tabla_ff_JK

* - **$J$**
  - **$K$**
  - **$Q(t+1)$**
  - **Operación**
* - 0
  - 0
  - X
  - No cambia
* - 0
  - 1
  - 0
  - Reset
* - 1
  - 0
  - 1
  - Set
* - 1
  - 1
  - $\overline{Q}(t)$
  - Complemento  
```


```{figure} /images/flip_flops_JK.png
:height: 400px
:name: FF_JK
Flip-flops JK (a) disparado por flanco positivo (b) disparado por flanco negativo, (c) Construido a partir de un flip-flop D.
```
```VHDL
----------------------------------------------------
-- Descripción de un flip-flop JK
---------------------------------------------------
library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity ff_JK is
PORT( J,K,CLK: in std_logic;
Q, noQ: out std_logic);
end ff_JK;

architecture arq of ff_jk is
begin
process(CLK)
variable tmp: std_logic := '0';
begin 
if (CLK='1' and CLK'EVENT) then 
tmp:= (J AND (NOT tmp)) OR (not(K) AND tmp);
end if;
Q <= tmp;
noQ <= NOT tmp;
end process;
end arq;
```
La salida de la simualción en Vivado es la siguiente:

```{figure} /images/salida_ff_JK.png
:height: 300px
:name: JK_clk
Simulación de la salida del flip-flop JK en vivado.
```

## Flip-flop T

El diagrama lógico estándar de un flip-flop JK se muestra en la {numref}`FF_T`,  cuya ecuación característica es la siguiente:

$$
Q(t+1)=T(t)\oplus \overline{Q}(t)
$$

```{list-table} Tabla de verdad del flip-flop T
:header-rows: 1
:align: left
:name: tabla_ff_T

* - T
  - $Q(t+1)$
  - Operación
* - 0  
  - $Q(t)$
  - No cambia
* - 1
  - $\overline{Q}(t)$
  - Complemento
```


```{figure} /images/flip_flops_T.png
:height: 400px
:name: FF_T
Flip-flops T, (a) flip-flop T disparado por flanco positivo, (b) flip-flop t disparado por flanco negativo (d) flip-flop T construido con un flip-flop D y lógica combinacional ({cite:t}`Mano2005`).
``` 



```VHDL
----------------------------------------------------
-- Descripción de un flip-flop T
---------------------------------------------------
library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity ff_T is
port( T: in std_logic;
CLK: in std_logic;
Q: out std_logic;
noQ: out std_logic);
end ff_T;

architecture arq of ff_T is
beginprocess(CLK)
variable tmp: std_logic := '0';
begin
if (CLK'event and CLK='1') then
tmp := T XOR tmp;
end if;
Q <= tmp;
noQ <= NOT(tmp);
end process;
end arq;
````
La salida de la simualción en Vivado es la siguiente:

```{figure} /images/salida_ff_T.png
:height: 300px
:name: T_clk
Simulación de la salida del flip-flop T en vivado.
```