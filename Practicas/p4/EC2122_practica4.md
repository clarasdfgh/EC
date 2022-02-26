### 0. Obtener las claves

- Abrimos en gdb el ejecutable, activamos `layout asm` y `layout regs`
- Breakpoint en main
  - Avanzamos con `nexti` para no entrar en subrutinas
  - Si queremos ir al siguiente br, avanzamos con `cont`
- En main+131 nos pide introducir la contraseña, introduzco "HOLA" como un valor arbitrario pero fácilmente reconocible
- En main+158 llama a strncmp y comparará nuestra contraseña con la contraseña correcta
  - Sabemos que strncmp requiere dos argumentos, es decir, siguiendo Diane's Silk Dress... nuestra contraseña y la contraseña correcta estarán en %rdi y %rsi
    - Vemos como en main+141 ha guardado el valor que hemos introducido previamente ("HOLA") dentro de %rdi, `lea 0x30(%rsp),%rdi`
      - En la ventana de registros, vemos que a rdi le corresponde 0x7fffffffdca0. Miramos su contenido con `x/s 0x7fffffffdca0` 
      - Devuelve la entrada "HOLA\n"
    - Vemos como en main+151 ha guardado el valor de la contraseña correcta dentro de %rsi, `lea 0x202867(%rip),%rsi`
      - En la ventana de registros, vemos que a rsi le corresponde 0x6030b0. Miramos su contenido con `x/s 0x6030b0` 
      - Devuelve la contraseña correcta "msLijSvh\n"
        - Podemos comprobar que esto es correcto ejecutando el programa en otra terminal y viendo que no explota
- Volvemos a hacer run desde el principio porque la bomba va a explotar inevitablemente, a continuación introducimos la contraseña correcta y llegamos hasta donde se introduce el pin.
- En main+252 se llama a la función que recoge el pin. Introduzco "0000" para reconocerlo luego.
- En main+282 está la instrucción que compara los dos pines: el nuestro y el correcto, `cmp %eax, 0xc(%rsp)`
  - Con print $eax vemos el pin correcto: 8476

> **Contraseña:** 	msLijSvh
>
> **Pin:** 					8476



### 1. Saltar las comprobaciones

- En main+163 se mira la salida de strcomp - cambiaremos el registro eax a 0 para que sea cierto y continue sin llamar a la explosión. `set $eax=0`
- En main+197 se mira el tiempo transcurrido. Para que no explote, antes de ejecutar el cmp  hacemos `set $eax=0`
- En main+288 se comprueba el pin. Para saltárnoslo, cambiamos el valor de eax al pin que hayamos introducido cuando nos lo pidió. En mi caso, 1234. `set $eax=1234`
- Finalmente, en main+324 hay otra comprobación del límite de tiempo. Hacemos exactamente igual, ponemos eax a 0. Bomba desactivada.

### 2. Anular las comprobaciones

- Primero miramos el código ensamblador del ejecutable, particularmente antes de las llamadas a boom

  ```
  ...
    400850:	74 05                	je     400857 <main+0xac>
    400852:	e8 20 ff ff ff       	call   400777 <boom>
  ...
    400874:	7e 0a                	jle    400880 <main+0xd5>
    400876:	e8 fc fe ff ff       	call   400777 <boom>
  ...
    4008cf:	74 05                	je     4008d6 <main+0x12b>
    4008d1:	e8 a1 fe ff ff       	call   400777 <boom>
  ...
    4008f3:	7e 05                	jle    4008fa <main+0x14f>
    4008f5:	e8 7d fe ff ff       	call   400777 <boom>
  ...
  ```

  - Vamos a cambiar los saltos je por un salto incondicional jmp. Así solo tendremos que cumplir el requerimiento de tiempo, así que solo hará falta introducir cualquier cosa mientras se introduzca en menos de 5 segundos. 

- Desde gbd hacemos `set write on` para permitir escritura, `file bombaProf5_23`

- Antes de cambiar las instrucciones comprobamos que, efectivamente, en las direcciones 0x400850 y 0x4008cf están las instrucciones je

- Cambiamos las órdenes con `set {char} 0x.... =0xeb`

- Comprobamos con `x/i 0x....` que las instrucciones ahora son jmp (salto incondicional)

### 3. Modificar la contraseña y pin

- Abrimos el ejecutable con ghex
- Para modificar la contraseña:
  - Ctrl+F, en el cuadro de la derecha buscamos la contraseña
  - En el cuadro de la derecha también cambiamos la contraseña por otra con la misma longitud de caracteres (8)
  - **Nueva contraseña:** AAAAAAAA

- Para modificar el pin:
  - Desde gdb consultamos en main+288 cómo se almacena el pin. Lo imprimimos con `x/lub 0x6020ac`
    - Nos devuelve 28, que en hexadecimal es 1C
  - Buscamos esta vez en el cuadro de la izquierda 1C. 
    - En este caso tendremos muchas coincidencias. Tenemos que ir buscando hasta que encontremos una que en el espacio de "signed 16bit" nos diga el pin (es decir, 1C no es parte de una secuencia de números más grande, sino que se corresponde con el pin). Ahí es donde habrá que cambiarlo
  - **Nuevo pin:** 8475
- Guardamos el ejecutable con un nombre distintivo, ejecutamos el programa y comprobamos que hemos cambiado correctamente las contraseñas.

> **Contraseña:** 	AAAAAAAA
>
> **Pin:** 					8475

