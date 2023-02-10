.data
	intArray:
		.align 2 #alinha a palavrana posição correta, para inteiros
		.space 40 #aloca espaço para 10 inteiros, pois cada inteiro tem 4 bytes. 4*10 = 40
	x: .word 1
	enter: .asciiz "\n"
.text
	lw $t8, x # $t8 = x
	move $t0, $zero #indicie inicial do array
	
	preencheVetor:				# preenche o vetor com 'x'
		beq $t0, 40, printVetor		# if( $t0 = 40): vá para while
		sw $t8, intArray($t0)		# intArray[$t0] = $t8
		addi $t0, $t0, 4 		# incrementa o indice, para uma nova posição tem que ser somada uma quantidade iagual ao tamanho do tipo (int: 4bytes)
		j preencheVetor
		
	printVetor: #imprime o vetor inicial
	
		move $t0, $zero #zerando contador
		print:
			beq $t0, 40, continue	# se o vetor terminar, va para continue
			li $v0, 1		# imprimindo cada elemento
			lw $a0, intArray($t0)	# $a0 = intArray[$t0]
			syscall
			addi $t0, $t0, 4
			j print
		
	continue:
		li $v0, 4 # imprime um enter
		la $a0, enter
		syscall
		
		move $t0, $zero #zerando contador
	
	while:
		beq $t0, 40, saida 	# if( $t0 = 40): vá para saida
		lw $t9, intArray($t0)	# $t9 = intArray[$t0]
		addi $t9, $t9, 1	# $t9++
		sw $t9, intArray($t0)	# intArray[$t0] = intArray[$t0] + 1
		addi $t0, $t0, 4 	# incrementa o indice
		j while
		
	saida:
		move $t0, $zero #zerando contador
		imprime:
			beq $t0, 40, fim	# se o vetor terminar, va para fim
			li $v0, 1		# imprimindo cada elemento
			lw $a0, intArray($t0)	# $a0 = intArray[$t0]
			syscall
			addi $t0, $t0, 4
			j imprime
	fim:
