.data
	comp2: .asciiz "11111111111111111111111111111001"  # -7 em complemento de 2
	#comp2: .asciiz "00000000000000000000001001010001"   # 593 em complemento de 2
	#comp2: .asciiz "01111111111111111111111111111111"  # 2147483647 em complemento de 2
	#comp2: .asciiz "10000000000000000000000000000000"  # -2147483648 em complemento de 2
.text
	la $t0, comp2		# carrega o endereço em $t0
	addi $t1,$t0,32		# carrega a ultima posição em $t1, $t1 = $t0 + 32

	verificar:
		beq $t0,$t1,next	# se a string chegou ao fim, vai para 'next'
		lb $t2,0($t0)		# $t2 = o endereço atual	
		bne $t2,48,verificar2 	# se não é 0, vá para verificar 2
		addi $t0,$t0,1		# o enderço é incrementado em 1, vai para a prox posição
		j verificar
		
	verificar2:
		bne $t2,49,invalido 	# não é 0, se também não for 1, vá para invalido
		addi $t0,$t0,1		# incrementa e volta para verificar
		j verificar
		
	invalido:
		li $v1,1
		li $v0,1
		move $a0,$v1
		syscall
		li $v0, 10
		syscall			# fim do programa, numero invalido.
		
	next: 	# Se a string é válida, vamos pegar o somatório do 2º bit mais significativo em diante, pra poder somar com
		# o resultado final se a string for positiva ou negativa
		la $t0,comp2		# carrega $t0 com o endereço de inicio
		addi $t0,$t0,1		# incrementa a posição
		move $t5,$zero 		# Zerar $t5 pra usar pro somatório
					
	somatorio: # $t1 será auxiliar e verificador se a string já acabou
		lb $t2,0($t0)		# $t2 = o endereço atual
		beq $t2,$zero,posneg	# se acabou, vá para posneg
		beq $t2,48,shift0 	# Se o char for um 0, então apenas empurrar para a esquerda
		beq $t2,49,shift1	# Se for 1, empurrar para a esquerda e somar um
		
	shift1:
		sll $t5,$t5,1
		addi $t5,$t5,1
		addi $t0,$t0,1
		j somatorio
		
	shift0:
		sll $t5,$t5,1
		addi $t0,$t0,1
		j somatorio
		
	posneg: #Dependendo se a o primeiro bit for 1 ou 0, a interpretação muda
		la $t0, comp2		# carrega o endereço
		lb $t1,0($t0)
		beq $t1,48,posit 	#Se 0, $t4 receberá $t5 e irá ser printado
		beq $t1,49,negat 	#Se 1, $t4 receberá -2147483648 e será somado com $t5 pra dar o valor correto
		
	posit:
		move $t4, $t5
		j print
		
	negat:
		subi $t4,$zero,2147483647	# Dá erro de memória se utilizar colocar o número original, 2147483648
						# será subtraído 1 do resultado de $t4 para completar
		add $t4,$t4,$t5
		addi $t4,$t4,-1
		j print
		
	print:
		li $v0,1
		move $a0,$t4
		syscall
