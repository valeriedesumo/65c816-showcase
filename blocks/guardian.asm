;Credit preferred
;If the player has less than the customizable amount of coins, Guardian displays selected message
;and flings the player away with a sound. If the player has enough, Guardian takes that many coins
;away, plays "correct" sound, displays selected message, and allows access to blocked passageway.
;Must be where Mario can't touch its top, bottom, or right side with less than 30 coins.

JMP Below : JMP Above : JMP Side : JMP X : JMP X : JMP X : JMP X

Below:
Above:
Side:
!coin = #30 ;number of coins Mario must have LESS than to not pass, and will be taken away
LDA $0666   ;free RAM
BNE End
LDA $0DBF
CMP !coin
BCS Rich    ;branch if sufficient coins
LDA #$80    ;X speed
STA $7B     ;push Mario
LDA #$28    ;punt SFX
LDY #$01    ;change to 01 for 1st level message, 02 for 2nd message, 03 for Yoshi's message
BRA Return
Rich:
SEC         ;\
SBC !coin   ; take away coins
STA $0DBF   ;/
LDA #$01
STA $0666   ;disable guardian
LDA #$29    ;wrong SFX
LDY #$02    ;change to 01 for 1st level message, 02 for 2nd message, 03 for Yoshi's message
Return:
STA $1DFC   ;play sound
STY $1426   ;show message
End:

X:
RTL
