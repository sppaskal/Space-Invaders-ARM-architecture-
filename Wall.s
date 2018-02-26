/*

	Name: Shahab Seyedi, Slavi Paskelev

*/

// makes the 1st wall into half
.globl halfWall
halfWall1:
	push	{r4, r5, lr}
	ldr	r0, =wallHP
	ldr	r1, [r0]
	sub	r1, #10
	str	r1, [r0]
	// clear
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =wallX
	ldr	r1, [r1]
	ldr	r2, =430
	ldr	r3, =0
	ldr	r4, =wallWidth
	ldr	r5, [r4]
	mov	r4, #50

	bl	drawRect
	
	ldr	r0, =wallWidth
	ldr	r1, [r0]
	sub	r1, #50
	str	r1, [r0]	

	// If wall is below 200 HP then we half it in width.
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =wallX
	ldr	r1, [r1]
	ldr	r2, =430
	ldr	r3, =0xffff
	ldr	r4, =wallWidth
	ldr	r5, [r4]
	mov	r4, #50

	bl	drawRect

	

	pop	{r4,r5,lr}
	mov	pc, lr
// makes the 2nd wall into half
.globl halfWall2
halfWall2:
	push	{r4, r5, lr}
	
	ldr	r0, =wallHP
	ldr	r1, [r0, #4]
	sub	r1, #10
	str	r1, [r0, #4]
		
	// clear
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =wallX
	ldr	r1, [r1,#4]
	ldr	r2, =430
	ldr	r3, =0
	ldr	r4, =wallWidth
	ldr	r5, [r4, #4]
	mov	r4, #50

	bl	drawRect
	ldr	r0, =wallWidth
	ldr	r1, [r0, #4]
	sub	r1, #50
	str	r1, [r0, #4]
	
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =wallX
	ldr	r1, [r1, #4]
	ldr	r2, =430
	ldr	r3, =0xffff
	ldr	r4, =wallWidth
	ldr	r5, [r4, #4]
	mov	r4, #50

	bl	drawRect

	pop	{r4, r5, lr}
	mov	pc, lr
// checks to see if the wall needs to be halfed
.globl wallChecker
wallChecker:
	push	{r5, r6, r9, lr}

	mov	r9, #0	// loop control
	ldr	r6, =wallHP

wallCheckerLoop:
	ldr	r1, [r6], #4
	cmp	r1, #200
	bne	checkerLoopBottom
	
	cmp	r9, #0
	bleq	halfWall1		// when wall needs to be halfed
	cmp	r9, #0
	blne	halfWall2		

checkerLoopBottom:
	add	r9, #1
	cmp	r9, #2
	blo	wallCheckerLoop

wallCheck2: // if wall is dead

	mov	r9, #0
	ldr	r5, =wallHP

halfWallLoop:
	
	ldr	r1, [r5], #4
	cmp	r1, #0
	bne	halfWallLoopBottom
	
	cmp	r9, #0
	bleq	clearWall1		// when wall needs to be halfed
	cmp	r9, #0
	blne	clearWall2
	

halfWallLoopBottom:
	add	r9, #1
	cmp	r9, #2
	blo	halfWallLoop

wallCheckerEnd:
	pop	{r5, r6, r9, lr}
	mov	pc, lr




.globl clearWall1
clearWall1:

	push {r4, r5, lr}
	
	ldr	r0, =wallHP
	ldr	r1, [r0]
	sub	r1, #10
	str	r1, [r0]	
	
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =wallX
	ldr	r1, [r1]
	ldr	r2, =430
	mov	r4, #50
	mov	r5, #50
	mov	r3, #0

	bl	drawRect

	ldr	r0, =wallFlag
	ldr	r1, [r0]
	mov	r1, #0
	str	r1, [r0]

	pop {r4, r5, lr}
		
	mov	pc, lr



.globl clearWall2
clearWall2:

	push {r4, r5, lr}
	
	ldr	r0, =wallHP
	ldr	r1, [r0, #4]
	sub	r1, #10
	str	r1, [r0, #4]

	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r1, =wallX
	ldr	r1, [r1, #4]
	ldr	r2, =430
	mov	r4, #50
	mov	r5, #50
	mov	r3, #0

	bl	drawRect

	ldr	r0, =wallFlag
	ldr	r1, [r0, #4]
	mov	r1, #0
	str	r1, [r0, #4]

	pop {r4, r5, lr}
		
	mov	pc, lr
