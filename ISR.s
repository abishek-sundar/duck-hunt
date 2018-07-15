	.global ISR
	.section .exceptions, "ax" 
	.equ ADDR_PUSHBUTTONS, 0xFF200050
	.equ TIMER2,0xFF202020 
	.equ JP1,0xFF200060

ISR:
	rdctl et,ipending 	#check if the interrupt happened because of KEYs
	andi et,et,0b0010
	bne et,r0,serve_restart

	rdctl et,ipending 	#check if the interrupt happened because of KEYs
	andi et,et,0b0100
	bne et,r0,serve_timer2

	rdctl et,ipending
	andi et,et,0x0800
	bne et,r0,serve_trigger
	br exit
serve_restart:
	movia et,ADDR_PUSHBUTTONS
	movi r16,2
	stwio r16,12(et) 		#acknowledge interrupt
	
	movia ea,_start
	eret
serve_timer2:
	movia et,TIMER2		#acknowledge interrupt
	stwio r0,(et)
	#make it go to end game screen
	#movia ea,_start
	movia ea,end_game
	eret
serve_trigger:
	movia et,JP1
	addi ea,ea,-4
	addi sp,sp,-36
	stw r2,(sp)
	stw	r3,4(sp)
	stw r4,8(sp)
	stw r5,12(sp)
	stw r16,16(sp)
	stw r17,20(sp)
	stw	r18,24(sp)
	stw r19,28(sp)
	stw ea, 32(sp)
	movia r18,0xFFFFFFFF
	stwio r18,12(et)		#acknowledge interrupt
	movia ea, triggerPressed
	eret
exit:
	addi ea,ea,4
	eret
