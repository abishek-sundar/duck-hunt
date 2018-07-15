.global triggerPressed
.equ time, 50000000
.equ JP1,0xFF200060
triggerPressed: 
	

	call black_screen
	movia r4,time
	call timer_delay
	call draw_white_box
	movia r4,time
	call timer_delay
	
	movia r17, JP1
	ldwio r18,(r17)
	andi  r18,r18,2	#mask the second bit(sensor)
	bne	  r18,r0,duck_not_hit
	call clear_screen
	ldw r2,(sp)
	ldw	r3,4(sp)
	ldw r4,8(sp)
	ldw r5,12(sp)
	ldw r16,16(sp)
	ldw r17,20(sp)
	ldw	r18,24(sp)
	ldw r19,28(sp)
	addi r21, r21, 1
	addi sp,sp,36
	
	call begin_game

duck_not_hit:
	call clear_screen
	ldw r2,(sp)
	ldw	r3,4(sp)
	ldw r4,8(sp)
	ldw r5,12(sp)
	ldw r16,16(sp)
	ldw r17,20(sp)
	ldw	r18,24(sp)
	ldw r19,28(sp)
	addi sp,sp,36	

	mov r4, r22
	call check_duck
	
