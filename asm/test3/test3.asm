.data 0x0000
	
.text 0x000
start:
	addi $a0, $zero, 15
	addi $v0, $zero, 2
	addi $zero, $zero, 12345 # syscall