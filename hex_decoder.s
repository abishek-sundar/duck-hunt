.global hex_decoder
.equ HEX, 0xFF200020
.equ D0, 0b0111111
.equ D1, 0b0000110
.equ D2, 0b1011011
.equ D3, 0b1001111
.equ D4, 0b1100110
.equ D5, 0b1101101
.equ D6, 0b1111101
.equ D7, 0b0000111
.equ D8, 0b1111111
.equ D9, 0b1100111

hex_decoder:
	addi sp,sp,-8
	stw r16, (sp)
	stw r17, 4(sp)
	movi r3, 10
	div r2, r21, r3
	mul r3,r2,r3
	sub r3,r21,r3

	mov r16,r0
	beq r16,r2,SET_HEX2_0
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_1
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_2
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_3
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_4
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_5
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_6
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_7
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_8
	addi r16, r16, 1
	beq r16,r2,SET_HEX2_9
determine_hex1:
	mov r16,r0
	beq r16,r3,SET_HEX1_0
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_1
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_2
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_3
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_4
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_5
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_6
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_7
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_8
	addi r16, r16, 1
	beq r16,r3,SET_HEX1_9
exit:
	
	or r2,r16,r17
	ori r2,r2, 0b0111111
	movia r3, HEX
	stwio r2,(r3)
	
	
	ldw r16, (sp)
	ldw r17, 4(sp)
	addi sp,sp,8

	ret
		
SET_HEX2_0:
	movi r17, 0b0111111
	slli r17,r17,16
	br determine_hex1

SET_HEX2_1:
	movi r17, 0b0000110
	slli r17,r17,16
	br determine_hex1

SET_HEX2_2:
	movi r17, 0b1011011
	slli r17,r17,16
	br determine_hex1

SET_HEX2_3:
	movi r17, 0b1001111
	slli r17,r17,16
	br determine_hex1

SET_HEX2_4:
	movi r17, 0b1100110
	slli r17,r17,16
	br determine_hex1

SET_HEX2_5:
	movi r17, 0b1101101
	slli r17,r17,16
	br determine_hex1

SET_HEX2_6:
	movi r17, 0b1111101
	slli r17,r17,16
	br determine_hex1

SET_HEX2_7:
	movi r17, 0b0000111
	slli r17,r17,16
	br determine_hex1

SET_HEX2_8:
	movi r17, 0b1111111
	slli r17,r17,16
	br determine_hex1

SET_HEX2_9:
	movi r17, 0b1100111
	slli r17,r17,16
	br determine_hex1

SET_HEX1_0:
	movi r16, 0b0111111
	slli r16,r16,8
	br exit

SET_HEX1_1:
	movi r16, 0b0000110
	slli r16,r16,8
	br exit

SET_HEX1_2:
	movi r16, 0b1011011
	slli r16,r16,8
	br exit

SET_HEX1_3:
	movi r16, 0b1001111
	slli r16,r16,8
	br exit

SET_HEX1_4:
	movi r16, 0b1100110
	slli r16,r16,8
	br exit

SET_HEX1_5:
	movi r16, 0b1101101
	slli r16,r16,8
	br exit

SET_HEX1_6:
	movi r16, 0b1111101
	slli r16,r16,8
	br exit

SET_HEX1_7:
	movi r16, 0b0000111
	slli r16,r16,8
	br exit

SET_HEX1_8:
	movi r16, 0b1111111
	slli r16,r16,8
	br exit

SET_HEX1_9:
	movi r16, 0b1100111
	slli r16,r16,8
	br exit



