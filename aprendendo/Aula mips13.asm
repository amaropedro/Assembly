.data
	msg: .asciiz "Digite um numero decimal: "
	zero: .float 0.0 #constante 0 para floats
	
.text
	li $v0, 4 #imprimir uma string que est� salva em $a0.
	la $a0, msg
	syscall
	
	li $v0, 6 #ler um float e o salva por padr�o em $f0
	syscall
	
	lwc1 $f1, zero
	add.s $f12, $f1, $f0 # $f12 = $f1 + $f0 que seria $f12 = 0.0 + $f0
	
	li $v0, 2 #imprimir um float que por padr�o est� em $f12
	syscall