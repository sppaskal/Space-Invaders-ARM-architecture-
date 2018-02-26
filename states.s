/*

	Name: Shahab Seyedi, Slavi Paskelev

*/
// when the game is over, this routine is executed
.globl gameOver
gameOver:
	push	{r4-r10, lr}
	// game over message
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =380
	ldr	r2, =340
	ldr	r3, =0xffff
	ldr	r5, =270
	ldr	r4, =90
	bl	drawRect

	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =390
	ldr	r2, =350
	ldr	r3, =0x7800
	ldr	r5, =250
	ldr	r4, =70
	bl	drawRect

	mov	r6, #0
	ldr	r9, =471	// x
	ldr	r5, =GAMEOVER
scoreLoop:	
	ldrb	r0, [r5], #1	
	ldr	r10, =377	// y
	ldr	r3, =0xffff
	bl	DrawChar

	add	r9, #10
	add	r6, #1
	cmp	r6, #9
	blo	scoreLoop

readLoop:
	bl	readSNES	// get controller info and wait loop
	ldr	r9, =buttons
	ldr	r8, [r9]

	ldr	r0, =0xffff
	cmp	r8, r0
	beq	readLoop
.globl menuRestart
menuRestart:
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =0
	ldr	r2, =0
	ldr	r3, =0
	ldr	r5, =1023
	ldr	r4, =767
	bl	drawRect

	bl	restartGame	// restore initial values

	bl	restart		// restart game
	

	pop	{r4-r10,lr}
	mov	pc, lr
// this routine is executed when the player has won the game
.globl playerWon
playerWon:

	push	{r4-r10,lr}

	ldr	r0, =winFlag
	ldr	r0, [r0]
	cmp	r0, #17
	bne	wonEnd
	// player won
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =380
	ldr	r2, =340
	ldr	r3, =0xffff
	ldr	r5, =270
	ldr	r4, =90
	bl	drawRect

	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =390
	ldr	r2, =350
	ldr	r3, =0x7800
	ldr	r5, =250
	ldr	r4, =70
	bl	drawRect
	// win message
	mov	r6, #0
	ldr	r5, =won
	ldr	r9, =475
	ldr	r10, =377
wonLoop:
	ldr	r0, [r5], #4
	
	
	ldr	r3, =0xffff
	bl	DrawChar

	add	r9, #10
	add	r6, #1
	cmp	r6, #8
	blo	wonLoop
	b	readLoop
wonEnd:
	pop	{r4-r10,lr}
	mov	pc, lr
