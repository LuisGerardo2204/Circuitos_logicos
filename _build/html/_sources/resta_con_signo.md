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

# Resta binaria con signo

La suma de dos números, $X+Y$, en el sistema de signo y magnitud sigue las reglas de la aritmética ordinaria: Si los dos signos son iguales, sumamos las magnitudes y se otorga el signo de $X$ a la suma. Si los signos son diferentes, se resta la magnitud de $Y$ a la magnitud de $X$ ({cite:t}`Tocci2017`). La presencia o asusencia de acarreo final determina el signo del resultado, con base en el signo del número $X$ y se decide si se corrige usando del complemento a
dos. Por ejemplo, los números con signo $X=(0~0011001)$ y $Y=(1~0100101)$, la suma se expresa como la resta expresada como $Z=X+Y=X-Y$, debido a que $Y$ tiene signo negativo:

$$
\begin{eqnarray}
  &0011001\\
 +&1011011\\
&\overline{~~~~~~~~~~~~~~~~~}\\
Z=&1110100
\end{eqnarray}
$$

Se observa que el resultado es $1110100$, y se ha producido un acarreo de $1$. El acarreo final indica que la magnitud de $X$ es menor que la magnitud de $Y$. Entonces, el signo del resultado es opuesto al de $X$ y es, por consiguiente, un signo de (-). El acarreo final también indica que la magnitud del resultado, $1110100$, se debe corregir tomando su complemento a 2. Combinando
el signo y la magnitud corregida del resultado, se obtiene $1~0001100$. La regla para sumar números en signo y complemento no requiere ni comparación ni resta, sino sólo suma. El procedimiento es simple y puede exponerse como sigue para los números binarios:

Algunos ejemplos de suma binaria con signo son los siguientes:


```{math}
:label: ejemplo_1
\begin{eqnarray}
 +6~~~~~&00000110\\
 +13~~+ &00001101\\
\overline{~~~~~}~~~~&\overline{~~~~~~~~~~~~~~~~~}\\
19~~~~&00010011
\end{eqnarray}
```

```{math}
:label: ejemplo_2
\begin{eqnarray}
 -6~~~~~&11111010\\
 +13~~+ &00001101\\
\overline{~~~~~}~~~~&\overline{~~~~~~~~~~~~~~~~~}\\
+7~~~&00000111
\end{eqnarray}
```

```{math}
:label: ejemplo_3
\begin{eqnarray}
 +6~~~~~&00000110\\
 -13~~+ &11110011\\
\overline{~~~~~}~~~~&\overline{~~~~~~~~~~~~~~~~~}\\
-7~~~&11111001
\end{eqnarray}
```

```{math}
:label: ejemplo_4
\begin{eqnarray}
 -6~~~~~&11111010\\
 -13~~+ &11110011\\
\overline{~~~~~}~~~~&\overline{~~~~~~~~~~~~~~~~~}\\
-19~~~&11101101
\end{eqnarray}
```

```{list-table} Números binarios con signo
:header-rows: 1
:align: left
:name: tabla_signos

* - Decimal
  - Signo y complemento a 2
  - Signo y complemento a 1
  - Signo y magnitud
* - +7
  - 0111
  - 0111
  - 0111
* - +6
  - 0110
  - 0110
  - 0110
* - +5
  - 0101
  - 0101
  - 0101  
* - +4
  - 0100
  - 0100
  - 0100
* - +3
  - 0011
  - 0011
  - 0011   
* - +2
  - 0010
  - 0010
  - 0010
* - +1
  - 0001
  - 0001
  - 0001
* - +0
  - 0000
  - 0000
  - 0000
* - -0
  - "##"
  - 1111
  - 1000
* - -1
  - 1111
  - 1110
  - 1001 
* - -2
  - 1110
  - 1101
  - 1010
* - -3
  - 1101
  - 1100
  - 1011
* - -4
  - 1100
  - 1011
  - 1100
* - -5
  - 1011
  - 1010
  - 1101
* - -6
  - 1010
  - 1001
  - 1110
* - -7
  - 1001
  - 1000
  - 1111
* - -8
  - 1000
  - "##"
  - "##"  
```



l número $1101=13_{10}$ como el resultado de la resta. Por otra parte, la resta $W=Y-X$ se calcula como: 

$$
Y+comp_2(X)=1001110+0100101=78_{10}-91_{10}=-13_{10}
$$

$$
\begin{eqnarray}
  &1001110\\
 +&0100101\\
&\overline{~~~~~~~~~~~~~~~~~}\\
Z=&1110011
\end{eqnarray}
$$

En este caso, al no haber acarreo, se calcula el complemento a dos del resultado para obeter el valor real de la resta y se anexa el signo de negativo:


$$
Y-X=-comp_2(1110011)=-0001101=-13_{10}
$$

## Sumador-restador binario

Usando el complemento a 2 se suprime la operación de la resta y solamente se hace necesario un complementador apropiado y un sumador completo como el que se desarrolló en las secciones anteriores. Cuando realizamos una resta complementamos a dos el substraendo, mientras que para sumar no es necesario. Estas operaciones se pueden lograr usando un complementador selectivo y un sumadorcompleto conectados para formar un sumador-restador.El complemento a 2 se aplica por ser el más habitual en los
sistemas modernos. El complemento a 2 se puede obtener tomando el complemento a 1 y sumándole 1 al bit de menor peso. El complemento a 1 se implementa fácilmente a partir de circuitos inversores, mientras que la suma de 1 la conseguimos haciendo la entrada de acarreo del sumador paralelo igual a 1. De esta manera, usando el complemento a 1 y una entrada no usada
del sumador, se obtiene de una forma muy sencilla el complemento a 2. En la resta en complemento a 2, como en el paso de corrección después de la suma, tenemos que complementar el resultado y añadirle un signo menos si se produce acarreo final. 

En la {numref}`sumador_restador` se muestra un circuito sumador-restador de 4 bits. La entrada $R$ controla el funcionamiento. Cuando $R=0$ el circuito funciona como un sumador, y cuando $R=1$ el circuito se convierte en un restador. Cada puerta OR exclusiva recibe la entrada $R$ y una de las entradas de $Y$, $Y_i$. Cuando $R=0$, tenemos $Y_i \oplus 0$. Si los sumadores completos reciben el valor de $Y$, y la entrada de acarreo es 0, el circuito realiza $A+B$. Cuando $R=1$, tenemos $Y_i \oplus 1=\overline{Y}_i$ y $C_0=1$. En este caso, el circuito realiza la operación $A+comp_2(B)$.

```{figure} /images/sumador_restador.png
:height: 250px
:width: 800px
:name: sumador_restador
Diagrama de un sumador-restador con acarreo serie.
```
La descripción en VHDL del sumador-restador incluye a la descripción del sumador completo. Es posible hacer uso de módulos ya analizados y simulados para conseguir la construcción o descripción de un sistema digital más complejo en el contexto de la lógica combinacional, los sistemas digitales complejos, incluso los microprocesadores de las computadoras son circitos lógicos combinacionales que incorporan infinidad de subsiseños. El código VHDL para el sumador-restador se muestra abajo:

```VHDL
--------------------------------------------------
-- Código VHDL para la descripción de 
--    un sumador-restador con acarreo 
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
-- Se describe la entidad sumador-restador que 
-- contiene al sumador completo como bloque 
-- fundamental
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity sumador_restador is
Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
       Y : in STD_LOGIC_VECTOR (3 downto 0);
       R : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       C4 : out STD_LOGIC);
end sumador_restador;
 
architecture arq of sumador_restador is
 
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
Sc1: sumador_completo port map( X(0), R XOR Y(0), R, S(0), c1);
Sc2: sumador_completo port map( X(1), R XOR Y(1), c1, S(1), c2);
Sc3: sumador_completo port map( X(2), R XOR Y(2), c2, S(2), c3);
Sc4: sumador_completo port map( X(3), R XOR Y(3), c3, S(3), C4);
 
end arq;
```
El contenido del archivo test bench incluye al sumador-restador como un componente, el cual se utiliza para declarar al diseño bajo prueba (DUT), el código VHDL del test bench es el siguiente:

```VHDL
library IEEE;
USE ieee.std_logic_1164.ALL;
 
entity tb_sumador_restador is
end tb_sumador_restador;

architecture arq of tb_sumador_restador is
-- Declaración del diseño bajo prueba DUT
component sumador_restador
Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
       Y : in STD_LOGIC_VECTOR (3 downto 0);
       R : in STD_LOGIC;
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
signal test_R : std_logic:= '0';
--Salidas
signal test_S : std_logic_vector(3 downto 0);
signal test_Cout : std_logic;
begin
-- Inicializacion del DUT
DUT: sumador_restador
Port map (
X => test_X,
Y => test_Y,
R => test_R,
S => test_S,
C4 => test_Cout
);
-- Proceso de pruebas
process
begin
-- Mantener reset inical por 100ns
wait for 100 ns;
-- Se prueban varias combinaciones de 
-- sumandos y sustraendos
test_X <= "1100";
test_Y <= "0110";
wait for 100 ns;
--- -------------------
test_R <= '1';
test_X <= "1100";
test_Y <= "0110";
wait for 100 ns;
---------------------
wait;
end process;
end;
```
