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

# Resta binaria

Un método muy popular para realizar una resta de dos númneros binarios es el uso del complemento a dos. El complemento a dos de un número binario se obtiene de la sigiente forma:

Se determina el complemento a uno de un número binario de $N$ dígitos al aplicar la negación a cada uno de los bits de dicho número, por ejemplo, el complemento a 1 del número binario $101101$ es $010010$. De manera similar, para otras bases se define el complemento; el complemento a 9 de un número decimal se obtiene al al restar cada dígito de 9, para el caso del sistema octal, se restan de 7 y para el hexadecimal se restan de 15:

a. El complemento a $9$ de $876$ es: $123$.

b. El complemento a $15$ de $FE$ es: $EA$.

c. El complemento a $7$ de $54$ es: $23$. 

Como puede observarse, determinar el complemento a 1 de un número binario es más simple. El complemento a 2 se obtiene al sumar un uno al complemento a unos de un número binario. 

a. El complemento a 2 de $101110$ es: $010001$.

b. El complemento a 2 de $111111$ es: $000001$.

Para realizar la resta binaria de dos números, se obtiene el complemento a 2 de uno de los operandos y se le suma al operando restante. Por ejemplo, sean los números binarios $X=1011011$ e $Y=1001110$, la resta $Z=X-Y$ se obtiene al sumar el complemento a 2 de $Y$ y $X$.

$$
X+comp_2(Y)=1011011+0110001=91_{10}-78_{10}=13_{10}
$$

$$
\begin{eqnarray}
 &1011011\\
+&0110010\\
&\overline{~~~~~~~~~~~~~~~~~}\\
Z=1&0001101
\end{eqnarray}
$$
Se ignora el último acarreo y solo se considera al número $1101=13_{10}$ como el resultado de la resta. Por otra parte, la resta $W=Y-X$ se calcula como: 

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

Usando el complemento a 1 y el complemento a 2 hemos suprimido la operación de la resta y
solamente necesitamos un complementador apropiado y un sumador. Cuando realizamos una
resta complementamos el substraendo N, mientras que para sumar no es necesario. Estas operaciones
se pueden lograr usando un complementador selectivo y un sumador interconectados
para formar un sumador-restador. Empleamos el complemento a 2 por ser el más habitual en los
sistemas modernos. El complemento a 2 se puede obtener tomando el complemento a 1 y sumándole
1 al bit de menor peso. El complemento a 1 se implementa fácilmente a partir de circuitos
inversores, mientras que la suma de 1 la conseguimos haciendo la entrada de acarreo del
sumador paralelo igual a 1. De esta manera, usando el complemento a 1 y una entrada no usada
del sumador, se obtiene muy económicamente el complemento a 2. En la resta en complemento
a 2, como en el paso de corrección después de la suma, tenemos que complementar el resultado
y añadirle un signo menos si se produce acarreo final. La operación de corrección se realiza
empleando cualquier sumador-restador una segunda vez con M%0 o un complementador selectivo
como el de la Figura 5-7.

En la {numref}`sumador_restador` se muestra un circuito sumador-restador de 4 bits. La entrada S controla el funcionamiento. Cuando
S%0 el circuito funciona como un sumador, y cuando S%1 el circuito se convierte en un
restador. Cada puerta OR exclusiva recibe la entrada S y una de las entradas de B, Bi. Cuando
S%0, tenemos Bi0. Si los sumadores completos reciben el valor de B, y la entrada de acarreo
es 0, el circuito realiza A!B. Cuando S%1, tenemos Bi1%Bi y C0%1. En este caso,
el circuito realiza la operación A!el complemento a 2 de B.



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

end;
```
