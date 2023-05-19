.data 0x0000
	
.text 0x0000
start: j main
test:	addi $v0, $zero, 3
	add $a0, $zero, $ra
	addi $zero, $zero, 12345

	addi $v0, $zero, 0
	addi $zero, $zero, 12345
	
	jr $ra

main:jal test
	addi $v0, $zero, 2
	addi $zero, $zero, 12345
	