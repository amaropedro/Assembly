.data
	A:
		.align 2 #alinha a palavrana posição correta, para inteiros
		.space 400 #aloca espaço para 100 inteiros, pois cada inteiro tem 4 bytes. 4*100 = 400
	B:
		.align 2 #alinha a palavrana posição correta, para inteiros
		.space 400 #aloca espaço para 100 inteiros, pois cada inteiro tem 4 bytes. 4*100 = 400
	enter: .asciiz "\n"
	espaço: .asciiz " "
	C: .word 1
.text
	move $t8, $zero # $t8 = 0
	move $t0, $zero #indicie inicial do array
	
	preencheVetor1:				# preenche o vetor com numeros de 0 a 99
		beq $t0, 400, printVetor	# if( $t0 = 400): vá para while
		sw $t8, A($t0)			# A[$t0] = $t8
		addi $t0, $t0, 4 		# incrementa o indice, para uma nova posição tem que ser somada uma quantidade iagual ao tamanho do tipo (int: 4bytes)
		addi $t8, $t8, 1
		j preencheVetor1
		
	printVetor: #imprime o vetor inicial
	
		move $t0, $zero #zerando contador
		print:
			beq $t0, 400, continue	# se o vetor terminar, va para conrinue
			li $v0, 1		# imprimindo cada elemento
			lw $a0, A($t0)		# $a0 = A[$t0]
			syscall
			addi $t0, $t0, 4
			j print
	
	continue:
		li $t8, 7 # $t8 = 7
		move $t0, $zero #indicie inicial do array	
				
		preencheVetor2:				# preenche o vetor com 7's
			beq $t0, 400, printVetor2	# if( $t0 = 400): vá para while
			sw $t8, B($t0)			# B[$t0] = $t8
			addi $t0, $t0, 4 		# incrementa o indice
			j preencheVetor2
	
	
		printVetor2: #imprime o vetor inicial
		
			li $v0, 4 # imprime um enter
			la $a0, enter
			syscall
			
			move $t0, $zero #zerando contador
			print2:
				beq $t0, 400, continue2	# se o vetor terminar, va para continue2
				li $v0, 1		# imprimindo cada elemento
				lw $a0, B($t0)		# $a0 = B[$t0]
				syscall
				addi $t0, $t0, 4
				j print2
	
	continue2:
		li $v0, 4 # imprime um enter
		la $a0, enter
		syscall
		
		move $t0, $zero #zerando contador
		lw $t1, C # $t1 = C
		
	while:
		beq $t0, 400, saida 		# if( $t0 = 400): vá para saida
		lw $t9, A($t0)			# $t9 = A[$t0]
		lw $t8, B($t0)			# $t8 = B[$t0]
		
		beq $t9, $zero, else		#if(A[$t0] == 0): vá para else
		bge $t9, $t8, else		#if(A[$t0] >= B[$t0]): vá para else
		
		add $t9, $t8, $t1		#se não, A[$t0] = B[$t0] + C
		j next
		
		else:
			sub $t9, $t8, $t1	# A[$t0] = B[$t0] - C
		
		next:
			sw $t9, A($t0)		# A[$t0] = $t9
			addi $t0, $t0, 4 	# incrementa o indice
			j while
		
	saida:
		move $t0, $zero #zerando contador
		imprime:
			beq $t0, 400, fim	# se o vetor terminar, va para fim
			li $v0, 1		# imprimindo cada elemento
			lw $a0, A($t0)		# $a0 = A[$t0]
			syscall
			addi $t0, $t0, 4
			j imprime
	fim: