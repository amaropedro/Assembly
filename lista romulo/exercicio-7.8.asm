.data
	string: .asciiz "Sobstitoi"
	x: .byte 'o'
	y: .byte 'u'
	
.text
	lb $t8, x # $t8 = x
	lb $t9, y # $t8 = y
	
	
	move $t0, $zero # contador
	while:
		lb $t1, string($t0) 	# $t1 = string[$t0]
		beq $t1, $zero, print 	# se a string acabar, vá para print
		beq $t1, $t8, subst 	# if( string[$t0] == x ): vá para subst
		addi $t0, $t0, 1 	# $t0++
		j while
		subst:
			sb $t9, string($t0) 	# string[$t0] = y
			addi $t0, $t0, 1 	# $t0++
			j while
			
	print:
		li $v0, 4 # imprime a strung resultado
		la $a0, string
		syscall 
