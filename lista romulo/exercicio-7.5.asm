.data
	msg1: .asciiz "Digite o primeiro numero (n): "
	msg2: .asciiz "Digite o segundo numero (s): "
	saida: .asciiz "Resultado (comb de n escolhendo s): "
	n: .word 1
	s: .word 1
.text
	.globl main
	main:
		li $v0, 4 #imprime a msg1
		la $a0, msg1
		syscall
	
		li $v0, 5 #lê o primeiro inteiro
		syscall
		
		move $t1, $v0
		sw $v0, n #n = $v0 = numero de entrada
	
		li $v0, 4 #imprime a msg2
		la $a0, msg2
		syscall
	
		li $v0, 5 #lê o segundo inteiro
		syscall
		
		move $t2, $v0
		sw $v0, s #s = $v0 = numero de entrada
	
		verificações:
			bgt $t2, $t1, ver1
			bgt $t1, $zero, ver2
			bgt $t2, $zero, ver2
			beq $t1, $t2, ver3
			beq $t1, $zero, ver4
			beq $t2, $zero, ver4 
	
		ver1:
			li $v1, 1
			j end
		ver2:
			li $v1, 2
			j continue
		ver3:
			li $v1, 3
			j continue
		ver4:
			li $v1, 4
			j end
	
	continue:
		lw $a0, n
		jal fat #fat(n)
		move $t7, $v0 # $t7 = retonro de fat(n)
		
		lw $a0, s
		jal fat #fat(s)
		move $t8, $v0 # $t8 = retonro de fat(s)
		
		lw $t0, n
		lw $t1, s
		sub $a0, $t0, $t1 
		jal fat #fat(n-s)
		move $t9, $v0 # $t9 = retonro de fat(n-s)
		
		mul $t1, $t8, $t9 # $t0 = s!*(n-s)!
		div $t0, $t7, $t1 # $t0 = n!/s!*(n-s)!
		
		li $v0, 4 #imprime a msg de saida
		la $a0, saida
		syscall
		
		li $v0, 1 #imprime resultado da combinação
		move $a0, $t0
		syscall
	
	end:
		li $v0, 10 #finaliza o programa
		syscall

	.globl fat
	fat:
		subu $sp, $sp, 8 #salva o endereço e o valor numa pilha
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		
		li $v0, 1
		beq $a0, 1, fatFim #if($a0 == 1): return 1;    o caso base
		
		move $s0, $a0 #salva o valor de $a0 em $s0
		sub $a0, $a0, 1
		jal fat #fat( $a0 - 1 )
		
		mul $v0, $s0, $v0 # $v0 = $s0 * $v0 ou seja $v0 = $s0 * fat( $a0 - 1 )
		
		fatFim:
			lw $ra, 0($sp) #volta com o valor no endereço
			lw $s0, 4($sp)
			addu $sp, $sp, 8
			jr $ra
