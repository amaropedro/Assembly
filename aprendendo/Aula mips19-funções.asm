.data
	msg: .asciiz "Digite um numero inteiro: "
	par: .asciiz "O n�mero � par."
	impar: .asciiz "O n�mero � impar."
	
.text
	la $a0, msg
	jal imprimeString #imprimeString($a0). chamada de fun��o
	
	jal lerInteiro #retornos de fun��es s�o feitos em $v0. movendo isso para $a0 para poder ser um parametro para a proxima
	move $a0, $v0
	
	jal ehImpar
	beq $v0, $zero, Par #se n�o for impar, pula para Par.
	
	la $a0, impar #imprime impar
	jal imprimeString
	
	jal Encerrar
	
	Par:
		la $a0, par #imprime par
		jal imprimeString
		jal Encerrar
	
	ehImpar: #retorna 1 se impar, 0 se par
		li $t0, 2
		div $a0, $t0
		
		mfhi $v0
		jr $ra
		
	imprimeString: #imprime a msg passada como parametro.
		li $v0, 4
		syscall
		jr $ra
	
	lerInteiro:
		li $v0, 5
		syscall
		jr $ra
		
	Encerrar:
		li $v0, 10
		syscall