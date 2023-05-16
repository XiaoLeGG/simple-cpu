.data
	
.text
	li $t0, 0
	li $t1, 1
	li $t2, 2
	li $t3, 3
	li $t4, 4
	li $t5, 5
	li $t6, 6
	li $t7, 7
	
	While:  li $v0, 0
		addi $zero, $zero, 12345 # syscall
		beq $t0, $a0, case0
		beq $t1, $a0, case1
		beq $t2, $a0, case2
		beq $t3, $a0, case3
		beq $t4, $a0, case4
		beq $t5, $a0, case5
		beq $t6, $a0, case6
		beq $t7, $a0, case7
		j While
	
	case0:	li $v0, 0
		addi $zero, $zero, 12345
		
		add $s0, $a0, $zero
		li $s1, 1
		li $s2, 0
		loop1:	add $s2, $s2, $s1
			beq $s0, $s1, break1
			slt $s3, $s0, $s1
			beq $zero, $s3, else
				addi $s1, $s1, -1
				j loop1
			else:	addi $s1, $s1, 1
				j loop1
	break1:  li $v0, 10 # show signed ans
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		
		j While
		
	case1:	li $v0, 1 # load unsigned
		addi $zero, $zero, 12345
		
		add $s0, $a0, $zero
		
		
		j While
		
	case2:	li
	
	case3:	
	
	case4:	li $v0, 0
		addi $zero, $zero, 12345
		add $s0, $a0, $zero
				
		addi $zero, $zero, 12345
		add $s1, $a0, $zero
		
		add $s2, $s0, $s1
		
		li $v0, 10
		add $a0, $a0, $s2
		addi $zero, $zero, 12345
		
		j While
		
	case5:	li $v0, 0
		addi $zero, $zero, 12345
		add $s0, $a0, $zero
				
		addi $zero, $zero, 12345
		add $s1, $a0, $zero
		
		sub $s2, $s0, $s1
		
		li $v0, 10
		add $a0, $a0, $s2
		addi $zero, $zero, 12345
		
		j While
	
	case6:	li $v0, 0
		addi $zero, $zero, 12345
		add $s0, $a0, $zero
				
		addi $zero, $zero, 12345
		add $s1, $a0, $zero
		
		li $s2, 0
		li $s3, 1
		
		loop6:	beq $s0, $zero, break6
			and $s4, $s0, $s3
			beq $zero, $s4, noadd6
				add $s2, $s2, $s1
			noadd6:	srl $s0, $s0, 1
				sll $s1, $s1, 1
				j loop6
	break6:	li $v0, 10
		add $a0, $a0, $s2
		addi $zero, $zero, 12345
		
		j While
	
	case7: