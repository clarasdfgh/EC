# EC 2122 - Práctica 3

En la práctica anterior vimos lo conveniente de dividir el código en varias funciones para mejor legibilidad y comprensión. Algunos aspectos de convención que vimos:

- El resultado se devuelve al programa principal a través de EAX
- Los argumentos (tamaño y posición de la lista) se pasan a la función a través de RBX/ECX
- La subrutina preserva el valor de RDX (y otros registros)

----

- Los registros **salvainvocantes**: los podemos usar directamente en la función, PERO no podemos confiar en que conserven su valor tras la llamada

- Los registros **salvainvocados**: debemos salvar a pila su valor para luego de usarlos restaurar su valor, pero podemos confiar en que tras llamar a otra función el valor se mantendrá



A partir de ahora utilizaremos el sistema de convención SystemV:

- Los 6 primeros parámetros se pasan en los registros RDI RSI RDX RCX R8 R9 (Diane's Silk Dress Costs 89)

  - Los parámetros siguientes se pasan en pila de derecha a izquierda (el último el primero)

- El espacio de pila para el paso de parámetros lo libera EL INVOCANTE (antes de llamar a la función)

- El resultado se devuelve en RAX

- Los registros de parámetros (Diane's Silk Dress...), retorno y R10, R11 son salvainvocantes (es responsabilidad del invocante guardar su valor (si es que lo necesita) previa llamada a la función)

- RBX, RBP y R12 a R15 son salvainvocados (si se modifican hay que guardarlos en pila y restaurarlos antes de return)

- RSP no debe manipularse, es el puntero a pila

  | Tipo de variable | Registro  |
  | ---------------- | --------- |
  | enteros 128 bits | RDX:RAX   |
  | unsigned long    | RAX       |
  | unsigned int     | EAX       |
  | unsigned short   | AX        |
  | unsigned char    | AL        |
  | punteros         | RAX       |
  | float y double   | XMM0/XMM1 |

