# Alpaslan Hamzaoglu - 25075
.data

prompt1: .asciiz  "\Enter an integer to partition (n): "
prompt2: .asciiz  "\Enter an integer for size of the partition (m): "

.text

main:
      la $a0,  prompt1          
      li $v0,4
      syscall              

      li $v0, 5
      syscall		
      move $t0, $v0	# $t0 = n
      
      la $a0,  prompt2          
      li $v0,4
      syscall              

      li $v0, 5
      syscall		
      move $t1, $v0	# $t1 = m
      
      add $a0, $t0, $zero
      add $a1, $t1, $zero
      
      jal count_partitions
      
      move $a0,$v0        
      li $v0, 1
      syscall                #prints the integer

      li $v0, 10
      syscall

count_partitions:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	bne $a0, $zero, L1
	addi $v0, $zero, 1
	addi $sp, $sp, 4
	jr $ra
L1:
	slti $t2, $a0, 0
	beq $t2, $zero, L2
	addi $v0, $zero, 0
	addi $sp, $sp, 4
	jr $ra
L2:
	bne $a1, $zero, L3
	addi $v0, $zero, 0
	addi $sp, $sp, 4
	jr $ra
L3:
	subi $a1, $a1, 1
	addi $a0, $a0, 0
	jal count_partitions
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $sp, $sp, -8
	sw $v0, 0($sp)
	sw $ra, 4($sp)
	addi $a1, $a1, 1
	sub $a0, $a0, $a1
	
	jal count_partitions
	
	add $a0, $a0, $a1
	lw $ra, 4($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 8
	add $v0, $v0, $s1
	jr $ra
