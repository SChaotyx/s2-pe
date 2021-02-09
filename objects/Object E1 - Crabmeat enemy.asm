; ---------------------------------------------------------------------------
; Object E1 - Crabmeat enemy (GHZ, SYZ)
; ---------------------------------------------------------------------------

ObjE1:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Crab_Index(pc,d0.w),d1
		jmp	Crab_Index(pc,d1.w)
; ===========================================================================
Crab_Index:
ptr_Crab_Main:		dc.w Crab_Main-Crab_Index
ptr_Crab_Action:	dc.w Crab_Action-Crab_Index
ptr_Crab_Delete:	dc.w Crab_Delete-Crab_Index
ptr_Crab_BallMain:	dc.w Crab_BallMain-Crab_Index
ptr_Crab_BallMove:	dc.w Crab_BallMove-Crab_Index

id_Crab_Main:		equ ptr_Crab_Main-Crab_Index	; 0
id_Crab_Action:		equ ptr_Crab_Action-Crab_Index	; 2
id_Crab_Delete:		equ ptr_Crab_Delete-Crab_Index	; 4
id_Crab_BallMain:	equ ptr_Crab_BallMain-Crab_Index	; 6
id_Crab_BallMove:	equ ptr_Crab_BallMove-Crab_Index	; 8

crab_timedelay = $30
crab_mode = $32
; ===========================================================================

Crab_Main:	; Routine 0
		move.b	#$10,obHeight(a0)
		move.b	#8,obWidth(a0)
		move.l	#Map_Crab,obMap(a0)
		move.w	#ArtTile_ArtNem_Crabmeat,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#6,obColType(a0)
		move.b	#$15,obActWid(a0)
		jsr	ObjectFall
		jsr	(ObjFloorDist).l	; find floor
		tst.w	d1
		bpl.s	ObjE1_floornotfound
		add.w	d1,obY(a0)
		move.b	d3,obAngle(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)

	ObjE1_floornotfound:
		rts	
; ===========================================================================

Crab_Action:	; Routine 2
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	ObjE1_index(pc,d0.w),d1
		jsr	ObjE1_index(pc,d1.w)
		lea	(Ani_Crab).l,a1
		jsr	AnimateSprite
		jmp MarkObjGone
; ===========================================================================
ObjE1_index:		dc.w ObjE1_waittofire-ObjE1_index
		dc.w ObjE1_walkonfloor-ObjE1_index
; ===========================================================================

ObjE1_waittofire:
		subq.w	#1,crab_timedelay(a0) ; subtract 1 from time delay
		bpl.s	ObjE1_dontmove
		tst.b	obRender(a0)
		bpl.s	ObjE1_movecrab
		bchg	#1,crab_mode(a0)
		bne.s	ObjE1_fire

	ObjE1_movecrab:
		addq.b	#2,ob2ndRout(a0)
		move.w	#127,crab_timedelay(a0) ; set time delay to approx 2 seconds
		move.w	#$80,obVelX(a0)	; move Crabmeat	to the right
		bsr.w	Crab_SetAni
		addq.b	#3,d0
		move.b	d0,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	ObjE1_noflip
		neg.w	obVelX(a0)	; change direction

	ObjE1_dontmove:
	ObjE1_noflip:
		rts	
; ===========================================================================

ObjE1_fire:
		move.w	#59,crab_timedelay(a0)
		move.b	#6,obAnim(a0)	; use firing animation
		jsr	FindFreeObj
		bne.s	ObjE1_failleft
		move.b	#ObjID_Crabmeat,0(a1) ; load left fireball
		move.b	#id_Crab_BallMain,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		subi.w	#$10,obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#-$100,obVelX(a1)

	ObjE1_failleft:
		jsr	FindFreeObj
		bne.s	ObjE1_failright
		move.b	#ObjID_Crabmeat,0(a1) ; load right fireball
		move.b	#id_Crab_BallMain,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		addi.w	#$10,obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#$100,obVelX(a1)

	ObjE1_failright:
		rts	
; ===========================================================================

ObjE1_walkonfloor:
		subq.w	#1,crab_timedelay(a0)
		bmi.s	loc_966E
		jsr	SpeedToPos
		bchg	#0,crab_mode(a0)
		bne.s	loc_9654
		move.w	obX(a0),d3
		addi.w	#$10,d3
		btst	#0,obStatus(a0)
		beq.s	loc_9640
		subi.w	#$20,d3

loc_9640:
		jsr	(ObjFloorDist2).l
		cmpi.w	#-8,d1
		blt.s	loc_966E
		cmpi.w	#$C,d1
		bge.s	loc_966E
		rts	
; ===========================================================================

loc_9654:
		jsr	(ObjFloorDist).l
		add.w	d1,obY(a0)
		move.b	d3,obAngle(a0)
		bsr.w	Crab_SetAni
		addq.b	#3,d0
		move.b	d0,obAnim(a0)
		rts	
; ===========================================================================

loc_966E:
		subq.b	#2,ob2ndRout(a0)
		move.w	#59,crab_timedelay(a0)
		move.w	#0,obVelX(a0)
		bsr.w	Crab_SetAni
		move.b	d0,obAnim(a0)
		rts	
; ---------------------------------------------------------------------------
; Subroutine to	set the	correct	animation for a	Crabmeat
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Crab_SetAni:
		moveq	#0,d0
		move.b	obAngle(a0),d3
		bmi.s	loc_96A4
		cmpi.b	#6,d3
		bcs.s	locret_96A2
		moveq	#1,d0
		btst	#0,obStatus(a0)
		bne.s	locret_96A2
		moveq	#2,d0

locret_96A2:
		rts	
; ===========================================================================

loc_96A4:
		cmpi.b	#-6,d3
		bhi.s	locret_96B6
		moveq	#2,d0
		btst	#0,obStatus(a0)
		bne.s	locret_96B6
		moveq	#1,d0

locret_96B6:
		rts	
; End of function Crab_SetAni

; ===========================================================================

Crab_Delete:	; Routine 4
		jsr	DeleteObject
		rts	
; ===========================================================================
; ---------------------------------------------------------------------------
; Sub-object - missile that the	Crabmeat throws
; ---------------------------------------------------------------------------

Crab_BallMain:	; Routine 6
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Crab,obMap(a0)
		move.w	#ArtTile_ArtNem_Crabmeat,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#$87,obColType(a0)
		move.b	#8,obActWid(a0)
		move.w	#-$400,obVelY(a0)
		move.b	#7,obAnim(a0)

Crab_BallMove:	; Routine 8
		lea	(Ani_Crab).l,a1
		jsr	AnimateSprite
		jsr	ObjectFall
		jsr	DisplaySprite
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0	; has object moved below the level boundary?
		bcs.s	ObjE1_delete		; if yes, branch
		rts	

	ObjE1_delete:
		jmp	DeleteObject

; ---------------------------------------------------------------------------
; Sprite Mappings
; ---------------------------------------------------------------------------
Map_Crab: BINCLUDE "mappings/sprite/objE1_crabmeat.bin"

; ---------------------------------------------------------------------------
; Animation script - Crabmeat enemy
; ---------------------------------------------------------------------------
Ani_Crab:	dc.w ObjE1Ani_stand-Ani_Crab, ObjE1Ani_standslope-Ani_Crab, ObjE1Ani_standsloperev-Ani_Crab
		dc.w ObjE1Ani_walk-Ani_Crab, ObjE1Ani_walkslope-Ani_Crab, ObjE1Ani_walksloperev-Ani_Crab
		dc.w ObjE1Ani_firing-Ani_Crab, ObjE1Ani_ball-Ani_Crab
ObjE1Ani_stand:		dc.b $F, 0, afEnd
		even
ObjE1Ani_standslope:	dc.b $F, 2, afEnd
		even
ObjE1Ani_standsloperev:	dc.b $F, 8, afEnd
		even
ObjE1Ani_walk:		dc.b $F, 1, 7, 0, afEnd
		even
ObjE1Ani_walkslope:	dc.b $F, 7, 3, 2, afEnd
		even
ObjE1Ani_walksloperev:	dc.b $F, 1, 9, 8, afEnd
		even
ObjE1Ani_firing:	dc.b $F, 4, afEnd
		even
ObjE1Ani_ball:		dc.b 1,	5, 6, afEnd
		even
