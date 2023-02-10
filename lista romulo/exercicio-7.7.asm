.data # declara segmento de dados
	vetorX: .space 64 # variável que representa o conteúdo de um vetor
	numerosDe1: .word 0 # variável que conta o número de 1
	msg: .asciiz "Digite o valor da posição ["
	msg2: .asciiz "]: "
	msgSaida: .asciiz "\nNumero de 1's: "
#
# Princípio do Segmento de Texto
#
.text # declara segmento de código
main:
	move $t0, $zero # zerando contadores
	
	while: #preencher o vetor
		beq $t0, 64, next	# if( $t0 = 64): va para o segundo loop
		
		li $v0 4		# imprime msg1
		la $a0, msg
		syscall
		
		div $a0, $t0, 4		# imprime a posição
		li $v0, 1
		syscall
		
		li $v0 4		# imprime msg2
		la $a0, msg2
		syscall
		
		li $v0, 5		# lê o numero de entrada
		syscall
		move $t1, $v0
		
		sw $t1, vetorX($t0)	# vetorX[$t0] = $t1 
		addi $t0, $t0, 4	# incrementa o indice, para uma nova posição tem que ser somada uma quantidade iagual ao tamanho do tipo (int: 4bytes)
		j while
	
	next:
		move $t0, $zero	# zerando contadores
		move $t2, $zero
		
	while2: #percorrer e contar
		beq $t0, 64, saida	# if( $t0 = 64): va para saida
		lw $t1, vetorX($t0)	# $t1 = vetorX[$t0] 
		addi $t0, $t0, 4	# incrementa o indice
		beq $t1, 1, someUm
		j while2
		
		someUm:
			addi $t2, $t2, 1 # $t2++
			j while2
	
	saida:
		move $v0, $t2
		sw $v0, numerosDe1
		
		li $v0 4 # imprime msg de saida
		la $a0, msgSaida
		syscall
		
		li $v0, 1 # imprime o resultado
		lw $a0, numerosDe1
		syscall
