.text
	li $t0, 10
	sll $t1, $t0, 2 #faz o shift do valor duas casas para a esquerda, ou seja, multiplica por 2^2 = 4.
	
	li $v0, 1
	move $a0 $t1
	syscall