/*

	Name: Shahab Seyedi, Slavi Paskelev

*/


/*
.equ	START_BUTTON, 	0xEFFF
.equ	UP_BUTTON, 	0xF7FF
.equ	DOWN_BUTTON, 	0xFBFF
.equ	LEFT_BUTTON, 	0xFDFF 
.equ	RIGHT_BUTTON, 	0xFEFF
.equ	A_BUTTON, 	0xFF7F
*/


// The X and Y are saved in memory, need to go over line 55

.section    .init
.globl     _start

_start:
    b       main
    
.section .text

main:
	mov     sp, #0x8000
	bl	EnableJTAG

	bl	SNESInit	// Init the SNES controller
	bl	InitFrameBuffer
	cmp	r0, #0		// Screen is failed
	beq	haltLoop$
	ldr	r1, =frameBufferPointer
	str	r0, [r1]
.globl	restart
restart:
	ldr	r0, =playerX	// load the player on the screen
	ldr	r1, =427
	str	r1, [r0]
	ldr	r1, =487
	str	r1, [r0,#4]
	mov	r10, #0  	// Validator register to check for held down buttons
	mov	r8, #0
	
	bl	initScreen	// init the screen
	bl	initPawns	// init the pawns
	bl	initKnights	// init the knights
	bl	initQueens	// init the queens
	bl	initWall	// init the walls

	bl	initFont	// set the initial texts

	mov	r11, #0
	mov	r12, #0
	mov	r4, #0

.globl gameLoop
gameLoop:
	//bl	movePawn1
	ldr	r0, =0xffff
	cmp	r8, r0		// check to see if no buttons are pressed
	moveq	r10, #0
	
	bl	drawPlayer	// draw the player
	
	bl	readSNES	// get controller info
	ldr	r9, =buttons
	ldr	r8, [r9]
	

	cmp	r10, r8 // if curent button == previous button, go back to gameloop 
	beq	skip
	////////////////// Button Switch
	ldr	r0, =0xfeff	// RIGHT
	cmp	r8, r0 // If right button is pressed
	ldreq	r10, =0xfeff
	bleq	moveRight

	ldr	r0, =0xFDFF	// LEFT
	cmp	r8, r0
	ldreq	r10, =0xFDFF
	bleq	moveLeft

	ldr	r0, =0xF7FF	// UP
	cmp	r8, r0
	ldreq	r10, =0xF7FF
	bleq	moveUp

	ldr	r0, =0xFBFF	// DOWN
	cmp	r8, r0
	ldreq	r10, =0xFBFF
	bleq	moveDown

	ldr	r0, =0xEFFF	// select
	cmp	r8, r0
	ldreq	r10, =0xEFFF
	bleq	menu

	ldr	r0, =0xFF7F	// A Button
	cmp	r8, r0
	bne	skip	

	ldr	r10, =0xFF7F	
	ldr	r12, =playerBulletStatus
	ldr	r12, [r12]
	cmp	r12, #1
	bne	skip

	bl	aPressed


skip:
	bl	playerBullet	// draw player bullet	
	
	bl	checkHits	// check for player hits
	bl	checkHitsPlayer	// check for AI hits
	bl	wallChecker	// check for wall hp
	bl	playerHP	// check player HP
	
	bl	AIBullet	// move the pawn bullet
	bl	AIBullet2	// move the knight bullet
	bl	AIBullet3	// move the queen bullet
	
	ldr	r5, =0x2000	// wait
	bl 	clock
	
	add	r4, #1
	cmp	r4, #10
	moveq	r4, #0
	bleq	movePawnRight	// move pawns to the right

	bl	playerWon	// check for player win state

	ldr	r0, =playerFlag	// check player flag
	ldr	r0, [r0]
	cmp	r0, #0
	bleq	gameOver

	ldr	r0, =playerFlag// check player flag
	ldr	r0, [r0]
	cmp	r0, #0
	beq	haltLoop$

	b	gameLoop

	b 	haltLoop$

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// this subroutine will draw the player on the screen based on an x and y position
drawPlayer:
	push	{r4,r5, r9, lr}
	ldr	r1, =frameBufferPointer
	ldr	r0, [r1]

	ldr	r9, =playerX
	ldr	r1, [r9]	
	ldr	r2, [r9,#4]
	mov	r5, #50
	mov	r4, #50
	ldr	r3, =0xFF00

	bl	drawRect
	pop	{r4,r5, r9, lr}
	mov	pc, lr
/*
// void drawRect( x, y, width, length, color)
/*
*	r0 = framePointer
*	r1 = x
*	r2 = y
	r3 = color
	r4 = height
	r5 = width
*/

///////////////////////////////////////////////////
.globl drawRect
drawRect:

	push	{r4, r5, r7, r8, lr}
	mov	r7, #0
	mov	r8, #0

horizontal:	
	add	r1, #1
	bl	DrawPixel16bpp
	add	r7, #1
	cmp	r7, r5 
	blo	horizontal
	b 	vertical
inc:
	add	r2, #1
	sub	r1, r5
	b 	horizontal
vertical:
	add	r8, #1
	cmp	r8, r4
	mov	r7, #0
	blo	inc
end:
	pop	{r4, r5, r7, r8, lr}
	mov	pc, lr

// void drawLine( fameBuffr, x, y, length, direction)
// r0 = fameBuffer
// r1 = x
// r2 = y
// r3 = colour
// r4 = length
// r5 = directon: 0-Horizonal   1 - vertical


// *** ONLY DRAWS LINE TO THE RIGHT AND DOWN ***  

///////////////////////////////////////////////////
.globl drawLine
drawLine:

	push	{r4, r5, r6, lr}
	mov	r6, #0		// loop conrol
	cmp	r5, #0		// Check to see if direction is vertical or horizontal 0 = horizontal  1 = vertical
	beq	horizontalLine

verticalLine:
	cmp	r6, r4
	beq	endDrawLine

	bl	DrawPixel16bpp
	add	r2, #1
	add	r6, #1
	b	verticalLine

horizontalLine:
	cmp	r6, r4
	beq	endDrawLine

	bl	DrawPixel16bpp
	add	r1, #1
	add	r6, #1
	b	horizontalLine


endDrawLine:

	pop	{r4, r5, r6, lr}
	mov	pc, lr

///////////////////////////////////////////////////
.globl readSNES
readSNES:
	push {r4, r5, r6, r7,r8,  lr}

	mov	r0, #1		// sending a #1 request into CLOCK
	bl	clockWrite	// clockWrite(1)

	mov	r0, #1		// Sending a #1 request into the latch
	bl	latchWrite	// latchWrite(1)
	
	mov	r5, #12		// Sending 12micros into clock
	bl	clock		// clock(12)

	mov	r0, #0		// sending 0 request into latch
	bl	latchWrite	// latchWrite(0)
	
	mov	r6, #0		// r6 = pulseLoop control variable
	mov	r8, #0
pulseLoop:	
	
	mov	r5, #6		// wait 6micros
	bl	clock		// clock(6)

	mov	r0, #0		
	bl	clockWrite	// clockWrite(0)

	mov	r5, #6		// wait 6 micros
	bl	clock		// clock(6)

	bl	dataRead	// read data
	lsl	r8, #1
	orr	r8, r4
	
	mov	r0, #1		// clockWrite(1)
	bl	clockWrite

	add 	r6, #1		// r6++
	cmp	r6, #16		// if r6<16
	blo	pulseLoop
	
	ldr	r0, =buttons
	str	r8, [r0]
	pop {r4, r5, r6, r7,r8,  lr}
	mov	pc, lr

// this subroutine will fire the player bullet and maintain its path
.globl playerBullet
playerBullet:
	push	{r4-r12,lr}
	ldr	r12, =playerBulletStatus
	ldr	r11, [r12]
	cmp	r11, #1
	popeq	{r4-r12, lr}
	moveq	pc, lr

	ldr	r9, =playerBulletX
	ldr	r6, [r9]	// X Bullet
	ldr	r7, [r9,#4]	// Y Bullet
	
	

/////////// CLEARING THE OBJECT
	ldr	r4, =frameBufferPointer
	ldr	r0, [r4]
	mov	r1, r6
	mov	r2, r7		
	mov	r3, #0
	mov	r4, #5
	mov	r5, #5

	bl	drawRect
///////////

	ldr	r9, =playerBulletX
	ldr	r6, [r9]	// X Bullet
	cmp	r6, #500
	bgt	hitWall2
	// first wall
	ldr	r8, =wallFlag
	ldr	r8, [r8]
	cmp	r8, #1
	bne	noWallHit
	// first wall active
	cmp	r6, #170
	blt	noWallHit	
	ldr	r0, =wallWidth
	ldr	r0, [r0]	// wall width
	add	r8, r0, #170
	cmp	r6, r8
	bgt	noWallHit
	// Hitting the wall
	ldr	r0, [r9, #4]
	ldr	r1, =485
	cmp	r0, r1
	bgt	noWallHit
	// Decrease first wall HP
	ldr	r0, =wallHP
	ldr	r1, [r0]
	sub	r1, #10
	str	r1, [r0]
	// reset the bullet flag	
	ldr	r0, =playerBulletStatus
	mov	r1, #1
	str	r1, [r0]
	
	// Reset Bullet
	ldr	r9, =playerBulletX
	mov	r0, #0
	str	r0, [r9]
	str	r0, [r9,#4]
	/////////////CLEARING THE Bullet
	ldr	r4, =frameBufferPointer
	ldr	r0, [r4]
	ldr	r1, [r9]
	ldr	r2, [r9, #4]	
	mov	r3, #0
	mov	r4, #5
	mov	r5, #5

	bl	drawRect
	//////////////
	pop	{r4-r12, lr}
	mov	pc, lr


hitWall2:// second wall
	ldr	r9, =playerBulletX
	ldr	r6, [r9]	// X Bullet
	// second wall
	ldr	r8, =wallFlag
	ldr	r8, [r8, #4]
	cmp	r8, #1
	bne	noWallHit
	// first wall active
	ldr	r0, =770
	cmp	r6, r0
	blt	noWallHit	
	ldr	r0, =wallWidth
	ldr	r0, [r0, #4]	// wall width
	ldr	r1, =770
	add	r8, r0, r1
	cmp	r6, r8
	bgt	noWallHit
	// Hitting the wall
	ldr	r0, [r9, #4]
	ldr	r1, =485
	cmp	r0, r1
	bgt	noWallHit
	// Subtract HP from second wall
	ldr	r0, =wallHP
	ldr	r1, [r0, #4]
	sub	r1, #10
	str	r1, [r0, #4]
	// reset the bulle t flag	
	ldr	r0, =playerBulletStatus
	mov	r1, #1
	str	r1, [r0]
	
	// Reset Bullet
	ldr	r9, =playerBulletX
	mov	r0, #0
	str	r0, [r9]
	str	r0, [r9,#4]
	/////////// CLEARING THE Bullet
	ldr	r4, =frameBufferPointer
	ldr	r0, [r4]
	ldr	r1, [r9]
	ldr	r2, [r9, #4]	
	mov	r3, #0
	mov	r4, #5
	mov	r5, #5

	bl	drawRect
	////////////
	pop	{r4-r12, lr}
	mov	pc, lr

noWallHit:


	sub	r7, #5
	cmp	r7, #15
	mov	r0, #1
	strlt	r0, [r12]
	ldrlt	r0, =playerBulletX
	movlt	r1, #0
	strlt	r1, [r0]
	strlt	r1, [r0,#4]
	poplt	{r4-r12, lr}
	movlt	pc, lr

	ldr	r4, =frameBufferPointer
	ldr	r0, [r4]
	mov	r1, r6	
	mov	r2, r7
	mov	r4, #5
	mov	r5, #5
	ldr	r3, =0x0066FF
	bl	drawRect

	str	r7, [r9,#4]
	pop	{r4-r12, lr}
	mov	pc, lr

///////////////////////////////////////////////////
// Stores the initial bullet X and Y value into memory
.globl aPressed
aPressed:
	push	{r11,r12, lr}
	
	ldr	r0, =playerX
	ldr	r1, [r0]	// X player
	ldr	r2, [r0,#4]	// Y player
	
	ldr	r0, =playerBulletX
	add	r1, #25
	sub	r2, #6
	str	r1, [r0]
	str	r2, [r0, #4]

	ldr	r12, =playerBulletStatus
	mov	r11, #0
	str	r11,[r12]

	pop	{r11,r12, lr}
	mov	pc, lr

// this subroutine will move the pawns to the right
.globl movePawnRight
movePawnRight:
	push	{r4,r5,r6,r7,r8,r9,r10,r12,lr}
	ldr	r9, =AIFlag
	ldr	r8, =AIControl
	ldr	r7, [r8]
	ldr	r8, =1520
	cmp	r7, r8
	moveq	r7, #1
	streq	r7, [r9]
	ldr	r8, =AIControl
	ldr	r7, [r8]
	ldr	r8, =1480
	cmp	r7, r8
	moveq	r7, #0
	streq	r7, [r9]
	ldr	r8, =AI
	ldr	r6, =frameBufferPointer
	mov	r7, #0	// loop control
pawnRightLoop:
	// CLEAR	
	ldr	r0, [r6]	
	ldr	r1, [r8]	
	mov	r2, #100
	ldr	r3, =0
	mov	r4, #20
	mov	r5, #20
	bl	drawRect

	ldr	r4, [r8]
	cmp	r4, #2000
	beq	pawnRightLoopBottom
	// Draw
	ldr	r0, [r6]	
	ldr	r1, [r8]
	ldr	r9, =AIFlag
	ldr	r9, [r9]
	cmp	r9, #0
	addeq	r1, #5		// move 5 to the right
	subne	r1, #5		// move 5 to the left
	str	r1, [r8]	
	mov	r2, #100
	ldr	r3, =0x03E0
	mov	r4, #20
	mov	r5, #20
	cmp	r7, #5
	beq	pawnRightLoopBottom
	bl	drawRect
pawnRightLoopBottom:
	add	r8, #8
	add	r7, #1
	cmp	r7, #6
	blt	pawnRightLoop
	
	pop	{r4,r5,r6,r7,r8,r9,r10,r12,lr}
	mov	pc, lr




.globl haltLoop$
haltLoop$:
	b		haltLoop$

	



.section .data

.align 4
font:		.incbin	"font.bin"

.globl FrameBufferInit
FrameBufferInit:
	.int	1024		// X Resolution (width)
	.int	768			// Y Resolution (height)
	.int	1024		// Virtual Width
	.int	768			// Virtual Height
	.int	0			// Pitch (Set by GPU)
	.int	16			// Depth (bits per pixel)
	.int	0			// Virtual X Offset
	.int	0			// Virtual Y Offset
	.int	0			// Pointer to FrameBuffer (Set by GPU)
	.int	0			// Size of FrameBuffer (Set by GPU)

.align 4
.globl	buttons
buttons:	.int 0

.globl frameBufferPointer
frameBufferPointer:	.int 0

.globl	winFlag
winFlag:
	.int 0

.globl menuFlag
menuFlag:
	.int	3	// 3 = continue		2 = restart	1 = quit
// Array containing the x and y cords of shapes
.globl playerX
playerX:	.int 0
		.int 0 // Y
.globl playerBulletX	
playerBulletX:	.int 0
		.int 0 // Y
.globl playerBulletStatus
playerBulletStatus:
		.int 1 // 1 or 0
.globl AIFlag
AIFlag:
		.int 0	// flag which is used to control the AI left/right movement
.globl AI
AI:
	.int	50	// 1st AI X
	.int	150	// 2nd AI x
	.int	250	// 3rd AI X
	.int	350	// 4th AI x
	.int	450
	.int	550
	.int	650
	.int	750
	.int	850
	.int	950
.globl AIControl
AIControl:	.int 	1500
.globl AIKnights
AIKnights:
	.int	100	// X values
	.int	300
	.int	500
	.int	700
	.int	900
.globl AIQueens
AIQueens:
	.int	200	// X Values
	.int	800
.globl AIBulletX
AIBulletX:
	.int	160	// 2nd   "	
	.int	360	
	.int	560
	.int	760
	.int	960
.globl AIBulletY
AIBulletY:
	.int	120	// 1st AIBullet Y
	.int	120	// 2nd   "
	.int	120	
	.int	120	
	.int	120
.globl AIBulletKnightX
AIBulletKnightX:
	.int	110
	.int	310
	.int	510
	.int	710
	.int	910
.globl AIBulletKnightY
AIBulletKnightY:
	.int	80
	.int	80
	.int	80
	.int	80
	.int	80
.globl AIBulletQueenX
AIBulletQueenX:
	.int	210
	.int	810
.globl AIBulletQueenY
AIBulletQueenY:
	.int	50
	.int	50	
.globl aiSpeed
aiSpeed:	.int 5
.globl AIBulletFlag
AIBulletFlag:	.int 0
.globl AIBulletFlag2
AIBulletFlag2:	.int 0
.globl AIBulletFlag3
AIBulletFlag3:	.int 0
.globl knightPoints
knightPoints:
	.int	30
	.int	30
	.int	30
	.int	30
	.int	30
.globl queenPoints
queenPoints:
	.int	100
	.int	100
.globl playerPoints
playerPoints:
	.int	50
.globl playerFlag
playerFlag:
	.int 	1	// 1 = player not dead, 0 = player dead
.globl wallWidth	
wallWidth:
	.int	100
	.int	100

.globl wallX
wallX:
	.int	170
	.int	770
.globl wallFlag	
wallFlag:
	.int	1
	.int	1
.globl wallHP
wallHP:
	.int	400
	.int 	400

.globl	PLAYER_SCORE
PLAYER_SCORE:
	.int	49	// ascii code for 5
	.int	48
	.int	48
// ASCII Code for our names, font.bin doesnt seem to like it?
.globl NAME
NAME:
	.int 66 
	.int 121 
	.int 58 
	.int 32 
	.int 83 
	.int 104
	.int 97 
	.int 104 
	.int 97 
	.int 98 
	.int 32 
	.int 83 
	.int 101 
	.int 121 
	.int 101 
	.int 100 
	.int 105 
	.int 32 
	.int 38 
	.int 32 
	.int 83 
	.int 108 
	.int 97 
	.int 118 
	.int 105 
	.int 32 
	.int 80 
	.int 97 
	.int 115 
	.int 107 
	.int 101 
	.int 108 
	.int 101 
	.int 118
// ASCII for continue	
.globl CONTINUE
CONTINUE:
	.int 67 
	.int 79 
	.int 78 
	.int 84 
	.int 73 
	.int 78 
	.int 85 
	.int 69
// ASCII restart
.globl RESTART
RESTART:
	.int 82 
	.int 69 
	.int 83 
	.int 84 
	.int 65 
	.int 82 
	.int 84
// ASCII quit
.globl QUIT
QUIT:
	.int 81 
	.int 85 
	.int 73 
	.int 84
// ASCII end message
.globl endMessage
endMessage:
	.int 84 
	.int 72 
	.int 65 
	.int 78 
	.int 75 
	.int 83 
	.int 32 
	.int 70 
	.int 79 
	.int 82 
	.int 32 
	.int 80 
	.int 76 
	.int 65 
	.int 89 
	.int 73 
	.int 78 
	.int 71
// ASCII of win message
.globl	won
won:
	.int 89 
	.int 79 	
	.int 85 
	.int 32 
	.int 87 
	.int 79 
	.int 78 
	.int 33

.globl gameName
gameName:
	.int 124
	.int 124
	.int 83 
	.int 113 
	.int 117 
	.int 97 
	.int 114 
	.int 101 
	.int 32 
	.int 81
	.int 117 
	.int 101 
	.int 115 
	.int 116
	.int 124
	.int 124
	.int 32 
	.int 32 
	.int 86 
	.int 49 
	.int 46 
	.int 48

.globl SCORE
SCORE:	
	.asciz	"Score: "

.globl GAMEOVER
GAMEOVER:	
	.asciz	"Game Over"












