.data 0x0000
	
.text 0x000
start: addi $v0, $zero, 1
		addi $zero, $zero, 12345
		
		addi $v0, $zero, 3
		addi $zero, $zero, 12345
		
		add $s0, $a0, $zero
		addi $s1, $zero, 1
		and $a0, $s1, $s0
		addi $v0, $zero, 4 # result led
		addi $zero, $zero, 12345
