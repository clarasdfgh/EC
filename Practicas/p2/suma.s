.section .data
#lista:		.int 1,2,10,  1,2,0b10,  1,2,0x10
#lista:		.int 1, 1, 1,
#lista:		.int 0x80000000, 0x80000000
#lista:		.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
lista:		.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
#lista:


longlista:	.int   (.-lista)/4
resultado:	.quad   0
formato: 	.asciz	"suma = %lu = 0x%lx hex\n"

.section .text
 main:  .global  main

	mov $lista, %rbx
	mov longlista, %ecx
	call suma
	mov %eax, resultado
	mov %edx, resultado+4

#imprimeC
	mov   $formato, %rdi
	mov   resultado,%rsi
	mov   resultado,%rdx
	mov          $0,%eax	# varargin sin xmm
	call  printf		# == printf(formato, res, res);

	mov $0, %edi
	call _exit


suma:
	mov  $0, %eax
	mov  $0, %edx
	mov  $0, %rsi
bucle:
	add  (%rbx,%rsi,4), %eax
	jnc noacar
	inc %edx
	
noacar:
	inc %rsi
	cmp %rsi, %rcx
	jne bucle
	ret

	#pop   %rdx
	ret

