.data 0x0000
	
.text 0x000
start: j work
second:	addi $t9, $zero, 3
	sll $t9, $t9, 23
	
loop_s:	addi $t9, $t9, -1
	bne $t9, $zero, loop_s
	
	jr $ra
work: addi $v0, $zero, 0
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
noadd7:	add $s0, $s0, $s1
	bne $s5, $zero, loop7

	addi $s5, $zero, 1
	bne $a0, $s5, notneg0
		sub $s0, $zero, $s0
notneg0:	bne $s3, $s5, notneg1
		sub $s4, $zero, $s4
notneg1:	addi $v0, $zero, 2
	add $a0, $zero, $s4
	addi $zero, $zero, 12345
	
	add $a0, $zero, $s0
	addi $zero, $zero, 12345
