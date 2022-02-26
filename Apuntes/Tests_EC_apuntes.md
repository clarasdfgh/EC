## TEMA 1

### Registros

###### MAR

- Contiene dirección de memoria
- Conectado a bus de direcciones
- Mismo tamaño que bus de direcciones (tamaño bus 64b == tamaño mar 64b)
- En captación, en MAR indicamos la dirección donde está la instrucción y en MBR recogemos la instrucción
- MAR requiere menos señales de control que MBR

###### MDR/MBR

- El registro MDR/MBR contiene el valor que va a ser almacenado en la memoria, o bien se usa para recibir un valor procedente de la memoria
- MBR contiene el último dato (o instrucción) leído de memoria, o el dato que se va a escribir en memoria

###### PC/Contador de programa/Program counter

- Depende del número de direcciones de memoria

###### Registros de propósito general

- %eax, %ebx, %ecx, %edx, %esi, %edi

###### RIP

- En x86-64, el registro contador de programa se denomina:

### Acumulador

- Load X: traer la pos de memoria x a acumulador
- Tipo 1/1

### Alineamiento

- Más rápido acceder a una palabra alineada que a una no alineada
- El ancho de palabra de una memoria corresponde a la cantidad de bits que caben en una sola posición
- Para ver si una palabra está alineada: se trata de detectar una dirección múltiplo del tamaño de palabra

### Direccionamiento

###### Absoluto

- El rango de posiciones direccionables queda limitado por el tamaño del campo de operando
- El objeto está en una posición de la memoria principal
- La instrucción contiene la dirección de memoria exacta en la que se encuentra el objeto

###### Directo a memoria

- Utiliza un desplazamiento
- Respecto a direccionamiento a memoria en ensamblador IA32 (sintaxis  AT&T), de la forma D(Rb, Ri, S):
  - El desplazamiento D puede ser una constante literal (1, 2 ó 4 bytes)
  - ESP no se puede usar como registro índice
  - El factor de escala S puede ser 1, 2, 4, 8


###### Implícito

- En el direccionamiento implícito no se indica la ubicación del operando

###### Indirecto

- El direccionamiento indirecto indica un puntero al operando
- Indirecto a través de registro: el dato está contenido en una posición de memoria que es apuntada por un registro de propósito general

###### Directo

- 

###### Inmediato

- En el direccionamiento inmediato el dato se encuentra en la propia instrucción

###### A registro

- La instrucción IA32 add array(,%ebx,4), %edx usa direccionamiento a registro
- El dato se encuentra en un registro de propósito general

###### Relativo a base / Indexado

- La dirección se calcula como la suma de un dato codificado en la propia instrucción y el contenido de un registro de propósito general.

### Buses

- conectado a bus de datos y unidad de control, mismo tamaño que bus de control
- En el arbitraje de un bus si hay un único dispositivo pasivo, siempre funciona como esclavo
- En un sistema con dos buses separados, uno para el subsistema de memoria y otro para la E/S, el bus que une la memoria y el procesador suele funcionar a la velocidad de la memoria
- Un bus se compone de líneas de control/estado, líneas de dirección y líneas de datos

###### Bus único

- Sólo una unidad funcional puede tener el control del bus en cada momento
- Sólo un dispositivo puede escribir en un instante dado en el bus
- Se utilizan las mismas líneas de control para conectar todos los dispositivos
- El procesador y los periféricos pueden funcionar a diferentes velocidades si el funcionamiento del bus es asíncrono

###### Bus del sistema

- El que conecta CPU-M, ya sea un sistema con bus único o con múltiples buses

###### Bus de direcciones

- NO tiene línea para indicar el sentido de transferencia de datos
- MAR conectado a bus de direcciones, mismo tamaño que este
- El espacio direccionable en memoria depende del diseño del bus de direcciones

### Unidad de control

- Secuenciamiento de las instrucciones máquina

### Ancho de memoria

- Corresponde a la longitud del registro de datos de la memoria

### Repertorio de instrucciones

- ISA: Instruction Set Architecture

###### RISC

- Se usa un porcentaje elevado de las instrucciones del repertorio
- La decodificación de las instrucciones debe ser simple: un computador RISC debería emplear un único formato de instrucción
- Un computador RISC no debe emplear microprogramación
- Para acelerar el computador RISC se emplean técnicas de pipelining
- Las arquitecturas RISC simplifican la decodificación
- Las arquitecturas RISC son del tipo registro-registro

###### CISC

- Respecto a la ecuación de rendimiento T=(N⋅S)/R, el objetivo de un diseño CISC es disminuir N (número de instrucciones a ejecutar por el programa)
- En las arquitecturas CISC hay más instrucciones que en las RISC

### Von-Neumann

- Modelo de programa almacenado

### Microprocesadores:

- 64 bits:
  - Core i3, Core i7,Itanium
- 32 bits:
  - AVR ATMega

### Mapear memoria

- Un computador con 13 líneas de direcciones utiliza E/S mapeada a  memoria. Si se supone que cada uno de los periféricos ocupa 4  direcciones y que el número de periféricos que se planea conectar es de  2^10, ¿qué tamaño de memoria admite el computador? 
  - 2¹²
- Para direccionar una memoria de 1 G palabras de 32 bits cada una, que se direcciona byte a byte, se necesitarán 32bits

### Valores extremos

- El valor mínimo (más negativo) que puede tomar un entero de 32 bits en complemento a dos es -2 ³²⁻¹
- El mayor valor que puede calcularse con enteros de 4B con signo sin problemas es 3³²⁻¹ (el 32 sale de pasar 4B a 32b)

### Rendimiento

- Si N es el número de instrucciones máquina de un programa, F es la  frecuencia de reloj, y C el número promedio de ciclos por instrucción,  el tiempo de ejecución del programa será N·C/F
- No son unidades fiables: MIPS, MFLOPS etc.
- La ecuación básica de rendimiento calcula cuánto tiempo tarda en ejecutarse un programa concreto conociendo su  número de instrucciones y el número de etapas (promedio) y la frecuencia del procesador
- El parámetro más importante para comparar la velocidad de dos ordenadores es el resultado de la ejecución de un conjunto de programas de prueba
- Una máquina superescalar emite simultáneamente múltiples instrucciones por ciclo de reloj, por ejemplo, una entera y otra de coma flotante

###### Benchmark SPEC CPU

- Se cronometran unos 12 tests de enteros (CINT2006) y unos 17 tests de punto flotante (CFP2006)
- La última versión es SPEC CPU2006 V1.2 de 2011
- Se usa como referencia un computador UltraSPARC II 300MHz, y para cada test se calcula el cociente entre el tiempo de ejecución en el computador a testear y en el de referencia
- El resultado final es la media GEOMÉTRICA de las (12 ó 17) velocidades, bien sea de enteros ó de punto flotante (SPECint2006 ó SPECfp2006)

### Generaciones

###### Primera

- Tubos de vacío
- Núcleos de ferrita al final de la primera, pero prácticamente segunda

###### Segunda

- Transistores

###### Tercera

- Caché
- Tiempos de conmutación del orden de nanosegundos

###### Cuarta

- Memoria de semiconductores

## TEMA 2

### While

- `while (test) body;`  == `if (!test) goto done; loop: body; if (test) goto loop; done:`

### Do-while

- Salto condicional hacia atrás, según la misma condición que en lenguaje C

### Para hacer tal cosa...

- Para desplazar %eax a la derecha un número variable de posiciones <= 32, indicado en %ebx, se puede hacer
  - `mov %ebx, %ecx; sar  %cl, %eax`
- Para crear espacio en la pila para variables locales sin inicializar al principio de una función
  - `sub $0x30, %rsp`
- Para poner a 1 el bit 5 del registro %edx sin cambiar el resto de bits podemos usar la instrucción máquina
  - `or $0x20, %edx`
- Con el repertorio IA32, para sumar %eax y %ebx dejando el resultado en %ecx se podría hacer lo siguiente
  - `lea (%eax, %ebx, 1), %ecx`


### Instrucciones

- La instrucción `movzbl %al, %eax` copia en %eax el valor sin signo almacenado en %al, rellenando con ceros
- La primera letra (l) de la instrucción lea es parte del mnemotécnico
- El sufijo l de la instrucción movl significa 32bits (long)
- La instrucción leave hace exactamente lo mismo que `mov %ebp, %esp; pop %ebp`
- La diferencia entre mov y lea es que mov referencia (accede) la posición indicada, mientras que lea no lo hace

#### Erróneas

- `movzlq %edx, %rax` no existe movzlq, usar "mov %edx, %eax" para conseguir el mismo efecto

### Indicadores de estado

- El indicador N se pone a 1 cuando el resultado es negativo
- Una instrucción de "salto si igual" tiene que comprobar el valor de el bit de cero
- Una instrucción de salto si menor, para números positivos sin signo, tiene que comprobar el valor de el bit de acarreo

### RSP

- Si %rsp vale 0xdeadbeefdeadd0d0, después de que se ejecute pushq %rbx queda 0xdeadbeefdeadd0c8 (restamos 8, si restamos menos no cabe una quadword)
- El procesador utiliza el puntero de pila en las instrucciones de llamadas y retornos de subrutinas

### Verdadero-Falso

###### Verdadero

- Para un mismo procesador puede ocurrir que existan dos instrucciones  cuyos campos de código de operación tengan diferente longitud
- Una instrucción de llamada a subrutina es más compleja en general que una de salto
- Las instrucciones de E/S consituyen menos del 5% de las instrucciones ejecutadas en un ordenador

###### Falso

- Las arquitecturas memoria-memoria tienen la ventaja de emplear  instrucciones máquina muy cortas y así los accesos a memoria son  mínimos
- La instrucción DI (Disable Interrupts) utiliza direccionamiento inmediato
- La instrucción ADD Rn,#3 suma el contenido del registro Rn con el de la posición de memoria 3
- Las instrucciones máquina más frecuentes en programas típicos son las de transferencia de datos para análisis estáticos y las aritméticas para  análisis dinámicos
- El programa ensamblador siempre resuelve todas las referencias usadas en el fichero fuente

### Arrays

- Se ha declarado en un programa C la variable int val[5]={1,5,2,1,3}; 
  - val[1] == 1
  - &val[3] == (char *)val + 12
  - sizeof(val) == 5
- 

### Pila

- La pila es un conjunto de posiciones de memoria usadas para almacenar información temporal durante la ejecución del programa

## TEMA 3

### Verdadero o falso

###### Verdadero

- En el secuenciamiento de microinstrucciones explícito cada  microinstrucción incluye la dirección de la microinstrucción siguiente
- Se podría diseñar una CPU microprogramada de manera que la captación y  la ejecución de microinstrucciones se solapasen en el tiempo
- SP y PC no son registros de uso general (GPR)
- Las señales de carga/incremento/desplazamiento de registros, las de  selección de entradas de multiplexores, y las de selección de función de la ALU son salidas de la unidad de control
- Si se emplea una memoria de control del tipo RAM, es posible cambiar el  repertorio de instrucciones de un ordenador sin necesidad de volver a  diseñar y fabricar su hardware

###### Falso

- Un microprocesador es superencauzado ("superpipelined") si permite la  emisión de dos o más instrucciones en un mismo ciclo de reloj
- El objetivo del control residual es aumentar la  velocidad de ejecución de microinstrucciones, aunque esto tiene el  inconveniente de aumentar el tamaño del microprograma
- Un microprocesador es superescalar si tiene un número mayor de etapas y éstas son más cortas que las de un cauce ("pipeline") normal, permitiendo una velocidad de reloj mayor

### Microinstrucciones

- Una posible codificación en microinstrucciones de la instrucción CALL X es SP=SP-1 ; m[SP]=PC ; PC=X

- Suponga que la micropalabra de una máquina microprogramada tiene 8 bits  de ancho y se usan 16 micropalabras diferentes en un microprograma de  256 micropalabras. Si se usa nanoprogramación se ahorran bits pero el funcionamiento es más lento

  - ahorro de memoria: 

    `m*w - (n*log2(m) + m*w)`

### Buses

- La conexión de las salidas de tres registros hacia un bus común en el camino de datos puede realizarse usando dos multiplexores 2 a 1
- Una CPU con bus de direcciones de 16 bits y bus de datos de 8 bits tiene un registro de 8 bits conectado al bus de datos y a la unidad de control Puede tratarse del registro de instrucción
  - Es decir: el registro de instrucción tiene el mismo tamaño que el bus de datos

### Funciones de la UC

- Son funciones de la UC
  - Secuenciamiento de las instrucciones máquina
  - Generación de las señales de control que provocan la ejecución de cada instrucción
  - Decodificación de las instrucciones
- Son salidas de la UC
  - señales de lectura y escritura en memoria (RD, WR)
  - señales de carga, habilitación y/o desplazamiento de registros (Load, Enable, ShiftL, ShiftR)
  - códigos de selección en multiplexores, decodificadores, ALU, etc (00, 01, 10, 11…)

### Solapamiento

- Sea un formato de microinstrucción que incluye dos campos independientes de 10 bits cada uno. Si se rediseña de modo que se solapen los dos  campos, ¿cuántos bits se ahorran en cada microinstrucción? 9

### Frecuencia máxima

- Si un procesador no segmentado necesita 5 ns para leer una instrucción  de memoria, 2 ns para decodificar la instrucción, 3 ns para leer del  banco de registros, 3 ns para realizar el cálculo requerido por la  instrucción, y 2 ns para escribir el resultado en el banco de registros, ¿cuál es la frecuencia de reloj máxima del procesador?
  - 66,67 MHz, 