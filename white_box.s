	.global	trigger
	.global draw_white_box
	.global black_screen
	.equ VGA,0x08000000
	.equ JP1,0xFF200060
	.equ LED,0xFF200000
trigger:
	call black_screen
	call draw_white_box
	movia r16,LED
	movia r17,JP1
	movia r18,0xFFFFFFFE #make the first 2 bits an input(0's)
	stwio r18,4(r17)
	stwio r0,(r17)
loop:
	ldwio r18,(r17)
	andi  r18,r18,1	#mask the first bit(switch)
	bne	  r18,r0,turn_off_LED
turn_on_LED:
	movi  r18,0xff
	stwio r18,(r16)
	movia r4, 100000000
	call timer_delay
	br loop
turn_off_LED:
	stwio r0,(r16)
	br loop
black_screen:
	movia r2,VGA
	movia r3,245760
	add r3,r2,r3
keep_drawing:	
	sthio r0,(r2)
	addi r2,r2,2
	blt r2,r3,keep_drawing
	ret
draw_white_box:
	movui r2,0xffff
	
	addi sp,sp,-12
	stw r16,(sp)
	stw r17,4(sp)
	stw r22,8(sp)
	
	#movi r17, #6144
	addi r17,r22,14336 # address of the end row
white_box_loop1:
	addi r16,r22,40	#address of the end column
white_box_loop2:
	sthio r2,(r22)
	addi r22,r22,2
	addi r3,r3,2
	bne r22,r16,white_box_loop2
	addi r22,r22,984
	bne r22,r17,white_box_loop1
	
	ldw r16,(sp)
	ldw r17,4(sp)
	ldw r22,8(sp)
	addi sp,sp,12
	ret
