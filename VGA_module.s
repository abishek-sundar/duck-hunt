	.global VGA_module
	.global	clear_screen
	.global	add_0_in_5th_bit
	.global begin_game
	.global check_duck
	.equ ADDR_VGA, 0x08000000
	.equ refresh_rate, 2000000

VGA_module:
#you use r7 in clear screen and clear duck put them on stack birch
#check duck colours
	addi sp,sp,-20
	stw ra,(sp)
	stw r16,4(sp)
	stw r17,8(sp)
	stw r18,12(sp)
	stw r19,16(sp)
	movia r16,ADDR_VGA
	movia r17,refresh_rate
	mov r8,r0
begin_game:
	call hex_decoder
	call get_random_value
	mov r5,r2			#r5 has the row of the duck
	muli r4,r2,1024	
	add r4,r4,r16		#r4 has the address of the duck
	mov r9,r4			#store the starting address in r19
check_duck:
	call is_duck_out_of_screen
	bne r2,r0,duck_off_screen
	br move
duck_off_screen:
	call send_new_duck
	mov r8,r0
	mov r4,r2		#r4 becomes the new address of the duck
	mov r9,r2		
	mov r5,r3		#r5 becomes the row of the duc
	
	br move
move:
	add r4,r8,r9
	mov	r22,r4
	mov r16,r4
	call draw_duck
	mov r4,r17
	call timer_delay
	mov r4,r16
	call clear_duck
	
	add r8,r8,r23 		#speed of the box
	br check_duck
		
	ldw ra,(sp)
	ldw r16,4(sp)
	ldw r17,8(sp)
	ldw r18,12(sp)
	ldw r19,16(sp)
	addi sp,sp,20
	ret

clear_screen:
	addi sp,sp,-16
	stw r16,(sp)
	stw r17,4(sp)
	stw ra,8(sp)
	stw r18,12(sp)
	movia r2,ADDR_VGA
	movia r3,background	#address of the background
			
	movia r17,245760 #240*1024 = 245760
	add r17,r17,r2 	# address of the last pixel
		
outer_loop:
	addi r18,r2,640
clear_screen_loop:
	ldh r16,(r3) #r16 has the color
	
	addi sp,sp,-4
	stw r2,(sp)
	mov r4,r16
	call add_0_in_5th_bit
	mov r16,r2
	ldw r2,(sp)
	addi sp,sp,4	
	
	sthio r16,(r2)
	addi r2,r2,2
	addi r3,r3,2
	bne r2,r18,clear_screen_loop
	addi r2,r2,384	
	bne r2,r17,outer_loop

	ldw r16,(sp)
	ldw r17,4(sp)
	ldw ra,8(sp)
	ldw r18,12(sp)
	addi sp,sp,16
	ret
add_0_in_5th_bit:
	mov r2,r4
	andi r2,r2,0x0000001F		#mask the first 5bits
	andi r4,r4,0X0000FFE0 		#mask the bits from 16 to 6
	slli r4,r4,1 #shif r4 by 1 bit
	add r2,r2,r4
	ret
	
