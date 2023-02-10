.data
	intArray:
		.align 2 #alinha a palavrana posição correta, para inteiros
		.space 16 #aoloca espaço para 4 inteiros, pois cada inteiro tem 4 bytes. 4*4 = 16
.text
	move $t0, $zero #indicie inicial do array
	move $t1, $zero #valor a ser colocado dentro do array
	li $t2, 16
	
	
	while:
		beq $t0, $t2, saida #if( $t0 = 16): break;
		sw $t1, intArray($t0)# intArray[$t0] = $t1
		addi $t0, $t0, 4 #incrementa o indice, para uma nova posição tem que ser somada uma quantidade iagual ao tamanho do tipo (int: 4bytes)
		addi $t1, $t1, 1 #incrementando o valor que cada posição recebe
		j while
		
	saida:
		move $t0, $zero
		imprime:
			beq $t0, $t2, fim
			li $v0, 1
			lw $a0, intArray($t0) # $a = intArray[$t0]
			syscall
			addi $t0, $t0, 4
			j imprime
	fim: