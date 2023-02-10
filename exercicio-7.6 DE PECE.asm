.data
	comp2: .asciiz "11111111111111111111111111111001" #-7 em complemento de 2
	#comp2: .asciiz "00000000000000000000001001010001" #teste em complemento de 2
	#comp2: .asciiz "01111111111111111111111111111111" #Teste de 2147483647 em complemento de 2
	#comp2: .asciiz "10000000000000000000000000000000" #Teste de -2147483648 em complemento de 2
.text
main: #verificar se o número é válido
	la $t0, comp2
	addi $t1,$t0,32
	j verificar
verificar:
	beq $t0,$t1,passou
	lb $t2,0($t0)
	bne $t2,48,verificar2 #verificação se o char é o do 0
	addi $t0,$t0,1
	j verificar
verificar2:
	bne $t2,49,invalido #Se tiver algum char na string q n seja 1 ou 0, a string é inválida
	addi $t0,$t0,1
	j verificar
invalido:
	addi $v1,$zero,1
	li $v0,1
	move $a0,$v1
	syscall
passou: #Se a string é válida, vamos pegar o somatório do 2o bit mais significativo em diante, pra poder somar com o resultado final se a string
	#for positiva ou negativa
	la $t0,comp2
	addi $t0,$t0,1
	move $t5,$zero #$Zerar $t5 pra usar pro somatório
	# na próxima função de somatório, $t1 será auxiliar e verificador se a string já tá no caracter nulo ou não
	j somatorio
somatorio:
	lb $t2,0($t0)
	beq $t2,$zero,posneg
	beq $t2,48,shift0 #Se o char for um 0, então o somatório será feito com apenas um shift pra esquerda
	beq $t2,49,shift1
shift1:
	sll $t5,$t5,1
	addi $t5,$t5,1
	addi $t0,$t0,1
	j somatorio
shift0:
	sll $t5,$t5,1
	addi $t0,$t0,1
	j somatorio
posneg: #Dependendo se a o primeiro bit for 1 ou 0, a interpretação muda
	#Se 1, $t4 receberá -2147483648 e será somado com $t5 pra dar o valor correto
	#Se 0, $t4 receberá $t5 e irá ser printado
	la $t0, comp2
	lb $t1,0($t0)
	beq $t1,48,posit
	beq $t1,49,negat
posit:
	move $t4, $t5
	j print
negat:
	subi $t4,$zero,2147483647 #Dá um erro de memória se eu colocar o número original 2147483648
	#Logo, o que será feito? no final, será subtraído 1 do resultado de $t4
	add $t4,$t4,$t5
	addi $t4,$t4,-1
	j print
print:
	li $v0,1
	move $a0,$t4
	syscall
