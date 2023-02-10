.data
	a: .word -1
	B: .word 50
	c: .word 10
	x: .word 10
.text
	lw $t0, a #carregando os dados da memoria para os registradores
	lw $t1, B
	lw $t2, c
	lw $t3, x
	
	bge $t0, $zero, segundaCondi��o #if (a>= 0): pula para a segunda condi��o
	jal fim #else: pula para o fim do programa.
	
	segundaCondi��o:
		li $t4, 50
		ble $t1, $t4, terceiraCondi��o #if(b<=50): pula para a terceira condi��o
		jal fim #else: pula para o fim.
	
	terceiraCondi��o:
		beq $t2, $t3, atribui��o #if(c==x): para para a atribui��o
		jal fim #else: pula para o fim.
	
	atribui��o:
		li $t4, 1
		sw $t4, x # x = $t4, x = 1
	
	fim:
		li $v0, 1
		lw $a0, x
		syscall
		li $v0, 10
		syscall
