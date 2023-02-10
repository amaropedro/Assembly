.data
	msg: .asciiz "Digite um inteiro positivo: "
	espaço: .byte ' '
.text
	li $v0, 4 #imprimeindo a mensagem inicial.
	la $a0, msg
	syscall
	
	li $v0, 5 #ler um inteiro
	syscall
	
	move $t0, $v0 # $t0 = $v0
	move $t1, $zero # $t0 = 0
	
	while:
		bgt $t1, $t0, saida
		
		li $v0, 1 #imprime um int
		move $a0, $t1
		syscall
		
		li $v0, 4 #imprime um espaço
		la $a0, espaço
		syscall
		
		addi $t1, $t1, 1
		
		j while
		
	saida: