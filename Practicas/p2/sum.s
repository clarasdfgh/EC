	.file	"sum.c"
	.text
	.globl	sumstore
	.type	sumstore, @function
sumstore:
	pushq	%rbx
	movq	%rdx, %rbx
	call	plus@PLT
	movq	%rax, (%rbx)
	popq	%rbx
	ret
	.size	sumstore, .-sumstore
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
