.data
	entrada: .space 100
	saida: .space 100
	enter: .asciiz "\n"
	msgE: .asciiz "Digie uma string: "
	msgS: .asciiz "Saida: "
	msgErro: .asciiz "Digite uma string valida, com apenas caracteres alfabeticos"
	
.text
	li $v0, 4 #imprime a msg de entrada.
	la $a0, msgE
	syscall

	li $v0, 8 #faz a leitura da entrada, salvando em $a0 por padrão
	la $a0, entrada #salva tanto em $a0 quanto na memoria, em 'entrada'.
	li $a1, 100
	syscall
	
	move $t0, $zero # $t0 = 0, o contador da 'entrada'.
	move $t1, $zero # $t1 = 0, o contador da 'saida'.
 	posiçãoFinal: #coloca o contador na posição final da strign de entrada.
 		lb $t8, entrada($t0) # $t8 = entrada[$t0]
		
		beq $t8, 10, inversor #if(entrada[$t0]==\n): pule para inversor
		jal validaEntrada
		addi $t0, $t0, 1 #$t0++
		j posiçãoFinal
		
	inversor: #string 'saida' recebe a 'entrada' ao contrario.
		subi $t0, $t0, 1
		
		lb $t2, entrada($t0)
		sb $t2, saida($t1) # saida[$t1] = $t2 ou saida[$t1] = entrada[$t0]

		beq $t0, $zero, fimString #se acabar a setring de entrada va para fimString.
		addi $t1, $t1, 1
		
		j inversor	
	
	fimString: #adiciona '\n' no final da string 'saida'.
		li $t2, 10
		addi $t1, $t1, 1
		sb $t2, saida($t1)
		
		move $t9, $zero # $t9 = 0, o contador para a saida, usado mais a frente.
	
	inversorMaiMin:
		lb $t7, saida($t9) # $t7 = saida[$t9]
		beq $t7, 10, fim #se encontrar '\n', é 'porque saida' acabou: va para fim.
		
		bgt $t7, 96, fiqueMaiusculo #if(saida[$t7]>96): é minusculo, fique maiusculo; Else: é maiusculo, fique minusculo;
		blt $t7, 96, fiqueMinusculo
		
		j inversorMaiMin
	
	fiqueMaiusculo: #transforma a letra minuscula em uma letra maiuscula
		subi $t2, $t7, 32
		sb $t2, saida($t9) # saida[$t9] = letraMinuscula - 32; ou seja, saida[$t9] = letraMaiuscula
		addi $t9, $t9, 1 # $t9++
		j inversorMaiMin
		
	fiqueMinusculo: #transforma a letra maiuscula em uma letra minuscula
		addi $t2, $t7, 32
		sb $t2, saida($t9) # saida[$t9] = letraMaiuscula + 32; ou seja, saida[$t9] = letraMinuscula
		addi $t9, $t9, 1 # $t9++
		j inversorMaiMin
	
	fim:
		li $v0, 4 #imprime um enter.
		la $a0, enter
		syscall
		
		li $v0, 4 #imprime uma mensagem de saida.
		la $a0, msgS
		syscall
		
		li $v0, 4 #imprimir a string 'saida'.
		la $a0, saida
		syscall
		
		li $v0, 10 #encerra o programa
		syscall

	fimErro:
		li $v1, 1
		
		li $v0, 4 #imprimir uma string.
		la $a0, msgErro
		syscall
		
		li $v0, 10 #encerra o programa.
		syscall

	validaEntrada:
		blt $t8, 65, fimErro #se for menor que 65 não é letra, encerra o programa.
		bgt $t8, 90, validaEntrada2 #se for maior que 90 pode ou não ser letra, checa em validaEntrada2
		bgt $t8, 122, fimErro #se for maior que 122 não é letra, encerra o programa.
		jr $ra
		
	validaEntrada2:
		blt $t8, 97, fimErro #se for maior que 90 e menor que 97, não é letra, encerra o programa.
		jr $ra
