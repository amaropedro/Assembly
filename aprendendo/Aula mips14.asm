.data
	msg: .asciiz "Digite um numero decimal: "
	zero: .double 0.0 #constante 0 para floats
	
.text
	li $v0, 4 #imprimir uma string que está salva em $a0.
	la $a0, msg
	syscall
	
	li $v0, 7 #ler um double e o salva por padrão em $f0
	syscall
	
	ldc1 $f2, zero
	add.d $f12, $f22, $f0 # $f12 = $f1 + $f0 que seria $f12 = 0.0 + $f0
	
	li $v0, 3 #imprimir um double que por padrão está em $f12
	syscall