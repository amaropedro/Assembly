.text
	li $t0, 32
	li $t1, 5
	
	div $t0, $t1 #divide t0/t1 e salva o resultado inteiro em 'lo' e o decimal em 'hi'
	
	mflo $s0 # $s0 = lo. coloca a parte inteira, lo, em $s0
	
	mfhi $s1 # $s1 = hi. coloca a parte decimal, hi, em $s1
	
	srl $s2, $t0, 2 #similarmente a sll, move os bits de $t0 n casas para a esquerda, nesse caso 2. Assim, dividindo por 2^2=4.
	srl $s3, $t1 1 #dividino $t1/2 e salvando o resultado em $s3. Apenas a parte inteira é salva.