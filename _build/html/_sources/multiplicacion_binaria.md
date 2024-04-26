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
