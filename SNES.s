.section .text


	.globl SNESInit
SNESInit:

	// Init GPIO11
	ldr	r0, =0x20200004
	ldr	r1, [r0]
	mov	r2, #7
	lsl	r2, #3
	bic	r1, r2
	mov	r3, #1
	lsl	r3, #3
	orr	r1, r3
	str	r1, [r0]

	// Init GPIO9
	ldr	r0, =0x20200000
	ldr	r1, [r0]
	mov	r2, #7
	lsl	r2, #27
	bic	r1, r2
	mov	r3, #1
	lsl	r3, #27
	orr	r1, r3
	str	r1, [r0]

	// Init GPI10
	ldr	r0, =0x20200004
	ldr	r1, [r0]
	mov	r2, #7
	bic	r1, r2
	str	r1, [r0]

	mov	pc, lr

//  void clockWrite(int systemMode)
	.globl clockWrite
clockWrite:
	mov	r1, #11
	ldr	r2, =0x20200000
	mov	r3, #1	
	lsl	r3, r1
	teq	r0, #0
	streq	r3, [r2, #40]
	strne	r3, [r2, #28]	
	mov	pc, lr

//  void latchWrite(int systemMode)
	.globl latchWrite
latchWrite:
	
	mov	r1, #9
	ldr	r2, =0x20200000
	mov	r3, #1	
	lsl	r3, r1
	teq	r0, #0
	streq	r3, [r2, #40]
	strne	r3, [r2, #28]		

	mov	pc, lr

// int dataRead()
	.globl	dataRead
dataRead:
	mov	r0, #10
	ldr	r2, =0x20200000
	ldr	r1, [r2,#52]
	mov	r3, #1
	lsl	r3, r0
	and	r1, r3
	teq	r1, #0
	moveq	r4, #0
	movne	r4, #1

	mov	pc, lr
