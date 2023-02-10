.data
	myInt: .word 20
.text
	li $v0, 1
	lw $a0, myInt
	syscall
