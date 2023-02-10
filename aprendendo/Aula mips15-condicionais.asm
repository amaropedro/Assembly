.data
	msg: .asciiz "Digite um numero inteiro: "
	par: .asciiz "O número é par."
	impar: .asciiz "O número é impar."
	
.text
	li $v0, 4 #imprimeindo a mensagem inicial.
	la $a0, msg
	syscall
	
	li $v0, 5 #ler um inteiro.
	syscall
	
	li $t0, 2 # $t0 = 2
	div $v0, $t0 # $v0 / $t0
	mfhi $t1 #possui o resto da divisão
	
	beq $t1, $zero, Par
	 
	li $v0, 4 #é impar
	la $a0, impar
	syscall
	
	li $v0, 10 #termina o programa
	syscall
	
	Par:
		li $v0, 4 #é par
		la $a0, par
		syscall	