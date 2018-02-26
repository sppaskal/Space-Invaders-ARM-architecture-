/*
	r0 = Char ASCII
	r9 = x
	r10 = y
	r3 = color
*/

/* Draw the character 'B' to (0,0)
 */

.globl	DrawChar
DrawChar:
	push	{r4-r10, lr}

	chAdr	.req	r4
	px		.req	r5
	py		.req	r6
	row		.req	r7
	mask	.req	r8

	ldr		chAdr,	=font		// load the address of the font map
	//mov		r0,		#'B'		// load the character into r0
	add		chAdr,	r0, lsl #4	// char address = font base + (char * 16)

	mov		py,		r10			// init the Y coordinate (pixel coordinate)

charLoop$:
	mov		px,		r9			// init the X coordinate

testchar:
	mov		mask,	#0x01		// set the bitmask to 1 in the LSB
	
	ldrb	row,	[chAdr], #1	// load the row byte, post increment chAdr

rowLoop$:
	tst		row,	mask		// test row byte against the bitmask
	beq		noPixel$

	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	mov		r1,		px
	mov		r2,		py
	//mov		r3,		#0xF800		// red
	bl		DrawPixel16bpp			// draw red pixel at (px, py)

noPixel$:
	add		px,		#1			// increment x coordinate by 1
	lsl		mask,	#1			// shift bitmask left by 1

	tst		mask,	#0x100		// test if the bitmask has shifted 8 times (test 9th bit)
	beq		rowLoop$

	add		py,		#1			// increment y coordinate by 1

	tst		chAdr,	#0xF
	bne		charLoop$			// loop back to charLoop$, unless address evenly divisibly by 16 (ie: at the next char)

	.unreq	chAdr
	.unreq	px
	.unreq	py
	.unreq	row
	.unreq	mask
charEnd:
	pop	{r4-r10, lr}
	mov	pc, lr

.section .data

.align 4
font:		.incbin	"font.bin"
