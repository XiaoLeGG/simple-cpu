.data 0x0000
	
.text 0x000
start: addi $v0, $zero, 0 # get a
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
