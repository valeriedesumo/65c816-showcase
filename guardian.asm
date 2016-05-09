;	;	;	;	;	;	;	;	;	;	;	;
;
;	If the player has less than the customizable amount of coins, Guardian displays selected message
;	and flings the player away with a sound. If the player has enough, Guardian takes that many coins
;	away, plays "correct" sound, displays selected message, and allows access to blocked passageway.
;
;	Must be where Mario can't touch its top, bottom, or right side with less than 30 coins.
;	Credit preferred
;
;	;	;	;	;	;	;	;	;	;	;	;

JMP Below : JMP Above : JMP Side : JMP X : JMP X : JMP X : JMP X

Below:
Above:
Side:
!coin = #30 ; Number of coins Mario must have LESS than to not pass, and will be taken away
LDA $0666   ; Free RAM
BNE End
LDA $0DBF
CMP !coin
BCS Rich    ; Branch if sufficient coins
LDA #$80    ; X speed
STA $7B     ; Push Mario
LDA #$28    ; Punt SFX
LDY #$01    ; Change to 01 for 1st level message, 02 for 2nd message, 03 for Yoshi's message
BRA Return
Rich:
SEC         ; \
SBC !coin   ;  Take away coins
STA $0DBF   ; /
INC $191F   ; Disable Guardian via free RAM (cleared on overworld load)
LDA #$29    ; Wrong SFX
LDY #$02    ; Change to 01 for 1st level message, 02 for 2nd message, 03 for Yoshi's message
Return:
STA $1DFC   ; Play sound
STY $1426   ; Show message
End:

X:
RTL
