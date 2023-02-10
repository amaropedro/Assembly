.data
	palavra: .space 64
	inversa: .space 64
	#nulo: .byte '\0'
.text
main:
	la $t9, palavra #$t9 vai ser para manipulação do endereço da palavra
	li $v0, 8
	la $a0, palavra #pegar a string do usuário e armazenar na memória palavra
	li $a1, 64
	syscall
	#Contador pra ver quantos caracteres a palavra tem
	addi $t0, $zero, 0 #zerar t0, que será o contador
counter:
	lb $t1,0($t9)
	beq $t1, $zero, next
	addi $t9, $t9,1
	#no final, t9 estará no local onde o caracter nulo está
	j counter
next:	#passar os caracteres de palavra pra inversa, só que na ordem contrária
	subi $t9, $t9,2 #padrozinar t9 pra funcionar corretamente a lógica de inversão, colocando no endereço da última letra da string
	la $t1,palavra
	lb $t7, 0($t1)#passando o primeiro caracter da palavra por motivos de comparação
	la $t8,inversa
	lb $t2, 0($t9) #carregando o último caracter da string palavra logo pra $t2
inversor: #essa operação vai inverter todos os caracteres da string palavra pra inversa 
	#beq $t2, $t7, caracternulo #como essa função precisa ficar no início, a função caracter nulo vai começar fazendo uma correção
	#pra botar o primeiro byte da string palavra no último espaço de inversa
	#lb $t2, 0($t9)
	sb $t2, 0($t8)
	addi $t8, $t8, 1
	subi $t9, $t9, 1
	beq $t1,$t9, caracternulo
	lb $t2, 0($t9)
	j inversor
caracternulo: #precisamos adicionar o caractér nulo ao final da string, e essa função serve pra isso
	#addi $t8, $t8,1 #adaptação por causa de um erro na inversora
	sb $t7, 0($t8)
	#lb $t9, nulo
	#Tentar passar o caracter pela tabela ascii
	addi $t9, $zero, 0
	addi $t8, $t8, 1 #aumentar o índice pro último byte
	sb $t9, 0($t8) #guardar o caracter nulo
#A partir de agora, todos os registradores usados anteriormente podem ser usados do zero sem preocupações, pois são do tipo T
	la $t5, inversa #t5 agora vai ter o endereço da palavra inversa
invertermaisminus: #Função final do programa, vai transformar caracteres minúsculos em maiúsculos e vice-versa
	lb $t0, 0($t5)
	beq $t0, $zero, printar
	blt $t0, 95, minusculo
	bgt $t0, 95, maiusculo
minusculo: #transformar a letra pra minúsculo, considerando a tabela ascii
	addi $t0, $t0, 32
	sb $t0, 0($t5)
	addi $t5, $t5, 1
	j invertermaisminus
maiusculo: #transformar a letra pra mainúscula, considerando a tabela ascii
	subi $t0, $t0, 32
	sb $t0, 0($t5)
	addi $t5, $t5, 1
	j invertermaisminus
printar:#Função simples apenas pra printar a string inversa final
	li $v0,11#printar um \n pra organizar a saída
	la $a0,10
	syscall
	li $v0,4 #printar a palavra resultado
	la $a0,inversa
	syscall
