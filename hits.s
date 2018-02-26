/*

	Name: Shahab Seyedi, Slavi Paskelev

*/
// checks to see if the pawns, knights, queens hit player
.globl	checkHits
checkHits:
	push	{r4-r6,lr}
	
	mov	r6, #0	// loop control
	ldr	r2, =AI
checkPawnLoop:
	cmp	r6, #10
	beq	pawnLoopEnd
	ldr	r0, =playerBulletX
	ldr	r0, [r0]	// player bullet X
	ldr	r1, =playerBulletX
	ldr	r1, [r1,#4]	// player bullet Y	
	ldr	r3, [r2],#4	// AI X
	cmp	r1, #120
	addgt	r6, #1
	bgt	checkPawnLoop	// if ( bulletY <= 140)
	cmp	r0, r3
	addls	r6, #1
	bls	checkPawnLoop	// if (bulletX < pawnX)
	add	r3, #20
	cmp	r0, r3
	addgt	r6, #1
	bgt	checkPawnLoop	// if (bulletX > pawnX+20
	// We have a hit
	mov	r6, r6, lsl #2	// offset
	
	ldr	r2, =winFlag
	ldr	r0, [r2]
	add	r0, #1
	str	r0, [r2]
	// Increase player points
	ldr	r2, =playerPoints
	ldr	r0, [r2]
	add	r0, #10

	str	r0, [r2]
	// CLEAR
	ldr	r2, =AI
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	add	r2, r6
	ldr	r1, [r2]
	mov	r2, #100
	ldr	r3, =0
	mov	r4, #20
	mov	r5, #20
	bl	drawRect

	// reset the memory location
	ldr	r0, =AI
	ldr	r1, =2000
	str	r1, [r0, r6]	
	
pawnLoopEnd:
	mov	r6, #0	// loop control
	ldr	r2, =AIKnights
checkKnightLoop:
	cmp	r6, #5
	beq	knightLoopEnd
	ldr	r0, =playerBulletX
	ldr	r0, [r0]	// player bullet X
	ldr	r1, =playerBulletX
	ldr	r1, [r1,#4]	// player bullet Y	
	ldr	r3, [r2],#4	// AI X
	cmp	r1, #85
	addgt	r6, #1
	bgt	checkKnightLoop	// if ( bulletY <= 140)
	cmp	r0, r3
	addls	r6, #1
	bls	checkKnightLoop	// if (bulletX < pawnX)
	add	r3, #20
	cmp	r0, r3
	addgt	r6, #1
	bgt	checkKnightLoop	// if (bulletX > pawnX+20

	// We have a hit
	mov	r6, r6, lsl #2	// offset

	// Clearing bullet
	ldr	r0, =playerBulletX
	ldr	r1, [r0]	// player bullet X
	ldr	r2, [r0,#4]	// player bullet Y
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r3, =0
	mov	r4, #5
	mov	r5, #5
	bl	drawRect

	// Resetting Bullet
	ldr	r0, =playerBulletX 
	ldr	r3, =playerX
	ldr	r4, [r3]	//X of player
	ldr	r3, [r3, #4]	//Y of player
	add	r4, #25
	str	r4, [r0]
	str	r3, [r0, #4]
	
	ldr	r0, =playerBulletStatus
	mov	r1, #1
	str	r1, [r0]	
	
	// Decrease knight points
	ldr	r2, =knightPoints
	ldr	r0, [r2, r6]
	sub	r0, #10
	str	r0, [r2, r6]
	cmp	r0, #0
	bne	knightLoopEnd

	// Increase player points
	ldr	r2, =playerPoints
	ldr	r0, [r2]
	add	r0, #50
	str	r0, [r2]

	// CLEAR
	ldr	r2, =AIKnights
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	add	r2, r6
	ldr	r1, [r2]
	mov	r2, #60
	ldr	r3, =0
	mov	r4, #20
	mov	r5, #20
	bl	drawRect
	// inc win flag
	ldr	r2, =winFlag
	ldr	r0, [r2]
	add	r0, #1
	str	r0, [r2]

	// reset the memory location

	ldr	r0, =AIKnights
	ldr	r1, =2000
	str	r1, [r0, r6]
	
knightLoopEnd:
	mov	r6, #0	// loop control
	ldr	r2, =AIQueens
checkQueenLoop:
	cmp	r6, #2
	beq	queenLoopEnd
	ldr	r0, =playerBulletX
	ldr	r0, [r0]	// player bullet X
	ldr	r1, =playerBulletX
	ldr	r1, [r1,#4]	// player bullet Y	
	ldr	r3, [r2],#4	// AI X
	cmp	r1, #55
	addgt	r6, #1
	bgt	checkQueenLoop	// if ( bulletY <= 140)
	cmp	r0, r3
	addls	r6, #1
	bls	checkQueenLoop	// if (bulletX < pawnX)
	add	r3, #20
	cmp	r0, r3
	addgt	r6, #1
	bgt	checkQueenLoop	// if (bulletX > pawnX+20

	// We have a hit
	mov	r6, r6, lsl #2	// offset

	// Clearing bullet
	ldr	r0, =playerBulletX
	ldr	r1, [r0]	// player bullet X
	ldr	r2, [r0,#4]	// player bullet Y
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	ldr	r3, =0
	mov	r4, #5
	mov	r5, #5
	bl	drawRect

	// Resetting Bullet
	ldr	r0, =playerBulletX 
	ldr	r3, =playerX
	ldr	r4, [r3]	//X of player
	ldr	r3, [r3, #4]	//Y of player
	add	r4, #25
	str	r4, [r0]
	str	r3, [r0, #4]
	
	ldr	r0, =playerBulletStatus
	mov	r1, #1
	str	r1, [r0]	

	
	// Decrease queen points
	ldr	r2, =queenPoints

	ldr	r0, [r2, r6]
	sub	r0, #10
	str	r0, [r2, r6]
	cmp	r0, #0
	bne	queenLoopEnd

		// Increase player points
	ldr	r2, =playerPoints
	ldr	r0, [r2]
	add	r0, #100
	str	r0, [r2]

	// CLEAR
	ldr	r2, =AIQueens
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	add	r2, r6
	ldr	r1, [r2]
	mov	r2, #30
	ldr	r3, =0
	mov	r4, #20
	mov	r5, #20
	bl	drawRect
	// inc win flag
	ldr	r2, =winFlag
	ldr	r0, [r2]
	add	r0, #1
	str	r0, [r2]
	// reset the memory location
	ldr	r0, =AIQueens
	ldr	r1, =2000
	str	r1, [r0, r6]	
queenLoopEnd:

	pop	{r4-r6,lr}
	mov	pc, lr

///////////////////////////////////////////////////
// this routine checks to see if the player has hit the AIs
.globl	checkHitsPlayer
checkHitsPlayer:
	push	{r4-r11,lr}
	ldr	r0, =playerX
	ldr	r1, [r0]	// player X
	ldr	r2, [r0, #4]	// player Y
	sub	r2, #5
	ldr	r3, =AIBulletX
	ldr	r4, =AIBulletY
	mov	r5, #0	// loop control
pawnHitsPlayer:	// check for pawn hits
	cmp	r5, #5
	beq	pawnHitsEnd
	ldr	r6, [r3],#4
	ldr	r7, [r4], #4
	cmp	r7, r2
	addlt	r5, #1
	blt	pawnHitsPlayer
	add	r8, r2, #50
	cmp	r7, r8
	addgt	r5, #1
	bgt	pawnHitsPlayer
	cmp	r6, r1
	addlt	r5, #1
	blt	pawnHitsPlayer
	add	r8, r1, #50
	cmp	r6, r8
	addgt	r5, #1
	bgt	pawnHitsPlayer
	// A HIT
	mov	r9, r5	// save the value
	mov	r8, r5, lsl #2	// offset of bullet hit
	ldr	r3, =AIBulletX
	ldr	r4, =AIBulletY

	// clear the bullet
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	add	r3, r8
	ldr	r1, [r3]
	add	r4, r8
	ldr	r2, [r4]
	ldr	r3, =0
	mov	r4, #5
	mov	r5, #5
	bl	drawRect
	// RESET BULLET X Y
	
	mov	r5, r9, lsl #3
	ldr	r0, =AI
	add	r0, #4
	ldr	r1, [r0,r5]	// Pawn's X value
	add	r1, #10
	ldr	r0, =AIBulletX
	mov	r9, r9, lsl #2
	str	r1, [r0,r9]	// set X value
	mov	r1, #120
	ldr	r0, =AIBulletY
	str	r1, [r0, r9]
	

	ldr	r0, =playerPoints
	ldr	r1, [r0]
	sub	r1, #10
	str	r1, [r0]


	
	
pawnHitsEnd:
	ldr	r0, =playerX
	ldr	r1, [r0]	// player X
	ldr	r2, [r0, #4]	// player Y
	sub	r2, #5
	ldr	r3, =AIBulletKnightX
	ldr	r4, =AIBulletKnightY
	mov	r5, #0	// loop control
knightHitsPlayer:	// check for pawn hits
	cmp	r5, #5
	beq	knightHitsEnd
	ldr	r6, [r3],#4
	ldr	r7, [r4], #4
	cmp	r7, r2
	addlt	r5, #1
	blt	knightHitsPlayer
	add	r8, r2, #50
	cmp	r7, r8
	addgt	r5, #1
	bgt	knightHitsPlayer
	cmp	r6, r1
	addlt	r5, #1
	blt	knightHitsPlayer
	add	r8, r1, #50
	cmp	r6, r8
	addgt	r5, #1
	bgt	knightHitsPlayer
	// A HIT
	mov	r9, r5	// save the value
	mov	r8, r5, lsl #2	// offset of bullet hit
	ldr	r3, =AIBulletKnightX
	ldr	r4, =AIBulletKnightY

	// clear the bullet
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	add	r3, r8
	ldr	r1, [r3]
	add	r4, r8
	ldr	r2, [r4]
	ldr	r3, =0
	mov	r4, #5
	mov	r5, #5
	bl	drawRect
	// RESET BULLET X Y
	
	mov	r5, r9, lsl #2
	ldr	r0, =AIKnights
	ldr	r1, [r0,r5]	// Pawn's X value
	add	r1, #10
	ldr	r0, =AIBulletKnightX
	mov	r9, r9, lsl #2
	str	r1, [r0,r9]	// set X value
	mov	r1, #80
	ldr	r0, =AIBulletKnightY
	str	r1, [r0, r9]
	

	ldr	r0, =playerPoints
	ldr	r1, [r0]
	sub	r1, #10
	str	r1, [r0]
knightHitsEnd:

	ldr	r0, =playerX
	ldr	r1, [r0]	// player X
	ldr	r2, [r0, #4]	// player Y
	sub	r2, #5
	ldr	r3, =AIBulletQueenX
	ldr	r4, =AIBulletQueenY
	mov	r5, #0	// loop control
queenHitsPlayer:	// check for pawn hits
	cmp	r5, #2
	beq	queenHitsEnd
	ldr	r6, [r3],#4
	ldr	r7, [r4], #4
	cmp	r7, r2
	addlt	r5, #1
	blt	queenHitsPlayer
	add	r8, r2, #50
	cmp	r7, r8
	addgt	r5, #1
	bgt	queenHitsPlayer
	cmp	r6, r1
	addlt	r5, #1
	blt	queenHitsPlayer
	add	r8, r1, #50
	cmp	r6, r8
	addgt	r5, #1
	bgt	queenHitsPlayer
	// A HIT
	mov	r9, r5	// save the value
	mov	r8, r5, lsl #2	// offset of bullet hit
	ldr	r3, =AIBulletQueenX
	ldr	r4, =AIBulletQueenY

	// clear the bullet
	ldr	r0, =frameBufferPointer
	ldr	r0, [r0]
	add	r3, r8
	ldr	r1, [r3]
	add	r4, r8
	ldr	r2, [r4]
	ldr	r3, =0
	mov	r4, #5
	mov	r5, #5
	bl	drawRect
	// RESET BULLET X Y
	
	mov	r5, r9, lsl #2
	ldr	r0, =AIQueens
	ldr	r1, [r0,r5]	// Pawn's X value
	add	r1, #10
	ldr	r0, =AIBulletQueenX
	mov	r9, r9, lsl #2
	str	r1, [r0,r9]	// set X value
	mov	r1, #50
	ldr	r0, =AIBulletQueenY
	str	r1, [r0, r9]
	

	ldr	r0, =playerPoints
	ldr	r1, [r0]
	sub	r1, #10
	str	r1, [r0]
queenHitsEnd:
	pop	{r4-r11,lr}
	mov	pc, lr
    
///////////////////////////////////////////////////

.globl	playerHP // sets playerFlag to 0 if the player is dead
playerHP:
	push	{lr}
	ldr	r0, =playerPoints
	ldr	r0, [r0]
	cmp	r0, #0
	bne	playerHPEnd
	ldr	r0, =playerFlag
	mov	r1, #0
	str	r1, [r0]

playerHPEnd:
	pop	{lr}
	mov	pc, lr
