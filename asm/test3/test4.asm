.data 0x0000
	
.text 0x0000
start:
	addi $t0, $zero, 0

	While:  addi $v0, $zero, 0
	addi $zero, $zero, 12345 # syscall
	beq $t0, $a0, case0
	j While

case0:addi $v0, $zero, 0
	addi $zero, $zero, 12345

	add $s0, $a0, $zero
	add $s2, $zero, $zero
	addi $s3, $zero, 1
	
	slt $s1, $s0, $zero # check whether a < 0
	beq $s1, $zero, big0
	addi $v0, $zero, 4 # show a < 0
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
break0:	addi $v0, $zero, 2
	add $a0, $zero, $s2
	addi $zero, $zero, 12345
	j While