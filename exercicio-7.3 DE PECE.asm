.data
	palavra: .space 64
	inversa: .space 64
	#nulo: .byte '\0'
.text
main:
	la $t9, palavra #$t9 vai ser para manipula��o do endere�o da palavra
	li $v0, 8
	la $a0, palavra #pegar a string do usu�rio e armazenar na mem�ria palavra
	li $a1, 64
	syscall
	#Contador pra ver quantos caracteres a palavra tem
	addi $t0, $zero, 0 #zerar t0, que ser� o contador
counter:
	lb $t1,0($t9)
	beq $t1, $zero, next
	addi $t9, $t9,1
	#no final, t9 estar� no local onde o caracter nulo est�
	j counter
next:	#passar os caracteres de palavra pra inversa, s� que na ordem contr�ria
	subi $t9, $t9,2 #padrozinar t9 pra funcionar corretamente a l�gica de invers�o, colocando no endere�o da �ltima letra da string
	la $t1,palavra
	lb $t7, 0($t1)#passando o primeiro caracter da palavra por motivos de compara��o
	la $t8,inversa
	lb $t2, 0($t9) #carregando o �ltimo caracter da string palavra logo pra $t2
inversor: #essa opera��o vai inverter todos os caracteres da string palavra pra inversa 
	#beq $t2, $t7, caracternulo #como essa fun��o precisa ficar no in�cio, a fun��o caracter nulo vai come�ar fazendo uma corre��o
	#pra botar o primeiro byte da string palavra no �ltimo espa�o de inversa
	#lb $t2, 0($t9)
	sb $t2, 0($t8)
	addi $t8, $t8, 1
	subi $t9, $t9, 1
	beq $t1,$t9, caracternulo
	lb $t2, 0($t9)
	j inversor
caracternulo: #precisamos adicionar o caract�r nulo ao final da string, e essa fun��o serve pra isso
	#addi $t8, $t8,1 #adapta��o por causa de um erro na inversora
	sb $t7, 0($t8)
	#lb $t9, nulo
	#Tentar passar o caracter pela tabela ascii
	addi $t9, $zero, 0
	addi $t8, $t8, 1 #aumentar o �ndice pro �ltimo byte
	sb $t9, 0($t8) #guardar o caracter nulo
#A partir de agora, todos os registradores usados anteriormente podem ser usados do zero sem preocupa��es, pois s�o do tipo T
	la $t5, inversa #t5 agora vai ter o endere�o da palavra inversa
invertermaisminus: #Fun��o final do programa, vai transformar caracteres min�sculos em mai�sculos e vice-versa
	lb $t0, 0($t5)
	beq $t0, $zero, printar
	blt $t0, 95, minusculo
	bgt $t0, 95, maiusculo
minusculo: #transformar a letra pra min�sculo, considerando a tabela ascii
	addi $t0, $t0, 32
	sb $t0, 0($t5)
	addi $t5, $t5, 1
	j invertermaisminus
maiusculo: #transformar a letra pra main�scula, considerando a tabela ascii
	subi $t0, $t0, 32
	sb $t0, 0($t5)
	addi $t5, $t5, 1
	j invertermaisminus
printar:#Fun��o simples apenas pra printar a string inversa final
	li $v0,11#printar um \n pra organizar a sa�da
	la $a0,10
	syscall
	li $v0,4 #printar a palavra resultado
	la $a0,inversa
	syscall
