; =============================================================================================
; Project Name:		ContScrn
; Created:		31st January 2021
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

ContScrn_Header:
;	Voice Pointer	location
	smpsHeaderVoice	ContScrn_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$04

;	DAC Pointer	location
	smpsHeaderDAC	ContScrn_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	ContScrn_FM1,	smpsPitch00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	ContScrn_FM2,	smpsPitch00,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	ContScrn_FM3,	smpsPitch00,	$10
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	ContScrn_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	ContScrn_FM5,	smpsPitch00+$01,	$04
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ContScrn_PSG1,	smpsPitch02lo,	$01,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ContScrn_PSG2,	smpsPitch02lo,	$02,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ContScrn_PSG3,	smpsPitch02hi+$0B,	$02,	$02
	dc.b		$05,	$6D,	$03,	$48,	$05,	nC5,	$00,	nC2
	dc.b		nFa,	smpsEE,	$00,	nF3,	$43
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		$75

; FM1 Data
ContScrn_FM1:
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nEb2,	$60,	nD2,	$60,	nG1,	$60,	smpsNoAttack,	$30
	dc.b		nG1,	$08,	nG2,	$0C,	nG1,	$04,	nBb1,	$08
	dc.b		nA1,	$04,	nG1,	$08,	nF1,	$04
ContScrn_Loop01:
;	Call At	 	location
	smpsCall	ContScrn_Call01
	dc.b		nRst,	$0C,	nG2,	nRst,	$08,	nC2,	$04,	nD2
	dc.b		$08,	nF2,	$04,	nG1,	$04,	nF1,	nG1,	nG2
	dc.b		$08,	nG1,	$04,	nRst,	$08,	nG2,	$04,	nRst
	dc.b		$0C,	nRst,	$18,	nRst,	$08,	nG1,	$04,	nG2
	dc.b		$08,	nF2,	$04
;	Call At	 	location
	smpsCall	ContScrn_Call01
	dc.b		nRst,	$0C,	nG2,	$08,	nRst,	$04,	nRst,	$08
	dc.b		nG2,	$0C,	$04,	nG1,	$08,	nG2,	$0C,	$04
	dc.b		nA1,	$08,	nA2,	$0C,	$04,	nBb1,	$08,	nBb2
	dc.b		$0C,	$04,	nC2,	$08,	nC3,	$0C,	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	ContScrn_Loop01
;	Jump To	 	location
	smpsJump	ContScrn_Loop01

ContScrn_Call01:
	dc.b		nEb2,	$04,	nD2,	nEb2,	nEb3,	$08,	nEb2,	$04
	dc.b		nRst,	$08,	nEb2,	$04,	nRst,	$0C,	nRst,	$0C
	dc.b		nEb2,	nRst,	$08,	nD2,	$04,	nEb2,	$08,	nF2
	dc.b		$04,	nD2,	$04,	nC2,	nD2,	nD3,	$08,	nD2
	dc.b		$04,	nRst,	$18,	nRst,	$0C,	nD2,	nRst,	$08
	dc.b		nC2,	$04,	nD2,	$08,	nF2,	$04,	nG1,	$04
	dc.b		nF1,	nG1,	nG2,	$08,	nG1,	$04,	nRst,	$08
	dc.b		nG2,	$04,	nRst,	$0C
	smpsReturn

; FM2 Data
ContScrn_FM2:
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Pitch	value
	smpsAlterPitch	$F9
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Alter Pitch	value
	smpsAlterPitch	$04
;	Call At	 	location
	smpsCall	ContScrn_Call03
;	Alter Pitch	value
	smpsAlterPitch	$FF
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call04
;	Alter Pitch	value
	smpsAlterPitch	$04
;	Set FM Voice	#
	smpsFMvoice	$02
ContScrn_Loop02:
;	Call At	 	location
	smpsCall	ContScrn_Call05
	dc.b		nRst,	$60
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	ContScrn_Loop02
;	Jump To	 	location
	smpsJump	ContScrn_Loop02

ContScrn_Call05:
	dc.b		nF4,	$0C,	nRst,	nG4,	nRst,	nA4,	$03,	smpsNoAttack
	dc.b		nBb4,	$11,	nG4,	$04,	nRst,	$0C,	nC5,	smpsNoAttack
	dc.b		$08,	nRst,	$04,	nC5,	$08,	nRst,	$04,	nC5
	dc.b		$08,	nRst,	$04,	nD5,	$08,	nRst,	$04,	nBb4
	dc.b		$03,	smpsNoAttack,	nC5,	$05,	nBb4,	$04,	nRst,	$08
	dc.b		nG4,	$1C,	nF4,	$0C,	nRst,	nG4,	nRst,	nBb4
	dc.b		$14,	nG4,	$04,	nRst,	$0C,	nF5,	smpsNoAttack,	$08
	dc.b		nRst,	$04,	nG5,	$08,	nRst,	$04,	nF5,	$08
	dc.b		nE5,	$04,	nRst,	$08,	nD5,	$34,	nRst,	$0C
	dc.b		nBb4,	$14,	nRst,	$04,	nG4,	$08,	nRst,	$04
	dc.b		nBb4,	$14,	nC5,	$04,	nRst,	$0C,	nF5,	smpsNoAttack
	dc.b		$0C,	nEb5,	nD5,	$08,	nEb5,	$04,	nRst,	$08
	dc.b		nC5,	$03,	smpsNoAttack,	nD5,	$09,	nRst,	$04,	nC5
	dc.b		$0C,	nBb4,	$08,	nC5,	$0C,	nG4,	$04,	smpsNoAttack
	dc.b		$14,	nD5,	$4C
	smpsReturn

; FM4 Data
ContScrn_FM4:
;	Set FM Voice	#
	smpsFMvoice	$01
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call03
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call04
;	Alter Volume	value
	smpsAlterVol	$FB
ContScrn_Loop03:
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call03
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Call At	 	location
	smpsCall	ContScrn_Call06
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call03
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call04
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	ContScrn_Loop03
;	Jump To	 	location
	smpsJump	ContScrn_Loop03

ContScrn_Call02:
	dc.b		nD4,	$08
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$0C,	nD4,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
	smpsReturn

ContScrn_Call03:
	dc.b		nRst,	$0C,	nC4,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04
	smpsReturn

ContScrn_Call06:
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nRst,	$08,	nF3,	$04,	nG3,	$08,	nBb3,	$0C
	dc.b		nG3,	$04,	nBb3,	$08,	nC4,	$04
;	Alter Volume	value
	smpsAlterVol	$02
	smpsReturn

ContScrn_Call04:
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD4,	$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	ContScrn_Call04
	smpsReturn

; FM3 Data
ContScrn_FM3:
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Pitch	value
	smpsAlterPitch	$FC
;	Call At	 	location
	smpsCall	ContScrn_Call07
;	Alter Pitch	value
	smpsAlterPitch	$FE
;	Call At	 	location
	smpsCall	ContScrn_Call08
;	Alter Pitch	value
	smpsAlterPitch	$FD
;	Call At	 	location
	smpsCall	ContScrn_Call07
;	Call At	 	location
	smpsCall	ContScrn_Call09
;	Alter Pitch	value
	smpsAlterPitch	$09
;	Alter Volume	value
	smpsAlterVol	$FB
ContScrn_Loop04:
;	Alter Pitch	value
	smpsAlterPitch	$FC
;	Call At	 	location
	smpsCall	ContScrn_Call07
;	Alter Pitch	value
	smpsAlterPitch	$FE
;	Call At	 	location
	smpsCall	ContScrn_Call08
;	Alter Pitch	value
	smpsAlterPitch	$FD
;	Call At	 	location
	smpsCall	ContScrn_Call07
;	Alter Pitch	value
	smpsAlterPitch	$09
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF3,	$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Call At	 	location
	smpsCall	ContScrn_Call0A
;	Alter Pitch	value
	smpsAlterPitch	$FC
;	Call At	 	location
	smpsCall	ContScrn_Call07
;	Alter Pitch	value
	smpsAlterPitch	$FE
;	Call At	 	location
	smpsCall	ContScrn_Call08
;	Alter Pitch	value
	smpsAlterPitch	$FD
;	Call At	 	location
	smpsCall	ContScrn_Call07
;	Call At	 	location
	smpsCall	ContScrn_Call09
;	Alter Pitch	value
	smpsAlterPitch	$09
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	ContScrn_Loop04
;	Jump To	 	location
	smpsJump	ContScrn_Loop04

ContScrn_Call0A:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nRst,	$0B,	nF3,	$04,	nG3,	$08,	nBb3,	$0C
	dc.b		nG3,	$04,	nBb3,	$08,	nC4,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$F8
	smpsReturn

ContScrn_Call07:
	dc.b		nD4,	$08
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$0C,	nD4,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
	smpsReturn

ContScrn_Call08:
	dc.b		nRst,	$0C,	nC4,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04
	smpsReturn

ContScrn_Call09:
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD4,	$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	ContScrn_Call09
	smpsReturn
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nRst,	$60,	nRst,	nRst,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$05,	$01,	$03,	$02
ContScrn_Jump01:
	dc.b		nRst,	$04
;	Call At	 	location
	smpsCall	ContScrn_Call05
	dc.b		nRst,	$60
;	Call At	 	location
	smpsCall	ContScrn_Call05
	dc.b		nRst,	$5C
;	Jump To	 	location
	smpsJump	ContScrn_Jump01
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Volume	value
	smpsAlterVol	$05
;	Alter Notes	value
	smpsAlterNote	$03
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call03
;	Call At	 	location
	smpsCall	ContScrn_Call02
;	Call At	 	location
	smpsCall	ContScrn_Call04
;	Alter Volume	value
	smpsAlterVol	$FB
;	Alter Notes	value
	smpsAlterNote	$FD
;	Alter Volume	value
	smpsAlterVol	$FB
ContScrn_Loop05:
;	Call At	 	location
	smpsCall	ContScrn_Call0B
;	Call At	 	location
	smpsCall	ContScrn_Call0C
;	Alter Pitch	value
	smpsAlterPitch	$03
;	Call At	 	location
	smpsCall	ContScrn_Call0B
;	Alter Pitch	value
	smpsAlterPitch	$FD
	dc.b		nRst,	$0C,	nBb3,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04,	nRst,	$30
;	Call At	 	location
	smpsCall	ContScrn_Call0B
;	Call At	 	location
	smpsCall	ContScrn_Call0C
;	Alter Pitch	value
	smpsAlterPitch	$03
;	Call At	 	location
	smpsCall	ContScrn_Call0B
;	Alter Pitch	value
	smpsAlterPitch	$FD
;	Call At	 	location
	smpsCall	ContScrn_Call0D
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	ContScrn_Loop05
;	Jump To	 	location
	smpsJump	ContScrn_Loop05

ContScrn_Call0B:
	dc.b		nG3,	$08
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$0C,	nG3,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
	smpsReturn

ContScrn_Call0C:
	dc.b		nRst,	$0C,	nA3,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$0C
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$08,	$04
	smpsReturn

ContScrn_Call0D:
	dc.b		nRst,	$08,	nBb3,	$04
ContScrn_Loop06:
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	ContScrn_Loop06
	smpsReturn

; PSG1 Data
ContScrn_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$04
	dc.b		nRst,	$60,	nRst,	nRst,	nRst,	$30,	nG3,	$0C
	dc.b		nA3,	nBb3,	$08,	nC4,	$04,	nD4,	$08,	nEb4
	dc.b		$04
ContScrn_Jump02:
	dc.b		nF4,	$60,	smpsNoAttack,	$18,	nEb4,	nD4,	nEb4,	nD4
	dc.b		$60,	smpsNoAttack,	$18,	nC4,	nBb3,	nC4,	nG3,	$60
	dc.b		nFs3,	$30,	nD3,	nG3,	$60,	nG3,	$18,	nA3
	dc.b		nBb3,	nC4,	nF4,	$60,	smpsNoAttack,	$18,	nEb4,	nD4
	dc.b		nEb4,	nD4,	$60,	smpsNoAttack,	$30,	nRst,	$20,	nBb3
	dc.b		$04,	nC4,	$08,	nD4,	$04,	nG3,	$60,	nFs3
	dc.b		$30,	nD3,	nG3,	$60,	nG3,	$18,	nA3,	nBb3
	dc.b		$0C,	nC4,	nD4,	nEb4
;	Jump To	 	location
	smpsJump	ContScrn_Jump02

; PSG2 Data
ContScrn_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Modulation	wait	speed	change	step
	smpsModSet	$04,	$01,	$01,	$03
	dc.b		nRst,	$04,	nRst,	$60,	nRst,	nRst,	nRst,	$30
	dc.b		nG3,	$0C,	nA3,	nBb3,	$08,	nC4,	$04,	nD4
	dc.b		$08,	nEb4,	$04
ContScrn_Jump03:
	dc.b		nF4,	$60,	smpsNoAttack,	$18,	nEb4,	nD4,	nEb4,	nD4
	dc.b		$60,	smpsNoAttack,	$18,	nC4,	nBb3,	nC4,	nG3,	$60
	dc.b		nFs3,	$30,	nD3,	nG3,	$60,	nG3,	$18,	nA3
	dc.b		nBb3,	nC4,	nF4,	$60,	smpsNoAttack,	$18,	nEb4,	nD4
	dc.b		nEb4,	nD4,	$60,	smpsNoAttack,	$30,	nRst,	$20,	nBb3
	dc.b		$04,	nC4,	$08,	nD4,	$04,	nG3,	$60,	nFs3
	dc.b		$30,	nD3,	nG3,	$60,	nG3,	$18,	nA3,	nBb3
	dc.b		$0C,	nC4,	nD4,	nEb4
;	Jump To	 	location
	smpsJump	ContScrn_Jump03
ContScrn_Loop07:
	dc.b		nG2,	$08,	$04,	nD3,	$08,	nG2,	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	ContScrn_Loop07
	smpsReturn
ContScrn_Loop08:
	dc.b		nFs2,	$08,	$04,	nC3,	$08,	nFs2,	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	ContScrn_Loop08
	smpsReturn

; PSG3 Data
ContScrn_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
ContScrn_Loop09:
;	Call At	 	location
	smpsCall	ContScrn_Call0E
;	Call At	 	location
	smpsCall	ContScrn_Call0F
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	ContScrn_Loop09
ContScrn_Loop0A:
;	Call At	 	location
	smpsCall	ContScrn_Call0E
;	Call At	 	location
	smpsCall	ContScrn_Call0F
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$04,	ContScrn_Loop0A
;	Call At	 	location
	smpsCall	ContScrn_Call0E
;	Call At	 	location
	smpsCall	ContScrn_Call0F
;	Call At	 	location
	smpsCall	ContScrn_Call0E
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nC4,	$08,	$04,	$08,	$04,	$08,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$04,	nRst,	$18,	nRst,	$08,	nC4,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$04
;	Call At	 	location
	smpsCall	ContScrn_Call0E
;	Call At	 	location
	smpsCall	ContScrn_Call0F
;	Call At	 	location
	smpsCall	ContScrn_Call0E
;	Call At	 	location
	smpsCall	ContScrn_Call0F
;	Jump To	 	location
	smpsJump	ContScrn_Loop0A

ContScrn_Call0E:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nC4,	$08,	$04,	$08,	$04,	$04,	$04,	$04
	dc.b		$08,	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	ContScrn_Call0E
	smpsReturn

ContScrn_Call0F:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nC4,	$08,	$04,	$08,	$04,	$04,	$04,	$04
	dc.b		$08,	$04,	$08,	$04,	$08,	$04,	$04,	$04
	dc.b		$04
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		$0C
	smpsReturn
	dc.b		nA1,	$18,	nBb0,	nRst,	nBb0,	nRst,	nBb0,	nRst
	dc.b		nBb0,	nRst,	nBb0,	nRst,	nBb0,	nRst,	nBb0,	nBb0
	dc.b		$0C,	$0C,	nRst,	$08,	nBb0,	$04,	nRst,	$08
	dc.b		nBb0,	$04
ContScrn_Loop0B:
	dc.b		nBb0,	$0C,	$0C,	nRst,	$24,	nBb0,	$0C,	nRst
	dc.b		$08,	nBb0,	$04,	nRst,	$08,	nBb0,	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0B,	ContScrn_Loop0B
	dc.b		nBb0,	$0C,	nBb0,	nRst,	$38,	nBb0,	$04,	nRst
	dc.b		$08,	nBb0,	$04
ContScrn_Loop0C:
	dc.b		nBb0,	$0C,	$0C,	nRst,	$24,	nBb0,	$0C,	nRst
	dc.b		$08,	nBb0,	$04,	nRst,	$08,	nBb0,	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	ContScrn_Loop0C
;	Jump To	 	location
	smpsJump	ContScrn_Loop0B

; DAC Data
ContScrn_DAC:
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		dSnare,	$18,	dKick,	nRst,	dKick,	nRst,	dKick,	nRst
	dc.b		dKick,	nRst,	dKick,	nRst,	dKick,	nRst,	dKick,	nRst
	dc.b		$0C
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		dSnare,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$90
	dc.b		dHiTimpani,	$08,	$04,	$08,	$04
;	Alter Volume	value
	smpsAlterVol	$70
ContScrn_Loop0D:
;	Call At	 	location
	smpsCall	ContScrn_Call10
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0B,	ContScrn_Loop0D
	dc.b		nRst,	$18,	dSnare,	nRst,	$20
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		dHiTimpani,	$04
;	Alter Volume	value
	smpsAlterVol	$07
	dc.b		dMidTimpani,	$08
;	Alter Volume	value
	smpsAlterVol	$90
	dc.b		dLowTimpani,	$04
;	Alter Volume	value
	smpsAlterVol	$70
ContScrn_Loop0E:
;	Call At	 	location
	smpsCall	ContScrn_Call10
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	ContScrn_Loop0E
;	Jump To	 	location
	smpsJump	ContScrn_Loop0D

ContScrn_Call10:
	dc.b		nRst,	$18,	dSnare,	nRst,	dSnare,	$08
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		dHiTimpani,	$04
;	Alter Volume	value
	smpsAlterVol	$07
	dc.b		dMidTimpani,	$08
;	Alter Volume	value
	smpsAlterVol	$90
	dc.b		dLowTimpani,	$04
;	Alter Volume	value
	smpsAlterVol	$70
	smpsReturn
;	Alter Volume	value
	smpsAlterVol	$C0
	dc.b		dMidTimpani,	$60,	nRst,	dMidTimpani,	$60,	nRst,	$30
;	Alter Volume	value
	smpsAlterVol	$40
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		dHiTimpani,	$30
;	Alter Volume	value
	smpsAlterVol	$04
ContScrn_Jump04:
;	Call At	 	location
	smpsCall	ContScrn_Call11
ContScrn_Loop0F:
	dc.b		nRst,	dLowTimpani,	nRst,	dLowTimpani
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	ContScrn_Loop0F
;	Call At	 	location
	smpsCall	ContScrn_Call11
	dc.b		nRst,	dLowTimpani,	nRst,	dLowTimpani,	nRst,	dLowTimpani,	nRst,	dLowTimpani
	dc.b		nRst,	dLowTimpani,	$14,	$04,	nRst,	$30
ContScrn_Loop10:
	dc.b		nRst,	$18,	dLowTimpani,	nRst,	dLowTimpani
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	ContScrn_Loop10
;	Jump To	 	location
	smpsJump	ContScrn_Jump04

ContScrn_Call11:
;	Alter Volume	value
	smpsAlterVol	$C0
	dc.b		dMidTimpani,	$18
;	Alter Volume	value
	smpsAlterVol	$40
	dc.b		dLowTimpani,	nRst,	dLowTimpani
	smpsReturn
ContScrn_Loop11:
	dc.b		$96,	$60
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	ContScrn_Loop11
ContScrn_Loop12:
;	Call At	 	location
	smpsCall	ContScrn_Call12
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$0B,	ContScrn_Loop12
ContScrn_Loop13:
	dc.b		dHiTimpani,	$08
;	Alter Volume	value
	smpsAlterVol	$CD
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$22
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$DE
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$33
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	ContScrn_Loop13
	dc.b		nRst,	$30
ContScrn_Loop14:
;	Call At	 	location
	smpsCall	ContScrn_Call12
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$04,	ContScrn_Loop14
;	Jump To	 	location
	smpsJump	ContScrn_Loop12

ContScrn_Call12:
	dc.b		dHiTimpani,	$08
;	Alter Volume	value
	smpsAlterVol	$CD
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$22
	dc.b		$08
;	Alter Volume	value
	smpsAlterVol	$DE
	dc.b		$04
;	Alter Volume	value
	smpsAlterVol	$33
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	ContScrn_Call12
	smpsReturn

ContScrn_Voices:
;	Voice 00
;	$09,$52,$51,$01,$01,$DF,$DF,$9F,$9F,$10,$0C,$03,$05,$12,$0F,$04,$07,$7F,$2F,$4F,$9F,$20,$1C,$19,$80
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$05,	$05
	smpsVcCoarseFreq	$01,	$01,	$01,	$02
	smpsVcRateScale		$02,	$02,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$03,	$0C,	$10
	smpsVcDecayRate2	$07,	$04,	$0F,	$12
	smpsVcDecayLevel	$09,	$04,	$02,	$07
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$19,	$1C,	$20

;	Voice 01
;	$01,$75,$75,$71,$31,$D5,$55,$96,$94,$02,$0B,$05,$0D,$0A,$0A,$0F,$06,$FF,$2F,$3F,$6F,$25,$2B,$0F,$80
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$07,	$07
	smpsVcCoarseFreq	$01,	$01,	$05,	$05
	smpsVcRateScale		$02,	$02,	$01,	$03
	smpsVcAttackRate	$14,	$16,	$15,	$15
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$05,	$0B,	$02
	smpsVcDecayRate2	$06,	$0F,	$0A,	$0A
	smpsVcDecayLevel	$06,	$03,	$02,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$0F,	$2B,	$25

;	Voice 02
;	$0D,$77,$65,$05,$15,$1F,$5F,$5F,$5F,$00,$10,$08,$10,$00,$03,$05,$04,$0F,$FC,$8C,$CC,$1F,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$00,	$06,	$07
	smpsVcCoarseFreq	$05,	$05,	$05,	$07
	smpsVcRateScale		$01,	$01,	$01,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$10,	$08,	$10,	$00
	smpsVcDecayRate2	$04,	$05,	$03,	$00
	smpsVcDecayLevel	$0C,	$08,	$0F,	$00
	smpsVcReleaseRate	$0C,	$0C,	$0C,	$0F
	smpsVcTotalLevel	$80,	$80,	$80,	$1F

;	Voice 03
;	$3C,$01,$01,$01,$01,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$21,$80,$21,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$21,	$80,	$21

;	Voice 04
;	$05,$00,$00,$00,$00,$1F,$1F,$1F,$1F,$12,$0C,$0C,$0C,$12,$08,$08,$08,$1A,$56,$56,$56,$07,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$0C,	$0C,	$12
	smpsVcDecayRate2	$08,	$08,	$08,	$12
	smpsVcDecayLevel	$05,	$05,	$05,	$01
	smpsVcReleaseRate	$06,	$06,	$06,	$0A
	smpsVcTotalLevel	$80,	$80,	$80,	$07

;	Voice 05
;	$EF,$04,$8B,$18,$8B,$80,$8B,$80,$8B,$80,$8B,$80,$8B,$80,$8B,$80,$8B,$8B,$0C,$0C,$80,$08,$8B,$04,$80
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$08,	$01,	$08,	$00
	smpsVcCoarseFreq	$0B,	$08,	$0B,	$04
	smpsVcRateScale		$02,	$02,	$02,	$02
	smpsVcAttackRate	$0B,	$00,	$0B,	$00
	smpsVcAmpMod		$04,	$04,	$04,	$04
	smpsVcDecayRate1	$0B,	$00,	$0B,	$00
	smpsVcDecayRate2	$8B,	$80,	$8B,	$80
	smpsVcDecayLevel	$08,	$00,	$00,	$08
	smpsVcReleaseRate	$00,	$0C,	$0C,	$0B
	smpsVcTotalLevel	$80,	$04,	$8B,	$08

;	Voice 06
;	$08,$8B,$04,$8B,$0C,$0C,$80,$24,$8B,$0C,$80,$08,$8B,$04,$80,$08,$8B,$04,$F7,$00,$0B,$FF,$ED,$8B,$0C
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$08,	$00,	$08
	smpsVcCoarseFreq	$0C,	$0B,	$04,	$0B
	smpsVcRateScale		$02,	$00,	$02,	$00
	smpsVcAttackRate	$0B,	$04,	$00,	$0C
	smpsVcAmpMod		$04,	$00,	$04,	$00
	smpsVcDecayRate1	$0B,	$08,	$00,	$0C
	smpsVcDecayRate2	$8B,	$08,	$80,	$04
	smpsVcDecayLevel	$00,	$00,	$0F,	$00
	smpsVcReleaseRate	$0B,	$00,	$07,	$04
	smpsVcTotalLevel	$0C,	$8B,	$ED,	$FF

;	Voice 07
;	$8B,$80,$38,$8B,$04,$80,$08,$8B,$04,$8B,$0C,$0C,$80,$24,$8B,$0C,$80,$08,$8B,$04,$80,$08,$8B,$04,$F7
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$08,	$03,	$08
	smpsVcCoarseFreq	$04,	$0B,	$08,	$00
	smpsVcRateScale		$00,	$02,	$00,	$02
	smpsVcAttackRate	$04,	$0B,	$08,	$00
	smpsVcAmpMod		$04,	$00,	$00,	$04
	smpsVcDecayRate1	$00,	$0C,	$0C,	$0B
	smpsVcDecayRate2	$80,	$0C,	$8B,	$24
	smpsVcDecayLevel	$08,	$00,	$08,	$00
	smpsVcReleaseRate	$00,	$04,	$0B,	$08
	smpsVcTotalLevel	$F7,	$04,	$8B,	$08

;	Voice 08
;	$00,$04,$FF,$ED,$F6,$FF,$CB,$06,$87,$06,$03,$01,$80,$24,$8B,$0C,$80,$08,$8B,$04,$80,$08,$8B,$04,$F7
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$0F,	$0E,	$0F,	$00
	smpsVcCoarseFreq	$06,	$0D,	$0F,	$04
	smpsVcRateScale		$02,	$00,	$03,	$03
	smpsVcAttackRate	$07,	$06,	$0B,	$1F
	smpsVcAmpMod		$04,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$01,	$03,	$06
	smpsVcDecayRate2	$80,	$0C,	$8B,	$24
	smpsVcDecayLevel	$08,	$00,	$08,	$00
	smpsVcReleaseRate	$00,	$04,	$0B,	$08
	smpsVcTotalLevel	$F7,	$04,	$8B,	$08
	even
