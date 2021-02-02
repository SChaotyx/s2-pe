; ---------------------------------------------------------------------------
; Object DF - missile that Buzz	Bomber throws
; ---------------------------------------------------------------------------

ObjDF:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Msl_Index(pc,d0.w),d1
		jmp	Msl_Index(pc,d1.w)
; ===========================================================================
Msl_Index:	dc.w Msl_Main-Msl_Index
		dc.w Msl_Animate-Msl_Index
		dc.w Msl_FromBuzz-Msl_Index
		dc.w Msl_Delete-Msl_Index
		dc.w Msl_FromNewt-Msl_Index

msl_parent = $3C
; ===========================================================================

Msl_Main:	; Routine 0
		subq.w	#1,$32(a0)
		bpl.s	Msl_ChkCancel
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Missile,obMap(a0)
		move.w	#ArtTile_ArtNem_BuzzBomber,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#8,obActWid(a0)
		andi.b	#3,obStatus(a0)
		tst.b	obSubtype(a0)	; was object created by	a Newtron?
		beq.s	Msl_Animate	; if not, branch

		move.b	#8,obRoutine(a0) ; run "Msl_FromNewt" routine
		move.b	#$87,obColType(a0)
		move.b	#1,obAnim(a0)
		bra.w	Msl_Animate2
; ===========================================================================

Msl_Animate:	; Routine 2
		bsr.s	Msl_ChkCancel
		lea	(Ani_Missile).l,a1
		jsr	AnimateSprite
		jmp	DisplaySprite

; ---------------------------------------------------------------------------
; Subroutine to	check if the Buzz Bomber which fired the missile has been
; destroyed, and if it has, then cancel	the missile
; ---------------------------------------------------------------------------
; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Msl_ChkCancel:
		movea.l	msl_parent(a0),a1
		cmpi.b	#ObjID_Explosion,0(a1) ; has Buzz Bomber been destroyed?
		beq.s	Msl_Delete	; if yes, branch
		rts	
; End of function Msl_ChkCancel

; ===========================================================================

Msl_FromBuzz:	; Routine 4
		move.b	#$87,obColType(a0)
		move.b	#1,obAnim(a0)
		jsr	SpeedToPos
		lea	(Ani_Missile).l,a1
		jsr	AnimateSprite
		jsr	DisplaySprite
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0	; has object moved below the level boundary?
		bcs.s	Msl_Delete	; if yes, branch
		rts	
; ===========================================================================

Msl_Delete:	; Routine 6
		jsr	DeleteObject
		rts	
; ===========================================================================

Msl_FromNewt:	; Routine 8
		tst.b	obRender(a0)
		bpl.s	Msl_Delete
		jsr	SpeedToPos

Msl_Animate2:
		lea	(Ani_Missile).l,a1
		jsr	AnimateSprite
		jsr	DisplaySprite
		rts	

Map_Missile:	BINCLUDE	"mappings/sprite/objDF_buzz_bomber_missile.bin"
; ---------------------------------------------------------------------------
; Animation script - missile that Buzz Bomber throws
; ---------------------------------------------------------------------------
Ani_Missile:	dc.w animslflare-Ani_Missile
		dc.w animslmissile-Ani_Missile
animslflare:		dc.b 7,	0, 1, afRoutine
animslmissile:	dc.b 1,	2, 3, afEnd
		even
