.data #variaveis
	myMessage: .asciiz "Hello World \n"

.text #instruções
	li $v0, 4
	la $a0, myMessage
	syscall