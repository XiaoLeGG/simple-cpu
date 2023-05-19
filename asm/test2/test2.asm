.data 0x0000
	
.text	0x0000
start: j main
second:	addi $t9, $zero, 3
	sll $t9, $t9, 23
	
loop_s:	addi $t9, $t9, -1
	bne $t9, $zero, loop_s
	
	jr $ra

# s0: read a
# s1: push stack and pop stack times
# s2: the add sum
# s3: now number
# s7: case type
recru:	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $s3, 0($sp)
	addi $s1, $s1, 2 # push stack for two times
	
	bne $s7, $t2, not2 # push stack for case 2
		addi $v0, $zero, 3
		add $a0, $zero, $s3
		addi $zero, $zero, 12345
		# 2~3 seconds
		addi $t8, $zero, 2
		sec2_1:	addi $t8, $t8, -1
			jal second
			bne $t8, $zero, sec2_1
		lw $ra, 4($sp)
	
not2:	bne $s3, $s0, contin
	add $s2, $s2, $s3
	
	bne $s7, $t3, not3_1 # pop stack for case 3
		addi $v0, $zero, 3
		add $a0, $zero, $s3
		addi $zero, $zero, 12345
		# 2~3 seconds
		addi $t8, $zero, 2
		sec2_2:	addi $t8, $t8, -1
			jal second
			bne $t8, $zero, sec2_2
		lw $ra, 4($sp)
not3_1:	
		addi $sp, $sp, 8
		addi $s1, $s1, 2 # pop stack for two times
		jr $ra
	
contin:	addi $s3, $s3, 1
	jal recru
	
	lw $s3, 0($sp)
	lw $ra, 4($sp)
	add $s2, $s2, $s3
	
	bne $s7, $t3, not3_2 # pop stack for case 3
		addi $v0, $zero, 3
		add $a0, $zero, $s3
		addi $zero, $zero, 12345
		# 2~3 seconds
		addi $t8, $zero, 2
		sec2_3:	addi $t8, $t8, -1
			jal second
			bne $t8, $zero, sec2_3
		lw $ra, 4($sp)
not3_2:	
		addi $sp, $sp, 8
		addi $s1, $s1, 2 # pop stack for two times
		jr $ra

main:	addi $t0, $zero, 0
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

# s0: store the value of a
# s2: store the sum from 1 to a
# s3: used during adding loop
case0:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 0
	addi $zero, $zero, 12345

	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	add $a0, $zero, $zero
	beq $s0, $zero, loop00 # a = 0
	slt $s1, $s0, $zero # check whether a < 0
	beq $s1, $zero, big0
	addi $a0, $zero, 2
	loop00:	add $s2, $s2, $s3 
		beq $s3, $s0, break0
		addi $s3, $s3, -1
		j loop00
	big0:	add $s2, $s2, $s3
		beq $s3, $s0, break0
		addi $s3, $s3, 1
		j big0
break0:	addi $v0, $zero, 4 # show a < 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 2
	add $a0, $zero, $s2
	addi $zero, $zero, 12345
	j While

# s0: read a
# s1: push stack and pop stack times
# s2: the add sum
# s3: now number
# s7: case type
case1:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	
	add $s0, $a0, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	addi $s7, $zero, 1
	
	jal recru
	
	addi $v0, $zero, 3
	add $a0, $zero, $s1
	addi $zero, $zero, 12345
	
	j While

# s0: read a
# s2: the add sum
# s3: now number
# s7: case type
case2:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	
	addi $s7, $zero, 2
	
	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	jal recru
	
	j While

# s0: read a
# s2: the add sum
# s3: now number
# s7: case type
case3:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	
	addi $s7, $zero, 3
	
	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	jal recru
	
	j While

# s0: a
# s1: b
# s2: a + b
# s3: higher 24 bits of (a + b)
case4:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 0 # get a
	addi $zero, $zero, 12345
	add $s0, $a0, $zero
	
	addi $v0, $zero, 0 # get b
	addi $zero, $zero, 12345
	add $s1, $a0, $zero
	
	add $s2, $s1, $s0

	sll $s2, $s2, 24
	sra $s2, $s2, 24
	
	srl $s3, $s2, 31
	srl $s4, $s1, 31
	srl $s5, $s0, 31
	
	xor $s6, $s3, $s5
	xor $s7, $s3, $s4
	and $s6, $s6, $s7
	
	add $a0, $zero, $zero
	beq $s6, $zero, noov4 # check whether overflow
		addi $a0, $zero, 1
noov4:	addi $v0, $zero, 4 # overflow
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 2 # show a + b
	add $a0, $s2, $zero
	addi $zero, $zero, 12345
	
	j While

# s0: a
# s1: b
# s2: a - b
# s3: higher 24 bits of (a - b)
case5:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 0 # get a
	addi $zero, $zero, 12345
	add $s0, $a0, $zero
	
	addi $v0, $zero, 0 # get b
	addi $zero, $zero, 12345
	add $s1, $a0, $zero
	sub $s2, $s0, $s1

	sll $s2, $s2, 24
	sra $s2, $s2, 24
	
	srl $s3, $s2, 31
	srl $s4, $s1, 31
	srl $s5, $s0, 31
	
	xor $s6, $s5, $s4
	xor $s7, $s5, $s3
	and $s6, $s6, $s7
	
	add $a0, $zero, $zero
	beq $s6, $zero, noov5 # check whether overflow
		addi $a0, $zero, 1
noov5:	addi $v0, $zero, 4 # overflow
	addi $zero, $zero, 12345
	
	addi $v0, $zero, 2 # show a - b
	add $a0, $s2, $zero
	addi $zero, $zero, 12345
	
	j While

# a * b:
# $s0: a
# $s1: b
# $s2: used to check whether a < 0 or b < 0, after that it is used to stand 1
# $s3: used to record how many negative numbers
# $s4: used to record the answer
case6:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 0
	addi $zero, $zero, 12345
	add $s0, $zero, $a0
	
	addi $v0, $zero, 0
	addi $zero, $zero, 12345
	add $s1, $zero, $a0
	
	slt $s2, $s0, $zero # check whether a is negative
	beq $s2, $zero, no6_0
		addi $s3, $zero, 1
		sub $s0, $zero, $s0
no6_0:	slt $s2, $s1, $zero  # check whether a is negative
	beq $s2, $zero, no6_1
		addi $s3, $s3, 1
		sub $s1, $zero, $s1
no6_1:	add $s4, $zero, $zero
	addi $s2, $zero, 1
	loop6:	beq $s0, $zero, break6
		and $s5, $s0, $s2
		beq $s5, $zero, else6_0
			add $s4, $s4, $s1
	else6_0:srl $s0, $s0, 1
		sll $s1, $s1, 1
		j loop6
break6:	addi $s5, $zero, 1
	bne $s3, $s5, noneg6
		sub $s4, $zero, $s4
noneg6:	addi $v0, $zero, 2 # show a * b
	add $a0, $zero, $s4
	addi $zero, $zero, 12345
	
	j While

case7:
	addi $v0, $zero, 2
	addi $a0, $zero, 0
	addi $zero, $zero, 12345
	addi $v0, $zero, 4
	addi $zero, $zero, 12345

	addi $v0, $zero, 0
	addi $zero, $zero, 12345
	add $s0, $zero, $a0
	
	addi $v0, $zero, 0
	addi $zero, $zero, 12345
	add $s1, $zero, $a0
	
	slt $s2, $s0, $zero # check whether a is negative
	add $a0, $s2, $zero
	beq $s2, $zero, no7_0
		addi $s3, $zero, 1
		sub $s0, $zero, $s0
no7_0:	slt $s2, $s1, $zero  # check whether a is negative
	beq $s2, $zero, no7_1
		addi $s3, $s3, 1
		sub $s1, $zero, $s1
no7_1:	sll $s1, $s1, 8
	add $s4, $zero, $zero
	addi $s5, $zero, 8
loop7:	addi $s5, $s5, -1
	srl $s1, $s1, 1
	sub $s0, $s0, $s1
	slt $s7, $s0, $zero
	sll $s4, $s4, 1
	bne $s7, $zero, noadd7
		addi $s4, $s4, 1
		bne $s5, $zero, loop7
		j out7
noadd7:	add $s0, $s0, $s1
	bne $s5, $zero, loop7

out7:addi $s5, $zero, 1
	bne $a0, $s5, notneg0
		sub $s0, $zero, $s0
notneg0:	bne $s3, $s5, notneg1
		sub $s4, $zero, $s4
notneg1:	addi $v0, $zero, 2
	add $a0, $zero, $s4
	addi $zero, $zero, 12345
	#5 seconds
	addi $s5, $zero, 5
sec5_1:	addi $s5, $s5, -1
	jal second
	bne $s5, $zero, sec5_1
	
	add $a0, $zero, $s0
	addi $zero, $zero, 12345
	#5 seconds
	addi $s5, $zero, 5
sec5_2:	addi $s5, $s5, -1
	jal second
	bne $s5, $zero, sec5_2
	
	j While


