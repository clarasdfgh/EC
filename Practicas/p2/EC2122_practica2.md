# EC 2122 - Práctica 2

### Ejercicio 1 - `gcc`

Crear los ficheros sum.c y msum.c mostrados anteriormente, y reproducir con ellos la siguiente sesión en línea de comandos Linux:

```
gcc sum.c msum.c -o sum

./sum ; echo $?
	>5

file sum
	>sum: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=5700a7dfe2054db3048d56d7c319945f02c33fa5, for GNU/Linux 4.4.0, not stripped
```

```
gcc -no-pie sum.c msum.c -o sum

./sum ; echo $?
	>5
file sum
	>sum: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=405c78eb6310cd62d61580f538d3418a8b118359, for GNU/Linux 4.4.0, not stripped
```

```
FNSP=-fno-stack-protector
FNAUT=-fno-asynchronous-unwind-tables
```

```
gcc -Og -S sum.c $FNAUT
cat sum.s
```

> **sum.s**
>
> ```assembly
> .file	"sum.c"
> 	.text
> 	.globl	sumstore
> 	.type	sumstore, @function
> sumstore:
> 	pushq	%rbx
> 	movq	%rdx, %rbx
> 	call	plus@PLT
> 	movq	%rax, (%rbx)
> 	popq	%rbx
> 	ret
> 	.size	sumstore, .-sumstore
> 	.ident	"GCC: (GNU) 11.1.0"
> 	.section	.note.GNU-stack,"",@progbits
> ```

```
gcc -Og -S msum.c $FNAUT $FNSP 
cat msum.s
```

> **msum.s**
>
> ```assembly
> .file	"msum.c"
> 	.text
> 	.globl	main
> 	.type	main, @function
> main:
> 	subq	$24, %rsp
> 	leaq	8(%rsp), %rdx
> 	movl	$3, %esi
> 	movl	$2, %edi
> 	call	sumstore@PLT
> 	movl	8(%rsp), %eax
> 	addq	$24, %rsp
> 	ret
> 	.size	main, .-main
> 	.globl	plus
> 	.type	plus, @function
> plus:
> 	leaq	(%rdi,%rsi), %rax
> 	ret
> 	.size	plus, .-plus
> 	.ident	"GCC: (GNU) 11.1.0"
> 	.section	.note.GNU-stack,"",@progbits
> ```

```
gcc -c sum.s msum.c 
ls; file *.o
	>	main.c    msum.c  msum.s    		sum     sum.c  sum.s
		mstore.c  msum.o  saludo.s  		suma.s  sum.o
msum.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped

sum.o:  ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
```

```
gcc -no-pie sum.o msum.o -o sum 
file sum; ./sum; echo $?
	>sum: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=199aa7c8ec8f0761ff57fd097ae72262dd909ad4, for GNU/Linux 4.4.0, not stripped
	
5
```



### Ejercicio 2 - `as` y `ld`

El mismo resultado se puede obtener con las distintas herramientas separadamente (as y ld, limitando el uso de gcc a compilar C→ASM). Reproducir la siguiente sesión de comandos Linux. Notar que el último comando ld es tan largo que se ha fraccionado en dos líneas.

```
rm sum *sum.[os]; ls 
gcc -Og -S sum.c msum.c $FNAUT $FNSP 
ls *sum.?
	> msum.c  msum.s  sum.c  sum.s
```

```
as sum.s -o sum.o 

as msum.s -o msum.o 

ls *.o; file *.o 
	> msum.o  sum.o
msum.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
sum.o:  ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
```

Relocatable porque aún no están resueltas las direcciones de memoria

```
ld sum.o msum.o
	> Warning: falta _start
```

```
gcc -### sum.o msum.o
	>saldrá la ruta del crt en medio de un tocho gigante
	
gcc -### -no-pie *.o 
	>aquí hay menos tocho, hay que encontrar la ruta a crt	
	
ls /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/*crt*
	> /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbeginS.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbeginT.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtendS.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtfastmath.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtprec32.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtprec64.o
/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtprec80.o

```

```
ld sum.o msum.o -o sum -dynamic-linker /lib64/ld-linux-x86-64.so.2  /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crt?.o -lc

```

```
file sum; ./sum; echo $?
```



### Ejercicio 3 - `objdump` y `nm`

```
//me falta porque tuve que hacer malabares con las rutas
```



### Ejercicio 4 - `gdb -tui`

```
as –g saludo.s –o saludo.o 
ld saludo.o –o saludo 
gdb -tui saludo
```



 Enteros ocupan 32 bits, cada entero ocupa 4 posiciones de memoria
