.data
	localArquivo: .asciiz "C:/Users/Amaro/Documents/prog/assembly/texto.txt"
	conteudoArquivo: .space 1024 #tamanho do arquivo em bytes
	
.text
	li $v0, 13 #abrir arquivo no modo leitura
	la $a0, localArquivo
	li $a1, 0 #0: leitura; 1: escrita
	syscall #descritor do arquivo vai para $v0
	
	move $s0, $v0 #copia do descritor
	
	move $a0, $s0
	li $v0, 14 #ler o conteudo do arquivo indicado por $a0
	la $a1, conteudoArquivo
	li $a2, 1024
	syscall
	
	li $v0, 4 #imprime o conteudo da string que está em $a0. Nesse cado o do arquivo
	move $a0, $a1
	syscall
	
	li $v0, 16 #fecha o arquivo referenciado por $a0
	move $a0, $s0
	syscall