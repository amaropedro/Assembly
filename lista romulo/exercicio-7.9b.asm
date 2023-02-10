.data
	intArray:
		.align 2 #alinha a palavrana posi��o correta, para inteiros
		.space 40 #aloca espa�o para 10 inteiros, pois cada inteiro tem 4 bytes. 4*10 = 40
	enter: .asciiz "\n"
	espa�o: .asciiz " "
.text
	move $t8, $zero # $t8 = 0
	move $t0, $zero #indicie inicial do array
	
	preencheVetor:				# preenche o vetor com numero de 0 a 9
		beq $t0, 40, printVetor		# if( $t0 = 40): v� para while
		sw $t8, intArray($t0)		# intArray[$t0] = $t8
		addi $t0, $t0, 4 		# incrementa o indice, para uma nova posi��o tem que ser somada uma quantidade iagual ao tamanho do tipo (int: 4bytes)
		addi $t8, $t8, 1		# $t8++
		j preencheVetor
		
	printVetor: #imprime o vetor inicial
	
		move $t0, $zero #zerando contador
		print:
			beq $t0, 40, continue	# se o vetor terminar, va para continue
			li $v0, 1		# imprimindo cada elemento
			lw $a0, intArray($t0)	# $a0 = intArray[$t0]
			syscall
			
			li $v0, 4 # imprime um espa�o
			la $a0, espa�o
			syscall
			
			addi $t0, $t0, 4
			j print
		
	continue:
		li $v0, 4 # imprime um enter
		la $a0, enter
		syscall
		
		move $t0, $zero #zerando contador
		li $t2, 2
	
	while:
		beq $t0, 40, saida 		# if( $t0 = 40): v� para saida
		lw $t9, intArray($t0)		# $t9 = intArray[$t0]
		
		div $t9, $t2			# divide o contador por 2
		mfhi $t1			# $hi possui o resto da divis�o. $t1 = $hi
		
		beq $t1, $zero, par		# se for par: v� para par
		sll $t9, $t9, 1			# se n�o, $t9 = intArray[$t0]*2
		j inserir			# v� para inserir
		
		par:
			addi $t1, $t0, 4	# $t1 = $t0+1 (1 �, no caso, a prox prosi��o)
			lw $t7, intArray($t1)	# $t7 = intArray[$t0+1]
			add $t9, $t9, $t7	# $t9 = intArray[$t0] + intArray[$t0+1]
		
		inserir:
			sw $t9, intArray($t0)	# intArray[$t0] = $t9
			addi $t0, $t0, 4 	# incrementa o indice
			j while
		
	saida:
		move $t0, $zero #zerando contador
		imprime:
			beq $t0, 40, fim	# se o vetor terminar, va para fim
			li $v0, 1		# imprimindo cada elemento
			lw $a0, intArray($t0)	# $a0 = intArray[$t0]
			syscall
			
			li $v0, 4 # imprime um espa�o
			la $a0, espa�o
			syscall
			
			addi $t0, $t0, 4
			j imprime
	fim: