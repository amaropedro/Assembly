.data
	a: .word 5
	B: .word 1
	m: .word 2
	n: .word 0
.text
	lw $t0, a #carregando os dados da memoria para os registradores
	lw $t1, B
	lw $t2, m
	lw $t3, n
	
	blt $t1, $t2, segundaCondição #if( B < m): pula para a segunda condição.
	sw $t2, n #else n = $t2, n = m
	
	jal fim #vai para a função que finaliza o programa
	
	segundaCondição:
		blt $t3, $t0, atribuição #if( n < a): pula para a atribuição.
		
	sw $t2, n#else n = $t2, n = m
	jal fim
	
	atribuição:
		sw $t1, n # n = $t1, n = B
	
	fim:
		li $v0, 10 #finaliza o programa
		syscall
