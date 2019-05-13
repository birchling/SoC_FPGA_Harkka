	.file	"main.c"
	.text
	.globl	createKromosomi
	.type	createKromosomi, @function
createKromosomi:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	call	rand@PLT
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$31, %eax
	addl	%eax, %edx
	andl	$1, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	a.2176(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	addl	$1, -4(%rbp)
.L2:
	cmpl	$9, -4(%rbp)
	jle	.L3
	leaq	a.2176(%rip), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	createKromosomi, .-createKromosomi
	.section	.rodata
.LC0:
	.string	"%d  "
	.text
	.globl	tulostaKromosomi
	.type	tulostaKromosomi, @function
tulostaKromosomi:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L6
.L7:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -4(%rbp)
.L6:
	cmpl	$9, -4(%rbp)
	jle	.L7
	movl	$10, %edi
	call	putchar@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	tulostaKromosomi, .-tulostaKromosomi
	.section	.rodata
.LC1:
	.string	"Kromosomi %i: "
.LC2:
	.string	"%d "
	.text
	.globl	tulostaPopulaatio
	.type	tulostaPopulaatio, @function
tulostaPopulaatio:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L9
.L12:
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -4(%rbp)
	jmp	.L10
.L11:
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	movl	(%rdx,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -4(%rbp)
.L10:
	cmpl	$9, -4(%rbp)
	jle	.L11
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -8(%rbp)
.L9:
	cmpl	$9, -8(%rbp)
	jle	.L12
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	tulostaPopulaatio, .-tulostaPopulaatio
	.globl	luoPopulaatio
	.type	luoPopulaatio, @function
luoPopulaatio:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L14
.L17:
	movl	$0, %eax
	call	createKromosomi
	movq	%rax, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L15
.L16:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	(%rsi), %edx
	movl	-16(%rbp), %eax
	cltq
	movl	%edx, (%rcx,%rax,4)
	addl	$1, -12(%rbp)
.L15:
	cmpl	$9, -12(%rbp)
	jle	.L16
	addl	$1, -16(%rbp)
.L14:
	cmpl	$9, -16(%rbp)
	jle	.L17
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	luoPopulaatio, .-luoPopulaatio
	.globl	mutaatio
	.type	mutaatio, @function
mutaatio:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L19
.L24:
	movl	$0, -4(%rbp)
	jmp	.L20
.L23:
	call	rand@PLT
	movl	%eax, %ecx
	movl	$1374389535, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$5, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	imull	$100, %eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	cmpl	%eax, -28(%rbp)
	jle	.L21
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	movl	(%rdx,%rax,4), %eax
	cmpl	$1, %eax
	jne	.L22
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	movl	$0, (%rdx,%rax,4)
	jmp	.L21
.L22:
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	movl	$1, (%rdx,%rax,4)
.L21:
	addl	$1, -4(%rbp)
.L20:
	cmpl	$9, -4(%rbp)
	jle	.L23
	addl	$1, -8(%rbp)
.L19:
	cmpl	$9, -8(%rbp)
	jle	.L24
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	mutaatio, .-mutaatio
	.globl	GetFitnesses
	.type	GetFitnesses, @function
GetFitnesses:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L26
.L27:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	addl	$1, -8(%rbp)
.L26:
	cmpl	$9, -8(%rbp)
	jle	.L27
	movl	$0, -8(%rbp)
	jmp	.L28
.L31:
	movl	$0, -4(%rbp)
	jmp	.L29
.L30:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %ecx
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	movl	(%rdx,%rax,4), %edx
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rsi
	movq	-32(%rbp), %rax
	addq	%rsi, %rax
	addl	%ecx, %edx
	movl	%edx, (%rax)
	addl	$1, -4(%rbp)
.L29:
	cmpl	$9, -4(%rbp)
	jle	.L30
	addl	$1, -8(%rbp)
.L28:
	cmpl	$9, -8(%rbp)
	jle	.L31
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	GetFitnesses, .-GetFitnesses
	.globl	isInList
	.type	isInList, @function
isInList:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L33
.L35:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -28(%rbp)
	jne	.L34
	movl	$1, -8(%rbp)
.L34:
	addl	$1, -4(%rbp)
.L33:
	movl	-4(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	.L35
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	isInList, .-isInList
	.globl	CrossOver
	.type	CrossOver, @function
CrossOver:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -120(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -108(%rbp)
	jmp	.L38
.L42:
	movl	$-1, -112(%rbp)
	movl	$0, -104(%rbp)
	jmp	.L39
.L41:
	movl	-108(%rbp), %edx
	movl	-104(%rbp), %ecx
	leaq	-96(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	isInList
	testl	%eax, %eax
	jne	.L40
	movl	-104(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -112(%rbp)
	jge	.L40
	movl	-108(%rbp), %eax
	cltq
	movl	-104(%rbp), %edx
	movl	%edx, -96(%rbp,%rax,4)
	movl	-104(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-128(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -112(%rbp)
.L40:
	addl	$1, -104(%rbp)
.L39:
	cmpl	$9, -104(%rbp)
	jle	.L41
	addl	$1, -108(%rbp)
.L38:
	cmpl	$9, -108(%rbp)
	jle	.L42
	movl	$0, -108(%rbp)
	jmp	.L43
.L50:
	call	rand@PLT
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$31, %eax
	addl	%eax, %edx
	andl	$1, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -100(%rbp)
	cmpl	$0, -100(%rbp)
	je	.L44
	movl	$0, -104(%rbp)
	jmp	.L46
.L44:
	movl	$5, -104(%rbp)
	jmp	.L46
.L48:
	movl	-108(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-120(%rbp), %rax
	addq	%rax, %rdx
	movl	-104(%rbp), %eax
	cltq
	movl	(%rdx,%rax,4), %edx
	movl	-104(%rbp), %eax
	cltq
	movl	%edx, -48(%rbp,%rax,4)
	movl	-108(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	-96(%rbp,%rax,4), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-120(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-108(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-120(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-104(%rbp), %eax
	cltq
	movl	(%rsi,%rax,4), %edx
	movl	-104(%rbp), %eax
	cltq
	movl	%edx, (%rcx,%rax,4)
	movl	-108(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	-96(%rbp,%rax,4), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movq	-120(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-104(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %edx
	movl	-104(%rbp), %eax
	cltq
	movl	%edx, (%rcx,%rax,4)
	addl	$1, -104(%rbp)
.L46:
	cmpl	$4, -104(%rbp)
	jg	.L47
	cmpl	$0, -100(%rbp)
	jne	.L48
.L47:
	cmpl	$9, -104(%rbp)
	jg	.L49
	cmpl	$0, -100(%rbp)
	je	.L48
.L49:
	addl	$2, -108(%rbp)
.L43:
	cmpl	$9, -108(%rbp)
	jle	.L50
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L51
	call	__stack_chk_fail@PLT
.L51:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	CrossOver, .-CrossOver
	.section	.rodata
.LC3:
	.string	"Best found in kromosomi %d\n"
	.text
	.globl	getBestFitness
	.type	getBestFitness, @function
getBestFitness:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$-1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L53
.L56:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -8(%rbp)
	jge	.L54
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -8(%rbp)
	cmpl	$10, -8(%rbp)
	jne	.L54
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-8(%rbp), %eax
	jmp	.L55
.L54:
	addl	$1, -4(%rbp)
.L53:
	cmpl	$9, -4(%rbp)
	jle	.L56
	movl	-8(%rbp), %eax
.L55:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	getBestFitness, .-getBestFitness
	.globl	getBestIndex
	.type	getBestIndex, @function
getBestIndex:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$-1, -12(%rbp)
	movl	$-1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L58
.L61:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -12(%rbp)
	jge	.L59
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
	cmpl	$10, -12(%rbp)
	jne	.L59
	movl	-4(%rbp), %eax
	jmp	.L60
.L59:
	addl	$1, -4(%rbp)
.L58:
	cmpl	$9, -4(%rbp)
	jle	.L61
	movl	-8(%rbp), %eax
.L60:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	getBestIndex, .-getBestIndex
	.section	.rodata
.LC4:
	.string	"In generation %d\n"
	.align 8
.LC5:
	.string	"Best possible answer found in kromosomi %d\n"
.LC6:
	.string	"Best = %d\n"
.LC7:
	.string	"Something went wrong"
	.align 8
.LC8:
	.string	"Fitness of best individual = %d\n"
.LC9:
	.string	"Generation %d completed\n"
.LC10:
	.string	"Fitness #%d = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$480, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$-1, -472(%rbp)
	movl	$1000, -468(%rbp)
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	leaq	-416(%rbp), %rax
	movq	%rax, %rdi
	call	luoPopulaatio
	movl	$0, -476(%rbp)
	jmp	.L63
.L67:
	leaq	-416(%rbp), %rax
	movl	$10, %esi
	movq	%rax, %rdi
	call	mutaatio
	leaq	-464(%rbp), %rdx
	leaq	-416(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	GetFitnesses
	leaq	-464(%rbp), %rdx
	leaq	-416(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	CrossOver
	leaq	-464(%rbp), %rdx
	leaq	-416(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	GetFitnesses
	leaq	-464(%rbp), %rax
	movq	%rax, %rdi
	call	getBestFitness
	movl	%eax, -472(%rbp)
	cmpl	$10, -472(%rbp)
	jne	.L64
	movl	-476(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-464(%rbp), %rax
	movq	%rax, %rdi
	call	getBestIndex
	addl	$1, %eax
	movl	%eax, %esi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-472(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L65
.L64:
	cmpl	$10, -472(%rbp)
	jle	.L66
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
	jmp	.L65
.L66:
	movl	-472(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-476(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC9(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -476(%rbp)
.L63:
	movl	-476(%rbp), %eax
	cmpl	-468(%rbp), %eax
	jl	.L67
.L65:
	leaq	-416(%rbp), %rax
	movq	%rax, %rdi
	call	tulostaPopulaatio
	movl	$0, -480(%rbp)
	jmp	.L68
.L69:
	movl	-480(%rbp), %eax
	cltq
	movl	-464(%rbp,%rax,4), %eax
	movl	-480(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	%eax, %edx
	movl	%ecx, %esi
	leaq	.LC10(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -480(%rbp)
.L68:
	cmpl	$9, -480(%rbp)
	jle	.L69
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L71
	call	__stack_chk_fail@PLT
.L71:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.local	a.2176
	.comm	a.2176,40,32
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
