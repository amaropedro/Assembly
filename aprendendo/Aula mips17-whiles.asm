.text
	move $t0, $zero # $t0 = 0
	
	while:
		beq $t0, 10, saida # if( $t0 =10 ): pula para saida
		addi $t0, $t0, 1 # $t0 = $t0 + 1
		j while #pula de volta para o inicio
	saida:
		li $v0, 1 #imprimir inteiro
		move $a0, $t0 #$a0 = $t0
		syscall