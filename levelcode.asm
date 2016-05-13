;	;	;	;	;	;	;	;	;	;	;	;
;
;	Toggles spotlight sprite every second, faster if time is running out
;
;	For use with LevelASM
;
;	;	;	;	;	;	;	;	;	;	;	;

level7F:
	LDA $0F31
	BEQ Low7F    ; If remaining level time is below 100 seconds, branch
	LDA $14      ;\
	AND #$7F     ; | Run twice per 256 frames (~0.5 seconds)
	BEQ Set7F    ;/
	RTS
Low7F:	LDA $14      ;\
	AND #$3F     ; | Run four times per 256 frames (~1 second)
	BEQ Set7F    ;/
	RTS

Set7F:	LDY #$09     ; Prepare for loop through 10 sprites
Lbl7F:	LDA $14C8,y  ;\ Sprite status
	CMP #$08     ; | If status is (so) not normal
	BNE Lbl07F   ;/ Skip that sprite
	
	LDA $009E,y  ;\ If the dark room sprite is present
	CMP #$C6     ; | Then continue
	BNE Lbl07F   ;/ 
	
	LDA $00C2,y  ;\
	EOR #$01     ; | Turn the switch on/off (flip bits)
	STA $00C2,y  ;/
	LDA #$0B     ; SFX
	STA $1DF9
Lbl07F:	DEY          ;\ Decrease loop counter
	BPL Lbl7F    ;/ If not done yet, loop
	RTS
