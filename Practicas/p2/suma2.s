.section .data

#ifndef TEST
#define TEST 20
#endif
    .macro linea
#if TEST==1
        .int -1, -1, -1, -1
#elif TEST==2
        .int 0x04000000, 0x04000000
#elif TEST==3
        .int 0x08000000, 0x08000000
#elif TEST==4
        .int 0x10000000, 0x10000000
#elif TEST==5
        .int 0x7FFFFFFF, 0x7FFFFFFF
#elif TEST==6
        .int 0x80000000, 0x80000000
#elif TEST==7
        .int 0xF0000000, 0xF0000000
#elif TEST==8
        .int 0xF8000000, 0xF8000000
#elif TEST==9
        .int 0xF7FFFFFF, 0xF7FFFFFF
#elif TEST==10
        .int 100000000, 100000000
#elif TEST==11
        .int 200000000, 200000000
#elif TEST==12
        .int 300000000, 300000000
#elif TEST==13
        .int 2000000000, 2000000000
#elif TEST==14
        .int 3000000000, 3000000000
#elif TEST==15
        .int -100000000, -100000000
#elif TEST==16
        .int -200000000, -200000000
#elif TEST==17
        .int -300000000, -300000000
#elif TEST==18
        .int -2000000000, -2000000000
#elif TEST==19
        .int -3000000000, -3000000000
#else
    .error "Definir TEST entre 1..42"
#endif
    .endm


lista: .irpc i, 1234
				linea
		.endr  

longlista:	.int   (.-lista)/4
media:		.int	0
resto:		.int	0
formato: 	.ascii "media = %11d \t resto = %11d \n"
            	.asciz        "\t = 0x  %08x \t\t 0x  %08x\n"

.section .text
 main:  .global  main
	mov $lista, %rbx
	mov longlista, %ecx
	call suma
	mov %eax, media
	mov %edx, resto

#imprimeC
	mov   $formato, %rdi
	mov   media,%esi
	mov   resto,%edx
	mov   media,%ecx
	mov   resto,%r8d
	mov          $0,%eax	# varargin sin xmm
	call  printf		# == printf(formato, res, res);

	mov $0, %edi
	call _exit


suma:
	mov  $0, %edi
	mov  $0, %ebp
	mov  $0, %rsi
bucle:
	mov  (%rbx,%rsi,4), %eax
	cltd
	add %eax, %edi
	adc %edx, %ebp
	inc %rsi
	cmp %rsi, %rcx
	jne bucle
	
	mov %edi, %eax
	mov %ebp, %edx
	idiv  %ecx
	
	ret
	
	

