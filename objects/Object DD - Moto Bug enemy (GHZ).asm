; ---------------------------------------------------------------------------
; Object DD - Moto Bug enemy (GHZ)
; ---------------------------------------------------------------------------

ObjDD:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Moto_Index(pc,d0.w),d1
		jmp	Moto_Index(pc,d1.w)
; ===========================================================================
Moto_Index:	dc.w Moto_Main-Moto_Index
		dc.w Moto_Action-Moto_Index
		dc.w Moto_Animate-Moto_Index
		dc.w Moto_Delete-Moto_Index
; ===========================================================================

Moto_Main:	; Routine 0
		move.l	#Map_Moto,obMap(a0)
		move.w	#ArtTile_ArtNem_Motobug,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#$14,obActWid(a0)
		tst.b	obAnim(a0)	; is object a smoke trail?
		bne.s	smoke		; if yes, branch
		move.b	#$E,obHeight(a0)
		move.b	#8,obWidth(a0)
		move.b	#$C,obColType(a0)
		jsr	ObjectFall
		jsr	(ObjFloorDist).l
		tst.w	d1
		bpl.s	notonfloor
		add.w	d1,obY(a0)	; match	object's position with the floor
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0) ; goto Moto_Action next
		bchg	#0,obStatus(a0)

notonfloor:
		rts	

; ===========================================================================
smoke:
		addq.b	#4,obRoutine(a0) ; goto Moto_Animate next
		bra.w	Moto_Animate

; ===========================================================================

Moto_Action:	; Routine 2
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Moto_ActIndex(pc,d0.w),d1
		jsr	Moto_ActIndex(pc,d1.w)
		lea	(Ani_Moto).l,a1
		jsr	AnimateSprite
		jmp MarkObjGone
; ===========================================================================
Moto_ActIndex:	
		dc.w move-Moto_ActIndex
		dc.w findfloor-Moto_ActIndex

time = $30
smokedelay = $33
; ===========================================================================

move:
		subq.w	#1,time(a0)	; subtract 1 from mbpause	time
		bpl.s	mbwait		; if time remains, branch
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$100,obVelX(a0) ; move object to the left
		move.b	#1,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	mbwait
		neg.w	obVelX(a0)	; change direction

mbwait:
		rts	
; ===========================================================================

findfloor:
		jsr	SpeedToPos
		jsr	(ObjFloorDist).l
		cmpi.w	#-8,d1
		blt.s	mbpause
		cmpi.w	#$C,d1
		bge.s	mbpause
		add.w	d1,obY(a0)	; match	object's position with the floor
		subq.b	#1,smokedelay(a0)
		bpl.s	nosmoke
		move.b	#$F,smokedelay(a0)
		jsr	FindFreeObj
		bne.s	nosmoke
		move.b	#ObjID_Motobug,0(a1) ; load exhaust smoke object
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#2,obAnim(a1)

nosmoke:
		rts	

mbpause:
		subq.b	#2,ob2ndRout(a0)
		move.w	#59,time(a0)	; set mbpause time to 1 second
		move.w	#0,obVelX(a0)	; stop the object moving
		move.b	#0,obAnim(a0)
		rts	
; ===========================================================================

Moto_Animate:	; Routine 4
		lea	(Ani_Moto).l,a1
		jsr	AnimateSprite
		jmp	DisplaySprite
; ===========================================================================

Moto_Delete:	; Routine 6
		jmp	DeleteObject

; ---------------------------------------------------------------------------
; Sprite Mappings - Motobug enemy
; ---------------------------------------------------------------------------
Map_Moto:	BINCLUDE	"mappings\sprite\objDD_motobug.bin"

; ---------------------------------------------------------------------------
; Animation script - Motobug enemy
; ---------------------------------------------------------------------------
Ani_Moto:	dc.w stand-Ani_Moto
			dc.w walk-Ani_Moto
			dc.w anismoke-Ani_Moto

stand:		dc.b $F, 2, afEnd
		even
walk:		dc.b 7,	0, 1, 0, 2, afEnd
anismoke:		dc.b 1,	3, 6, 3, 6, 4, 6, 4, 6,	4, 6, 5, afRoutine
		even