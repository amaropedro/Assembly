.data
	myDouble: .double 7.202
	zeroDouble: .double 0.0
	
.text
	ldc1 $f2, myDouble #salva no f2 e no f3 pois precisa de um par de registores
	ldc1 $f0, zeroDouble
	
	li $v0, 3
	add.d $f12, $f2, $f0
	syscall
	