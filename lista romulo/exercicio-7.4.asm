.data
	msg1: .asciiz "Digite o primeiro numero: "
	msg2: .asciiz "Digite o segundo numero: "
	num1: .word 1
	num2: .word 1
.text
	li $v0, 4 #imprime a msg1
	la $a0, msg1
	syscall
	
	li $v0, 5 #lê o primeiro inteiro
	syscall
	
	move $t1, $v0 # $t1 = numero de entrada
	sw $v0, num1 #num1 = $v0 = numero de entrada
	
	li $v0, 4 #imprime a msg2
	la $a0, msg2
	syscall
	
	li $v0, 5 #lê o segundo inteiro
	syscall
	
	move $t2, $v0 # $t2 = numero de entrada
	sw $v0, num2 #num2 = $v0 = numero de entrada
	
	move $t0, $zero #$t0 = 0, o contador
	move $t3, $zero #$t3 = 0, armazena o resultado da soma
	
	teste1:
		blt $t1, $zero, teste2 #se o primeiro numero é negativo: verificar se o segundo numero é negativo
		blt $t2, $zero, multPorSub #o primeiro numero é positivo e o segundo negativo
		j multPorSoma  #se não, soma nornmal
	
	teste2:
		blt $t2, $zero, multPorSub #se ambos numeros são negativos: va para multPorSub
		sub $t1, $zero, $t1 #se não, deixe o primeiro positivo...
		sub $t2, $zero, $t2 # e o segundo negativo
		j multPorSub
	
	multPorSoma: #somando numero1 com 0 uma quantidade igual a numero2
		beq $t0, $t2, print #if($t0 == numero2): va para print
		add $t3, $t3, $t1 #else: $t3 = $t3 + numero1
		addi $t0, $t0, 1 #t0++
		j multPorSoma
		
	multPorSub: #subtraindo numero1 de 0 uma quantidade igual a numero2, como a comparação não é em modulo,
	 	    #é importante que o numero2 seja negativo
		beq $t0, $t2, print #if($t0 == numero2): va para print
		sub $t3, $t3, $t1 #else: $t3 = $t3 - numero1
		subi $t0, $t0, 1 #$t0--
		j multPorSub
		
	print:
		li $v0, 1 #imprime o resultado da multiplicação
		move $a0, $t3
		syscall
		
