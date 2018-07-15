	.global get_random_value
	.equ TIMER2, 0xFF202020

# get a random value from 0 to 127
get_random_value:
	movia r2,TIMER2	
	stwio r0,16(r2)		#take a snaphot of the timer
	ldwio r3,16(r2)
	andi r2,r3,0x007F	#get the first bits 6-0 to get a range of random values
	ret
	


