;	;	;	;	;	;	;	;	;	;	;	;
;
;	(INCOMPLETE)
;
;	Sets ON when hit, OFF when hit if EXTRA BIT is set	
;
;	Insert as a sprite
;	Must be assembled with xkas (romi's SpriteTool, not mikeyk's)
;
;	;	;	;	;	;	;	;	;	;	;	;


	!GET_DRAW_INFO = $168008    ; Point to GET_DRAW_INFO patch + 8 (hex)
	!GFXTILE  = $C2             ; Top left 8x8 of 16x16 tile
	!GFXTILEb = $88             ; Tile when Extra Bit is set
	!YXPPCCCT = #%00011000      ; YXPPCCCT of sprite, 0 is clear, 1 is set
		     ;YXPPCCCT
		     ;Set Y to Y-flip
		     ;Set X to X-flip
		     ;PP is layer priority
			;00 - Lowest
			;01 - Low
			;10 - High
			;11 - Highest
		     ;CCC is palette
			;000 = Palette 8
			;001 = Palette 9
			;010 = Palette A
			;011 = Palette B
			;100 = Palette C
			;101 = Palette D
			;110 = Palette E
			;111 = Palette F
		     ;Set T to use 2nd GFX Page (SP3/SP4)
	!YXPPCCCTb = #%00010110     ; YXPPCCCT when Extra Bit is set
		      ;YXPPCCCT

print "INIT ",pc

	RTL


print "MAIN ",pc

	PHB                ; \
	PHK                ;  | Change data bank to current
	PLB                ;  |
	JSL SpriteRoutine  ;  |
	PLB                ;  | Restore
	RTL                ; /


;	;	;	;	;	;	;	;	;
;
;	SpriteRoutine
;
;	;	;	;	;	;	;	;	;

SpriteRoutine:
	
	JSL GraphicsRoutine

	JSL $01A7DC    ; \ Check if
	BCC NoContact  ; / touching sprite

	LDA $0E
	CMP #$F8
	BCC Go_on

	; Code run when hit from below

	BRA SidesBottom
	Go_on:

	; Code run when hit from sides or above

	CMP #$E6
	BPL SidesBottom

	; Code run when hit from above
	LDA #$0B       ; \ Play
	STA $1DF9      ; / sound

	LDA $7FAB10,x  ; \
	AND #$04       ;  | Check if Extra Bit is set
	BNE ExtraBit   ; /

	STZ $14AF      ; Set ON
	BRA Continue

	ExtraBit:
	INC $14AF      ; Set OFF

	Continue:
	; TODO: Destroy P-switch

	BRA Return

	SidesBottom:

	; Code run when hit from sides or below
	; TODO: Make carryable
	JSL $01B44F	; Act solid

	NoContact:
	Return:
	RTL



;	;	;	;	;	;	;	;	;
;
;	GraphicsRoutine
;
;	;	;	;	;	;	;	;	;

GraphicsRoutine:

	JSL !GET_DRAW_INFO

	; The X position of the sprite is now in $00.
	; The Y position of the sprite is now in $01.
	; The index to the OAM is now in Y
	; The X position of the sprite OAM is at $0300.
	; The Y position of the sprite OAM is at $0301.

	LDA $00           ; \ Store X Position to X Position of Sprite OAM
	STA $0300,y       ; / Indexed by Y, so it's only for this sprite
	LDA $01           ; \ Store Y Position to Y Position of Sprite OAM
	STA $0301,y       ; / Indexed by Y

	LDA $7FAB10,x     ; \
	AND #$04          ;  | Check if Extra Bit is set
	BNE ExtraBitSet   ; /

	LDA #!GFXTILE     ; \ Store GFX tile to OAM
	STA $0302,y       ; / Indexed by Y

	LDA.b !YXPPCCCT   ; \
	ORA $64           ;  | Set YXPPCCCT 
	STA $0303,y       ; /
	BRA Go

	ExtraBitSet:

	LDA #!GFXTILEb    ; \ Store GFX tile to OAM
	STA $0302,y       ; / Indexed by Y

	LDA.b !YXPPCCCTb  ; \
	ORA $64           ;  | Set YXPPCCCT for when Extra Bit is set
	STA $0303,y       ; /

	Go:

	LDY #$02          ; 02 because it's 16x16.
	LDA #$00          ; Tiles written - 1 (1-1=0)
	JSL $01B7B3       ; Run OAM Routine to write tiles
	RTL
