	.global timer2_interrupt
	.equ TIMER2, 0xFF202020
	.equ time2, 3000000000	#30 seconds
timer2_interrupt:
	movia r2,TIMER2			#initalize the timer
	stwio r0,0(r2)
	movui r3,%lo(time2)
	stwio r3,8(r2)
	movui r3,%hi(time2)
	stwio r3,12(r2)
	
	#movi r3,0b0101		#start timer
	movi r3,0b0111
	stwio r3,4(r2)
	ret
	 

