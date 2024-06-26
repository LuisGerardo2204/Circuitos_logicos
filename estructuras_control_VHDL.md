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

# Estructuras de control de flujo o de desición en VHDL

En esta parte del curso, se exponen métodos básicos para la toma de desiciones "lógicas" para describir arquitecturas de sistemas digitales en VHDL. Es importante mencionar que cuando se usan estructuras de control de desición en VHDL, el orden en el cual se hacen las preguntas para esa toma de desiciones es importante. Para resumir este concepto, en los términos de VHDL, las sentencias de control que se escriben se denominan concurrentes. 

## Estructura IF/THEN/ELSE en VHDL

Las tablas de verdad permiten enumerar todas las combinaciones posibles de las variables independientes o entradas a un circuito lógico, sin embargo existen casos en los que se necesitan  mejores formas de maneja variables  numériaos.En los casos en los que se manejan intervalos o rangos posibles para alguna variable, por ejemplo, para un sistema que monitorea la temperatura de un proceso, para encender un ventilador cuando la temperatura sea mayor a algun vaor de referencia. 

* Si la temperatra es de 1 grado Celsius el ventilador estará apagado.
* Si la temperatra es de 2 grados Celsius el ventilador estará apagado.i* Si la temperatra es de 5 grados Celsius el ventilador estará apagado
* ...
* Si la temperatura es de 70 grados Celsius el ventilador estará apagado.
* Si la temperatura es 71 grados el ventilador se enciende.
* Si la temperatura es 72 grados el ventilador se enciende.


Esta forma de representar el criterio para realcionar los posibles valores de la entrada; la temperatura en grados Celsius, con la salida; el encendido del ventilador de la tabla de verdad para describir la decisión de mantener apagado el ventilador o encenderlo.



En VHDL un aspecto muy importante es la declaración correcta del tipo específico de las entradas. Por ejemplo, si una variable cualquiera es declarada como `INTEGER`, el compilador lo tratará como a un número. Si además se especifica un rango para ese número del 0 al 15, el compilador lo asumirá con una longitud de 4 bits. Es posible notar entonces que la especificación del Rango del número no especifica el número de índice en un vector de bits, sino que limita el rango de posibles valores que puede adquirir dicho entero.

``` VHDL
--------------------------------
--Estructura IF en VHDL
-------------------------------
library IEEE;
use IEEE.std_logic_1164.all; -- Librería para variables lógicas estandard

entity prueba is
   port(
   valor_digital :in integer range 0 to 15; -- Entrada de 4 bits
   salida :out bit -- Salida simple
   );
end prueba;

architecture desicion of prueba is

begin 

Process (valor_digital)
  begin
    if(valor_digital>6) then
       salida<='1';
    else
      salida<='0';
    end if;
end Process;

end desicion; 

```


Uno de los aspectos que causan más confusión acerca del lenguaje VHDL es entender el significado y contexto de la estructura denominada  `PROCESS`. Es importante recordar que VHDL es un lenguaje que se usa para describir el comportamiento de un circuito lógico, concebido para ser aplicado o evaluedo en una computadora, para realizar simulaciones o síntesis en un dispositivo logico programable.
La estructura `PROCESS`  en VHDL es un conjunto de líneas de código que tiene las características propias de un programa convencional, con la diferencia sencial de que cuyo propósito es describir eventos que suceden de manera secuancial en un circuito digital. Es muy importante entender cómo las acciones descritas en una estructura `PROCESS` realmente ocurren en el circuito, una estructura `PROCESS` no está constantemente activa describiendo lo que está sucediendo todo el tiempo, en cambio, una estuctura `PROCESS` es un segmento de código que describe como reacciona un circuito a un cambio en al menos una de sus entradas. Estas entradas que invocan los cambios descritos `PROCESS` se identifican en una especificación que se denomina lista de sensibilidad, como se muestra abajo: 


``` 
Process (valor_digital)
  begin
    if(valor_digital>6) then
       salida<='1';
    else
      salida<='0';
    end if;
end Process;
```


Esta lista de sensibilidad sigue a la palabra clave `PROCESS` y está contenida entre paréntesis. La interpretación de las declaraciones dentro de la estructura  `PROCESS` (que resultan en cambios dentro del circuito) es secuencial, no concurrente. En otras palabras, el orden de las declaraciones tiene un efecto sobre el comportamiento del circuito resultante. Las variables se declaran y modifican dentro de la estructura `PROCESS`, su valor se actualiza inmediatamente. Cuando un `PROCESS` es activado por un cambio en su lista de sensibilidad y la lógica dentro del `PROCESS` conduce a una asignación de un nuevo valor a una variable, el efecto es inmediato. Por lo tanto, estas variables se actualizan en el orden de las declaraciones dentro de la estructura `PROCESS`. Por otro lado, las `SEÑALES` que se alteran dentro de un `PROCESS` son manejadas al final del proceso ({cite:t}`Tocci2017`).


## Estructura ELSIF

Es común que se presente la situación en la que se debe elegir entre varias acciones a realizar cuando se está resolviendo un programa. Se ha mencionado que la estructura de control de flujo **IF** elige si se realiza un conjunto de insrucciones con base en una condición de control. Por su parte, la estructura **IF/ELSE** selecciona una de dos acciones posibles, tambén considerando un criterio establecido en una condición de control. En VHDL existe la estructura **ELSIF**, la cual es resultado de la combinación de las estructuras **IF** y **ELSE**. Esta estructura en particular elige entre varios resultados podibles. En la {numref}`flujo_elsif` se presenta de forma gráfica el flujo de programa cuando se incluye la estructura **ELSIF**. En el diagrama de flujo se observa que se evalua cada una de las condiciones establecidas en el enunciado **ELSIF**, se realiza una acción o conjunto de instrucciones si la condicion es verdadera (**V**) y una acción o conjunto de instrucciones diferente si es falso **F**. Además, cada una de las acciones está asociada con una condición y no es posible seleccionar mas de una acción por el direccionamiento al bloque marcado con la etiqueta "final". Dado que las condiciones utilizadas para decidir la acción apropiada pueden ser cualquier expresión que se evalúe como verdadera o falsa, es posible utilizar los operadores de desigualdad para elegir una acción basada en un rango de valores.


```{figure} /images/flujo1.png
:height: 350px
:name: flujo_elsif
Diagrama de flujo de la estructura de control ELSIF.
```

Un ejemplo cásico de aplicación es un convertidor analógico digital de 4 bits que se utiliza para el monitoreo de la presión en un tanque de un compresor de aire. En dicha aplicación se requiere encender una alarma visual para cada una de las posibles situaciónes en las que se encuentre la presión en el contenedor. Una posible asiganción del rango para el cual se enciende cada una de las alarmas visuales se muestra en la siguiente tabla:


```{list-table} Tabla de rangos para alarmas visuales
:header-rows: 1
:align: left
:name: tablaPresion

* - Valor digital
  - Clasificación
* - $0000-1001$
  - Baja presión
* - $1010-1011$
  - Presión adecuada
* - $1100-1111$
  - Alta presión
```
El siguiente código en VHDL describe el circuito lógico capaz de realizar esta acción.


``` VHDL
-------------------------------------------------------------
-- Estructura ELSIF en VHDL aplicada al monitoreo de presión
-------------------------------------------------------------
entity monitor_presion is
 PORT (dato_digital : IN INTEGER RANGE 0 TO 15;
       baja_presion, presion_adecuada, alta_presion : OUT BIT);
end monitor_presion;

architecture arq of monitor_presion is
SIGNAL estado : BIT_VECTOR (2 DOWNTO 0);
begin 
    Process (dato_digital)
      begin
         if(dato_digital <= 9) then
           estado <="100";
         elsif(dato_digital >9 AND dato_digital < 11 ) then 
           estado <="010";
         else 
           estado <="001";
       end if;
end Process;

baja_presion     <= estado(2);
presion_adecuada <= estado (1);
alta_presion     <= estado(0);

end arq; 
```
La salida en vivado de la simulación del código anterior se muestra en la figura de abajo:

```{figure} /images/sim_presion.png
:height: 350px
:name: sim_presion
Salida de la simulación en vivado.
```
## Estructura Case

Una estructura de control muy importante es aquella que se utiliza para elegir acciones basadas en condiciones determinadas muy específicas es común que a esta estructura en particular se le denomine usando la palabra reservada **CASE**. En VHDL, la estructura **CASE** considera un valor específico de una expresión u objeto y luego evalua una lista de posibles valores o casos para la expresión u objeto de interés. Esta estructura hace alusión a la revisión de una contraseña, dado que realizará una instrucción solamente cuando el dato que se compara es exactamente el solicitado en vez de un rango de valores como en el caso de la estructura **IF** o **IF/ELSIF**. Por ejemplo, para describir el funcionamiento de una máquina selectora de monedas, realizada por medio de lógica combinacional, se propone el siguiente código en VHDL.

``` VHDL
----------------------------------------------------------------
-- Estructura CASE en VHDL aplicada a la selección de monedas
----------------------------------------------------------------
entity monedas is
 PORT ( un_peso, dos_pesos, cinco_pesos : IN BIT;
       centavos : OUT INTEGER RANGE 0 to 500);
end monedas;

architecture detecta of monedas is
SIGNAL monedas : BIT_VECTOR (2 DOWNTO 0);
begin 
    monedas <= (un_peso & dos_pesos & cinco_pesos);
    Process (monedas)
      begin
       CASE (monedas) is 
         When "001" => centavos <= 500;
         When "010" => centavos <= 200;
         When "100" => centavos <= 100;
         When others => centavos <= 0;
       end CASE;
end Process;
end detecta; 
```
La salida en vivado de la simulación del código anterior se muestra en la figura de abajo:

```{figure} /images/sim_monedas.png
:height: 350px
:name: sim_monedas
Salida de la simulación en vivado.
```
