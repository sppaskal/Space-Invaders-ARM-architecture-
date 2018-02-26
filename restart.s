/*

	Name: Shahab Seyedi, Slavi Paskelev

*/

.section .text


.globl restartGame
restartGame:

	push	{lr}
	
	mov	r0, #0	// control Variable
	ldr	r1, =playerXR
	ldr	r3, =playerX
restartPlayerX:
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array
	blo	restartPlayerX

	mov	r0, #0	// control Variable
	ldr	r1, =playerBulletXR		//---------
	ldr	r3, =playerBulletX		//---------
restartPlayerBulletX:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartPlayerBulletX		//---------
	
	mov	r0, #0	// control Variable
	ldr	r1, =playerBulletStatusR		//---------
	ldr	r3, =playerBulletStatus		//---------
restartPlayerBulletStatus:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #1		// compare with length of the array	//---------
	blo	restartPlayerBulletStatus		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =AIFlagR		//---------
	ldr	r3, =AIFlag		//---------
restartAIFlag:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #1		// compare with length of the array	//---------
	blo	restartAIFlag		//---------

	mov	r0, #0	// control Variable
	ldr	r3, =AI		//---------
	ldr	r1, =AIR		//---------
restartAI:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #10		// compare with length of the array	//---------
	blo	restartAI		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =AIKnightsR		//---------
	ldr	r3, =AIKnights		//---------
restartAIKnights:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #5		// compare with length of the array	//---------
	blo	restartAIKnights		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =AIQueensR		//---------
	ldr	r3, =AIQueens		//---------
restartAIQueens:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartAIQueens		//---------

	mov	r0, #0	// control Variable
	ldr	r3, =AIBulletX		//---------
	ldr	r1, =AIBulletXR		//---------
restartAIBulletX:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #4		// compare with length of the array	//---------
	blo	restartAIBulletX		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =AIBulletYR		//---------
	ldr	r3, =AIBulletY		//---------
restartAIBulletY:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #4		// compare with length of the array	//---------
	blo	restartAIBulletY		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =AIBulletKnightXR		//---------
	ldr	r3, =AIBulletKnightX		//---------
restartAIBulletKnightX:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #5		// compare with length of the array	//---------
	blo	restartAIBulletKnightX		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =AIBulletKnightYR		//---------
	ldr	r3, =AIBulletKnightY		//---------
restartAIBulletKnightY:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #5		// compare with length of the array	//---------
	blo	restartAIBulletKnightY		//---------

	mov	r0, #0	// control Variable
	ldr	r3, =AIBulletQueenX		//---------
	ldr	r1, =AIBulletQueenXR		//---------
restartAIBulletQueenX:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartAIBulletQueenX		//---------

	
	mov	r0, #0	// control Variable
	ldr	r1, =AIBulletQueenYR		//---------
	ldr	r3, =AIBulletQueenY		//---------
restartAIBulletQueenY:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartAIBulletQueenY		//---------

	
	mov	r0, #0	// control Variable
	ldr	r3, =AIBulletFlag		//---------
	ldr	r1, =AIBulletFlagR		//---------
restartAIBulletFlag:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #3		// compare with length of the array	//---------
	blo	restartAIBulletFlag		//---------

	
	mov	r0, #0	// control Variable
	ldr	r3, =knightPoints		//---------
	ldr	r1, =knightPointsR		//---------
restartKnightPoints:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #5		// compare with length of the array	//---------
	blo	restartKnightPoints		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =queenPointsR		//---------
	ldr	r3, =queenPoints		//---------
restartQueenPoints:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartQueenPoints		//---------	

	mov	r0, #0	// control Variable
	ldr	r1, =playerPointsR		//---------
	ldr	r3, =playerPoints		//---------
restartPlayerPoints:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #1		// compare with length of the array	//---------
	blo	restartPlayerPoints		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =playerFlagR		//---------
	ldr	r3, =playerFlag		//---------
restartPlayerFlag:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #1		// compare with length of the array	//---------
	blo	restartPlayerFlag		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =wallWidthR		//---------
	ldr	r3, =wallWidth		//---------
restartWallWidth:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartWallWidth		//---------

	mov	r0, #0	// control Variable
	ldr	r1, =wallFlagR		//---------
	ldr	r3, =wallFlag		//---------
restartWallFlag:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartWallFlag		//---------

	mov	r0, #0	// control Variable
	ldr	r3, =wallHP		//---------
	ldr	r1, =wallHPR		//---------
restartWallHP:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartWallHP		//---------
	
	mov	r0, #0	// control Variable
	ldr	r3, =winFlag		//---------
	ldr	r1, =winFlagR		//---------
restartPlayerWon:				//---------
	
	ldr	r2, [r1], #4
	
	str	r2, [r3], #4

	add	r0, #1
	cmp	r0, #2		// compare with length of the array	//---------
	blo	restartPlayerWon		//---------
restartEnd:
	pop	{lr}
	mov	pc, lr


.section .data
.align 4
// Array containing the x and y cords of shapes
.globl playerXR
playerXR:	.int 0
		.int 0 // Y
.globl playerBulletXR	
playerBulletXR:	.int 0
		.int 0 // Y
.globl playerBulletStatusR
playerBulletStatusR:
		.int 1 // 1 or 0
.globl	winFlagR
winFlagR:
	.int 0
.globl AIFlagR
AIFlagR:
		.int 0	// flag which is used to control the AI left/right movement
.globl AIR
AIR:
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
.globl AIControlR
AIControlR:	.int 	1500
.globl AIKnightsR
AIKnightsR:
	.int	100	// X values
	.int	300
	.int	500
	.int	700
	.int	900
.globl AIQueensR
AIQueensR:
	.int	200	// X Values
	.int	800
.globl AIBulletXR
AIBulletXR:
	.int	160	// 2nd   "	
	.int	360	
	.int	560
	.int	760
	.int	960
.globl AIBulletYR
AIBulletYR:
	.int	120	// 1st AIBullet Y
	.int	120	// 2nd   "
	.int	120	
	.int	120	
	.int	120
.globl AIBulletKnightXR
AIBulletKnightXR:
	.int	110
	.int	310
	.int	510
	.int	710
	.int	910
.globl AIBulletKnightYR
AIBulletKnightYR:
	.int	80
	.int	80
	.int	80
	.int	80
	.int	80
.globl AIBulletQueenXR
AIBulletQueenXR:
	.int	210
	.int	810
.globl AIBulletQueenYR
AIBulletQueenYR:
	.int	50
	.int	50	
.globl aiSpeedR
aiSpeedR:	.int 5
.globl AIBulletFlagR
AIBulletFlagR:	.int 0
.globl AIBulletFlag2R
AIBulletFlag2R:	.int 0
.globl AIBulletFlag3R
AIBulletFlag3R:	.int 0
.globl knightPointsR
knightPointsR:
	.int	30
	.int	30
	.int	30
	.int	30
	.int	30
.globl queenPointsR
queenPointsR:
	.int	100
	.int	100
.globl playerPointsR
playerPointsR:
	.int	50
.globl playerFlagR
playerFlagR:
	.int 	1	// 1 = player not dead, 0 = player dead
.globl wallWidthR	
wallWidthR:
	.int	100
	.int	100

.globl wallXR
wallXR:
	.int	170
	.int	770
.globl wallFlagR	
wallFlagR:
	.int	1
	.int	1
.globl wallHPR
wallHPR:
	.int	400
	.int 	400
