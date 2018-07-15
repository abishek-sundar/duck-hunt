.global timer_delay
.equ TIMER, 0xFF202000

timer_delay:
	subi sp,sp,4
	stw ra,(sp)
	movia r2,TIMER
	andi r3,r4,0x0000FFFF
	stwio r3,8(r2)
	movia r3,0xFFFF0000
	and r3,r4,r3
	srli r3,r3,16
	stwio r3,12(r2)

	movui r3,4
	stwio r3,4(r2)
	
poll:
	ldwio r3,(r2)
	andi r3,r3,1
	beq r3,r0,poll

	stwio r0,(r2)
	ldw ra,(sp)
	addi sp,sp,4
	ret

	
