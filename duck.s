		.global	send_new_duck
		.global	is_duck_out_of_screen
		.global	draw_duck
		.global	clear_duck
		.equ ADDR_VGA, 0x08000000

#sends a new duck with increased speed and random location
#send duck location in r4 and duck row in r5
#returns address of the next duck to be drawn in r2
#and row of the duck in r3
send_new_duck:
	addi sp,sp,-8
	stw ra,(sp)
	stw r16,4(sp)
		
	movia r16,ADDR_VGA
	call get_random_value
	mov r3,r2			#move the row that duck appears to r3
	muli r2,r2,1024
	add r2,r2,r16		#the random address the new duck will appear from
	movi r16,10
	bge r23,r16,speed_limit
	addi r23,r23,1		#increase the speed by 20%
speed_limit:
	ldw ra,(sp)
	ldw r16,4(sp)
	addi sp,sp,8	
	ret

#send location of duck in r4 and the y-coordinate of the duck in r5
is_duck_out_of_screen:
	movia r2,ADDR_VGA		
	muli r3,r5,1024	#which y coordinate we are on
	addi r3,r3,640	#the last column of the row
	add r3,r3,r2	#last address of the last pixel on the row
	movi r2,1	
	bge r4,r3,exit_is_duck_out_of_screen
	mov r2,r0	
exit_is_duck_out_of_screen:
	ret

#draws a white box on the screen  given a location in r4
draw_duck:	
	movui r2,0xffff
	movia r3,duck
	
	addi sp,sp,-12
	stw r16,(sp)
	stw r17,4(sp)
	stw r4,8(sp)
	
	#movi r17, #6144
	addi r17,r4,14336 # address of the end row
loop1:
	addi r16,r4,40	#address of the end column
loop2:
	ldh r2,(r3)
	sthio r2,(r4)
	addi r4,r4,2
	addi r3,r3,2
	bne r4,r16,loop2
	addi r4,r4,984
	bne r4,r17,loop1
	
	ldw r16,(sp)
	ldw r17,4(sp)
	ldw r4,8(sp)
	addi sp,sp,12
	ret
clear_duck:	
	movia r2,background
	addi sp,sp,-20
	stw r16,(sp)
	stw r17,4(sp)
	stw r4,8(sp)
	stw r18,12(sp)
	stw ra,16(sp)
	
	movia r17,15360 #6144
	add r17,r4,r17 # address of the end row
clear_loop1:
	addi r16,r4,40	#address of the end column
clear_loop2:
	ldh r18,(r2)

	addi sp,sp,-8
	stw r2,(sp)
	stw r4,4(sp)
	mov r4,r18
	call add_0_in_5th_bit
	mov r18,r2
	ldw r2,(sp)
	ldw r4,4(sp)
	addi sp,sp,8

	sthio r18,(r4)
	addi r2,r2,2
	addi r4,r4,2
	bne r4,r16,clear_loop2
	addi r4,r4,984
	bne r4,r17,clear_loop1
	
	ldw r16,(sp)
	ldw r17,4(sp)
	ldw r4,8(sp)
	ldw r18,12(sp)
	ldw ra,16(sp)
	addi sp,sp,20
	ret

