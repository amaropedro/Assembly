.data
	myFloat: .float 3.14
.text
	li $v0, 2 #imprimir um float que por padrão estará em $f12
	lwc1 $f12, myFloat #LoadWordCoreproc1, carrega uma 'palavra' que está em coreproc 1
	syscall
