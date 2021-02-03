; ---------------------------------------------------------------------------
; Object D1 - waterfall	sound effect (GHZ)
; ---------------------------------------------------------------------------

ObjD1:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	WSnd_Index(pc,d0.w),d1
		jmp	WSnd_Index(pc,d1.w)
; ===========================================================================
WSnd_Index:	dc.w WSnd_Main-WSnd_Index
		dc.w WSnd_PlaySnd-WSnd_Index
; ===========================================================================

WSnd_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.b	#4,obRender(a0)

WSnd_PlaySnd:	; Routine 2
        move.b	(Timer_frames+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	+
        move.w	#SndID_OilSlide,d0
	    jsr	(PlaySound).l
+
        move.w	obX(a0),d0	; get object position
		andi.w	#$FF80,d0	; round down to nearest $80
		move.w	(v_screenposx).w,d1 ; get screen position
		subi.w	#128,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0		; approx distance between object and screen
		cmpi.w	#128+320+192,d0
		bhi.s	WSnd_ChkDel
		rts

WSnd_ChkDel:
        jmp	DeleteObject