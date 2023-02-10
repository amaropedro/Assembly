.data
	msg1: .asciiz "Digite sua idade: "
	msgSaida: .asciiz "Sua idade é: "
	msgSaida2: .asciiz " anos."
	
.text
	li $v0, 4 #imprimir uma string que está salva em $a0.
	la $a0, msg1 #utilizando la pois é preciso buscar um dado na memoria ram, enquanto move move de registor para registor
	syscall
	
	li $v0, 5 #ler um inteiro
	syscall
	
	move $t0, $v0 #salva $v0 em $t0
	
	li $v0, 4 #imprimir uma string
	la $a0, msgSaida
	syscall
	
	li $v0, 1 #imprime um inteiro que estiver salvo em $a0
	move $a0, $t0 #move o inteiro de $to para $a0 para assim poder imprimi-lo
	syscall
	
	li $v0, 4 #imprimir uma string
	la $a0, msgSaida2
	syscall