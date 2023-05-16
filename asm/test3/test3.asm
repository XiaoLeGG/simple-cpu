.data 0x0000
	
.text 0x000
start:
	addi $v0, $zero, 0
	addi $zero, $zero, 12345 # syscall
	
	addi $v0, $zero, 2
	addi $zero, $zero, 12345 # syscall