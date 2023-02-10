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
	
	bge $t0, $zero, segundaCondição #if (a>= 0): pula para a segunda condição
	jal fim #else: pula para o fim do programa.
	
	segundaCondição:
		li $t4, 50
		ble $t1, $t4, terceiraCondição #if(b<=50): pula para a terceira condição
		jal fim #else: pula para o fim.
	
	terceiraCondição:
		beq $t2, $t3, atribuição #if(c==x): para para a atribuição
		jal fim #else: pula para o fim.
	
	atribuição:
		li $t4, 1
		sw $t4, x # x = $t4, x = 1
	
	fim:
		li $v0, 1
		lw $a0, x
		syscall
		li $v0, 10
		syscall
