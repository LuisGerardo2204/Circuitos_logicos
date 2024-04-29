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

