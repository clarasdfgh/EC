	.file	"msum.c"
	.text
	.globl	main
	.type	main, @function
main:
	subq	$24, %rsp
	leaq	8(%rsp), %rdx
	movl	$3, %esi
	movl	$2, %edi
	call	sumstore@PLT
	movl	8(%rsp), %eax
	addq	$24, %rsp
	ret
	.size	main, .-main
	.globl	plus
	.type	plus, @function
plus:
	leaq	(%rdi,%rsi), %rax
	ret
	.size	plus, .-plus
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
