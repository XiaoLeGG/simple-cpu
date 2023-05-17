.data
	
.text	
	addi $t0, $zero, 0
	addi $t1, $zero, 1
	addi $t2, $zero, 2
	addi $t3, $zero, 3
	addi $t4, $zero, 4
	addi $t5, $zero, 5
	addi $t6, $zero, 6
	addi $t7, $zero, 7
	
recru:	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $s3, 0($sp)
	addi $s1, $s1, 2
	
	bne $s7, $t2, not2 # push stack for case 2
	addi $v0, $zero, 3
	add $a0, $zero, $s3
	addi $zero, $zero, 12345
	# 2~3 seconds
	
not2:	bne $s3, $0, contin
	add $s2, $s2, $s3
	addi $sp, $sp, 8
	
	bne $s7, $t3, not3_1 # pop stack for case 3
	addi $v0, $zero, 3
	add $a0, $zero, $s3
	addi $zero, $zero, 12345
	# 2~3 seconds
not3_1:	jr $ra
	
contin:	addi $s3, $s3, 1
	jal recru
	
	lw $s3, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	add $s2, $s2, $s3
	addi $s1, $s1, 2
	
	bne $s7, $t3, not3_2 # pop stack for case 3
	addi $v0, $zero, 3
	add $a0, $zero, $s3
	addi $zero, $zero, 12345
	# 2~3 seconds
not3_2:	jr $ra

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

case0:	addi $v0, $zero, 0
	addi $zero, $zero, 12345
	
	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	slt $s1, $s0, $zero
	beq $s1, $zero, big0
	addi $v0, $zero, 4
	addi $a0, $zero, 2
	addi $zero, $zero, 12345
	loop00:	add $s2, $s2, $s3
		beq $s3, $s0, break0
		addi $s3, $s3, -1
		j loop00
	big0:	add $s2, $s2, $s3
		beq $s3, $s0, break0
		addi $s3, $s3, 1
		j big0
break0:	add $v0, $zero, 2
	add $a0, $zero, $s2
	addi $zero, $zero, 12345
	j While

case1:	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	
	add $s0, $a0, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	jal recru
	
	addi $v0, $zero, 3
	add $a0, $zero, $s1
	addi $zero, $zero, 12345
	
	j While
	
case2:	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	
	addi $7, $zero, 2
	
	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	jal recru
	
	j While
	
case3:	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	
	addi $7, $zero, 3
	
	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	jal recru
	
	j While
	
case4:	addi $v0, $zero, 0 # get a
	addi $zero, $zero, 12345
	add $s0, $a0, $zero
	
	addi $v0, $zero, 2 # show a
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 4 # show whether a is negative
	srl $a0, $a0, 31
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 0 # get b
	addi $zero, $zero, 12345
	add $s1, $a0, $zero
	
	addi $v0, $zero, 2 # show b
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 4 # show whether b is negative
	srl $a0, $a0, 31
	addi $zero, $zero, 12345
	
	add $s2, $s1, $s0
	
	addi $v0, $zero, 2 # show a + b
	add $a0, $s2, $zero
	addi $zero, $zero, 12345
	
	srl $s2, $s2, 31
	srl $s1, $s1, 31
	srl $s0, $s0, 31
	
	nor $s3, $s1, $s0
	and $s3, $s3, $s2 # pos + pos = neg
	
	and $s4, $s1, $s0
	nor $s5, $s2, $s2
	and $s4, $s4, $s5 # neg + neg = pos
	
	or $a0, $s3, $s4
	
	addi $v0, $zero, 4
	addi $zero, $zero, 12345
	
	j While

case5:	addi $v0, $zero, 0 # get a
	addi $zero, $zero, 12345
	add $s0, $a0, $zero
	
	addi $v0, $zero, 2 # show a
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 4 # show whether a is negative
	srl $a0, $a0, 31
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 0 # get b
	addi $zero, $zero, 12345
	add $s1, $a0, $zero
	
	addi $v0, $zero, 2 # show b
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 4 # show whether b is negative
	srl $a0, $a0, 31
	addi $zero, $zero, 12345
	
	sub $s2, $s1, $s0
	
	addi $v0, $zero, 2 # show a + b
	add $a0, $s2, $zero
	addi $zero, $zero, 12345
	
	srl $s2, $s2, 31
	srl $s1, $s1, 31
	srl $s0, $s0, 31
	
	