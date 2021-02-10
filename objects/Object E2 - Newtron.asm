; ---------------------------------------------------------------------------
; Object E2 - Newtron enemy (GHZ)
; ---------------------------------------------------------------------------

ObjE2:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Newt_Index(pc,d0.w),d1
		jmp	Newt_Index(pc,d1.w)
; ===========================================================================
Newt_Index:	dc.w Newt_Main-Newt_Index
		dc.w Newt_Action-Newt_Index
		dc.w Newt_Delete-Newt_Index
; ===========================================================================

Newt_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Newt,obMap(a0)
		move.w	#ArtTile_ArtNem_Newtron,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#$14,obActWid(a0)
		move.b	#$10,obHeight(a0)
		move.b	#8,obWidth(a0)

Newt_Action:	; Routine 2
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	ObjE2_index(pc,d0.w),d1
		jsr	ObjE2_index(pc,d1.w)
		lea	(Ani_Newt).l,a1
		jsr	AnimateSprite
		jmp	RememberState
; ===========================================================================
ObjE2_index:		dc.w ObjE2_chkdistance-ObjE2_index
		dc.w ObjE2_type00-ObjE2_index
		dc.w ObjE2_matchfloor-ObjE2_index
		dc.w ObjE2_speed-ObjE2_index
		dc.w ObjE2_type01-ObjE2_index
; ===========================================================================

ObjE2_chkdistance:
		bset	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	ObjE2_sonicisright
		neg.w	d0
		bclr	#0,obStatus(a0)

	ObjE2_sonicisright:
		cmpi.w	#$80,d0		; is Sonic within $80 pixels of	the newtron?
		bcc.s	ObjE2_outofrange	; if not, branch
		addq.b	#2,ob2ndRout(a0) ; goto ObjE2_type00 next
		move.b	#1,obAnim(a0)
		tst.b	obSubtype(a0)	; check	object type
		beq.s	ObjE2_istype00	; if type is 00, branch

		move.w	#make_art_tile(ArtTile_ArtNem_Newtron,1,0),art_tile(a0)
		move.b	#8,ob2ndRout(a0) ; goto ObjE2_type01 next
		move.b	#4,obAnim(a0)	; use different	animation

	ObjE2_outofrange:
	ObjE2_istype00:
		rts	
; ===========================================================================

ObjE2_type00:
		cmpi.b	#4,obFrame(a0)	; has "appearing" animation finished?
		bcc.s	ObjE2_fall		; is yes, branch
		bset	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	ObjE2_sonicisright2
		bclr	#0,obStatus(a0)

	ObjE2_sonicisright2:
		rts	
; ===========================================================================

	ObjE2_fall:
		cmpi.b	#1,obFrame(a0)
		bne.s	ObjE2_loc_DE42
		move.b	#$C,obColType(a0)

	ObjE2_loc_DE42:
		jsr	ObjectFall
		jsr	ObjFloorDist
		tst.w	d1		; has newtron hit the floor?
		bpl.s	ObjE2_keepfalling	; if not, branch

		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)	; stop newtron falling
		addq.b	#2,ob2ndRout(a0)
		move.b	#2,obAnim(a0)
		btst	#5,obGfx(a0)
		beq.s	ObjE2_pppppppp
		addq.b	#1,obAnim(a0)

	ObjE2_pppppppp:
		move.b	#$D,obColType(a0)
		move.w	#$200,obVelX(a0) ; move newtron horizontally
		btst	#0,obStatus(a0)
		bne.s	ObjE2_keepfalling
		neg.w	obVelX(a0)

	ObjE2_keepfalling:
		rts	
; ===========================================================================

ObjE2_matchfloor:
		jsr	SpeedToPos
		jsr	ObjFloorDist
		cmpi.w	#-8,d1
		blt.s	ObjE2_nextroutine
		cmpi.w	#$C,d1
		bge.s	ObjE2_nextroutine
		add.w	d1,obY(a0)	; match	newtron's position with floor
		rts	
; ===========================================================================

	ObjE2_nextroutine:
		addq.b	#2,ob2ndRout(a0) ; goto ObjE2_speed next
		rts	
; ===========================================================================

ObjE2_speed:
		jsr	SpeedToPos
		rts	
; ===========================================================================

ObjE2_type01:
		cmpi.b	#1,obFrame(a0)
		bne.s	ObjE2_firemissile
		move.b	#$C,obColType(a0)

	ObjE2_firemissile:
		cmpi.b	#2,obFrame(a0)
		bne.s	ObjE2_fail
		tst.b	$32(a0)
		bne.s	ObjE2_fail
		move.b	#1,$32(a0)
		jsr	FindFreeObj
		bne.s	ObjE2_fail
		move.b	#ObjID_Buzzmissile,0(a1) ; load missile object
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		subq.w	#8,obY(a1)
		move.w	#$200,obVelX(a1)
		move.w	#$14,d0
		btst	#0,obStatus(a0)
		bne.s	ObjE2_noflip
		neg.w	d0
		neg.w	obVelX(a1)

	ObjE2_noflip:
		add.w	d0,obX(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#1,obSubtype(a1)

	ObjE2_fail:
		rts	
; ===========================================================================

Newt_Delete:	; Routine 4
		jmp	DeleteObject

; ---------------------------------------------------------------------------
; Sprite Mappings
; ---------------------------------------------------------------------------
Map_Newt:	BINCLUDE	"mappings/sprite/objE2_newtron.bin"

; ---------------------------------------------------------------------------
; Animation script - Newtron enemy
; ---------------------------------------------------------------------------
Ani_Newt:	dc.w A_Newt_Blank-Ani_Newt
		dc.w A_Newt_Drop-Ani_Newt
		dc.w A_Newt_Fly1-Ani_Newt
		dc.w A_Newt_Fly2-Ani_Newt
		dc.w A_Newt_Fires-Ani_Newt
A_Newt_Blank:	dc.b $F, $A, afEnd
		even
A_Newt_Drop:	dc.b $13, 0, 1,	3, 4, 5, afBack, 1
A_Newt_Fly1:	dc.b 2,	6, 7, afEnd
A_Newt_Fly2:	dc.b 2,	8, 9, afEnd
A_Newt_Fires:	dc.b $13, 0, 1,	1, 2, 1, 1, 0, afRoutine
		even
