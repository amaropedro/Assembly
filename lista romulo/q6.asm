.data 0x10010000 # segmento de dados
	palavra1: .word 13
	palavra2: .word 0x15
	espaço: .ascii "\n"
.text
	li $v0, 1
	lw $a0 palavra1
	syscall
	
	li $v0, 4
	la $a0 espaço
	syscall
	
	li $v0, 1
	lw $a0 palavra2
	syscall