.data 0x0000
	
.text 0x0000
start: j main
recru:
	add $a0, $zero, $ra
	addi $v0, $zero, 3
	addi $zero, $zero, 12345
	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	addi $sp, $sp, -8
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
	addi $sp, $sp, 8
	addi $s1, $s1, 2 # pop stack for two times
	
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
not3_1:	jr $ra
	
contin:	addi $s3, $s3, 1
	jal recru
	
	lw $s3, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	add $s2, $s2, $s3
	addi $s1, $s1, 2 # pop stack for two times
	
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
not3_2:	jr $ra

second:	addi $t9, $zero, 3
	sll $t9, $t9, 23
	
loop_s:	addi $t9, $t9, -1
	bne $t9, $zero, loop_s
	
	jr $ra
main:
	addi $t0, $zero, 0
	addi $t1, $zero, 1
	addi $t2, $zero, 2
	addi $t3, $zero, 3
	addi $t4, $zero, 4
	addi $t5, $zero, 5
	addi $t6, $zero, 6
	addi $t7, $zero, 7

	addi $v0, $zero, 1
	addi $zero, $zero, 12345
	
	addi $s7, $zero, 2
	
	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	jal recru