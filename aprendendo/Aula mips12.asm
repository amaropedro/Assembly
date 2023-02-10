.data
	msg: .asciiz "Digite seu nome:"
	msgSaida: .asciiz "Olá, "
	nome: .space 25 #ira armazenar uma string de até 25 char.

.text
	li $v0, 4 #imprimir uma string que está salva em $a0.
	la $a0, msg
	syscall
	
	li $v0, 8 #ler uma string
	la $a0, nome #salva tanto em $a0 quanto em nome. podemos mover o valor de $a0 para outro registrador e então imprimir (mais rapido) ou imprimir de nome (mais lento).
	la $a1, 25
	syscall
	
	li $v0, 4 #imprimir uma string.
	la $a0, msgSaida
	syscall
	
	li $v0, 4 #imprimir uma string.
	la $a0, nome
	syscall
