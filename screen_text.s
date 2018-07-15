		.global print_start_game_text
		.global clear_text
		.global	print_game_over_text
		.equ ADDR_CHAR, 0x09000000
print_start_game_text:
	addi sp,sp,-12
	stw r16,(sp)
	stw r17,4(sp)
	stw	r18,8(sp)
	movia r2,ADDR_CHAR
	addi r2,r2,0x139E		#start printing from this location
	movia r3,start_game_text

	addi r17,r2,384
start_game_text_loop1:
	addi r16,r2,18
start_game_text_loop2:
	ldb	r18,(r3)
	stbio r18,(r2)
	addi r2,r2,1
	addi r3,r3,1
	bne	r2,r16,start_game_text_loop2
	addi r2,r2,110
	bne r2,r17,start_game_text_loop1
	
	ldw r16,(sp)
	ldw	r17,4(sp)
	ldw r18,8(sp)
	addi sp,sp,12
	ret
print_game_over_text:
	addi sp,sp,-12
	stw r16,(sp)
	stw r17,4(sp)
	stw	r18,8(sp)
	movia r2,ADDR_CHAR
	addi r2,r2,0x139E		#start printing from this location
	movia r3,game_over_text

	addi r17,r2,384
game_over_text_loop1:
	addi r16,r2,20
game_over_text_loop2:
	ldb	r18,(r3)
	stbio r18,(r2)
	addi r2,r2,1
	addi r3,r3,1
	bne	r2,r16,game_over_text_loop2
	addi r2,r2,108
	bne r2,r17,game_over_text_loop1
	
	ldw r16,(sp)
	ldw	r17,4(sp)
	ldw r18,8(sp)
	addi sp,sp,12
	ret
clear_text:
	addi sp,sp,-8
	stw r16,(sp)
	stw r17,4(sp)
	
	movia r2,ADDR_CHAR
	addi r2,r2,0x139E		#start printing from this location
	movi r3,' '
	addi r17,r2,384
clear_text_loop1:
	addi r16,r2,20
clear_text_loop2:
	
	stbio r3,(r2)
	addi r2,r2,1
	bne	r2,r16,clear_text_loop2
	addi r2,r2,108
	bne r2,r17,clear_text_loop1
	
	ldw r16,(sp)
	ldw	r17,4(sp)
	
	addi sp,sp,8
	ret
