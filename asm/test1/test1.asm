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
	
	case0:  li $v0, 0
		addi $zero, $zero, 12345
		
		li $v0, 11 # show case1
		addi $zero, $zero, 12345
		j While
		
	case1:	li $v0, 0
		addi $zero, $zero, 12345
		
		li $v0, 11 # show case2
		addi $zero, $zero, 12345
		j While
		
	case2:	or $s2, $s0, $s1
	
		li $v0, 10 # show in seg_led only
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case3:	nor $s2, $s0, $s1
		
		li $v0, 10 # show in seg_led only
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case4:	xor $s2, $s0, $s1
	
		li $v0, 10 # show in seg_led only(signed)
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case5:	slt $s2, $s0, $s1
	
		li $v0, 12 # show compare result
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case6:	sltu $s2, $s0, $s1
	
		li $v0, 12 # show compare result
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case7:	li $v0, 0
		addi $zero, $zero, 12345
		add $s0, $a0, $zero
		
		addi $zero, $zero, 12345
		add $s1, $a0, $zero
		j While
