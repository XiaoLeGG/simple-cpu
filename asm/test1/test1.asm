.data 0x0000
	
.text 0x0000
start:
	addi $t0, $zero, 0
	addi $t1, $zero, 1
	addi $t2, $zero, 2
	addi $t3, $zero, 3
	addi $t4, $zero, 4
	addi $t5, $zero, 5
	addi $t6, $zero, 6
	addi $t7, $zero, 7
	While:  addi $v0, $zero, 0
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
	
	case0:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345

		addi $v0, $zero, 1
		addi $zero, $zero, 12345
		addi $v0, $zero, 3 # show case1
		addi $zero, $zero, 12345
		add $s0, $a0, $zero
		addi $s0, $s0, -1
		and $a0, $a0, $s0
		slt $a0, $zero, $a0
		nor $a0, $zero, $a0
		sll $a0, $a0, 31
		srl $a0, $a0, 31
		addi $v0, $zero, 4 # result led
		addi $zero, $zero, 12345
		j While
		
	case1:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345

		addi $v0, $zero, 1
		addi $zero, $zero, 12345
		
		addi $v0, $zero, 3
		addi $zero, $zero, 12345
		
		add $s0, $a0, $zero
		addi $s1, $zero, 1
		and $a0, $s1, $s0
		addi $v0, $zero, 4 # result led
		addi $zero, $zero, 12345
		j While
		
	case2:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345

		
		or $s2, $s0, $s1
	
		addi $v0, $zero, 3 # show in seg_led only
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case3:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345
		
		nor $s2, $s0, $s1

		sll $s2, $s2, 24
		srl $s2, $s2, 24
		
		addi $v0, $zero, 3 # show in seg_led only
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case4:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345
		
		xor $s2, $s0, $s1
	
		addi $v0, $zero, 3 # show in seg_led only(unsigned)
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case5:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345

		sll $s0, $s0, 24
		sra $s0, $s0, 24
		sll $s1, $s1, 24
		sra $s1, $s1, 24

		slt $s2, $s0, $s1
	
		addi $v0, $zero, 4 # result led
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case6:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345
		
		sltu $s2, $s0, $s1
	
		addi $v0, $zero, 4 # result led
		add $a0, $s2, $zero
		addi $zero, $zero, 12345
		j While
		
	case7:
		addi $v0, $zero, 2
		addi $a0, $zero, 0
		addi $zero, $zero, 12345
		addi $v0, $zero, 4
		addi $zero, $zero, 12345

		addi $v0, $zero, 1
		addi $zero, $zero, 12345
		add $s0, $a0, $zero
		
		addi $v0, $zero, 3
		addi $zero, $zero, 12345
		
		addi $v0, $zero, 1
		addi $zero, $zero, 12345
		add $s1, $a0, $zero

		addi $v0, $zero, 3
		addi $zero, $zero, 12345
		j While
