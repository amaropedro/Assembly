.data #variaveis
	myMessage: .asciiz "Hello World \n"

.text #instru��es
	li $v0, 4
	la $a0, myMessage
	syscall