.data
	msg: .asciiz "Digite um n�mero: "
	maior: .asciiz "O n�mero � maior que zero."
	igual: .asciiz "O n�mero � igual a zero."
	menor: .asciiz "O n�mero � menor que zero."
.text
	li $v0, 4 #imprimeindo a mensagem inicial.
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	beq $t0, $zero, Igual
	blt $t0, $zero, Menor
	
	li $v0, 4
	la $a0, maior
	syscall
	
	li $v0, 10 #termina o programa
	syscall
	
	Menor:
		li $v0, 4
		la $a0, menor
		syscall
		
	li $v0, 10 #termina o programa
	syscall
	
	Igual:
		li $v0, 4
		la $a0, igual
		syscall