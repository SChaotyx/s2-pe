; ---------------------------------------------------------------------------
; Object E0 - Chopper enemy (GHZ)
; ---------------------------------------------------------------------------

ObjE0:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Chop_Index(pc,d0.w),d1
		jsr	Chop_Index(pc,d1.w)
		jmp DisplaySprite
		rts
; ===========================================================================
Chop_Index:	dc.w Chop_Main-Chop_Index
		dc.w Chop_ChgSpeed-Chop_Index

chop_origY:	equ $30
; ===========================================================================

Chop_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Chop,obMap(a0)
		move.w	#ArtTile_ArtNem_Chopper,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#9,obColType(a0)
		move.b	#$10,obActWid(a0)
		move.w	#-$700,obVelY(a0) ; set vertical speed
		move.w	obY(a0),chop_origY(a0) ; save original position

Chop_ChgSpeed:	; Routine 2
		lea	(Ani_Chop).l,a1
		jsr	AnimateSprite
		jsr	SpeedToPos
		addi.w	#$18,obVelY(a0)	; reduce speed
		move.w	chop_origY(a0),d0
		cmp.w	obY(a0),d0	; has Chopper returned to its original position?
		bcc.s	ObjE0_chganimation	; if not, branch
		move.w	d0,obY(a0)
		move.w	#-$700,obVelY(a0) ; set vertical speed

	ObjE0_chganimation:
		move.b	#1,obAnim(a0)	; use fast animation
		subi.w	#$C0,d0
		cmp.w	obY(a0),d0
		bcc.s	ObjE0_nochg
		move.b	#0,obAnim(a0)	; use slow animation
		tst.w	obVelY(a0)	; is Chopper at	its highest point?
		bmi.s	ObjE0_nochg		; if not, branch
		move.b	#2,obAnim(a0)	; use stationary animation

	ObjE0_nochg:
		rts	
		
; ---------------------------------------------------------------------------
; Sprite Mappings
; ---------------------------------------------------------------------------
Map_Chop:	BINCLUDE	"mappings/sprite/objE0_chopper.bin"

; ---------------------------------------------------------------------------
; Animation script - Chopper enemy
; ---------------------------------------------------------------------------
Ani_Chop:	
		dc.w ObjE0Ani_slow-Ani_Chop
		dc.w ObjE0Ani_fast-Ani_Chop
		dc.w ObjE0Ani_still-Ani_Chop
ObjE0Ani_slow:		dc.b 7,	0, 1, afEnd
ObjE0Ani_fast:		dc.b 3,	0, 1, afEnd
ObjE0Ani_still:		dc.b 7,	0, afEnd
		even
