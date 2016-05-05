; Exchanges Mario's powerup for one life, otherwise plays an "incorrect" sound
; No credit needed

JMP Below : JMP Above : JMP Side : JMP X : JMP X : JMP X : JMP X

Below:
Above:
Side:
LDA $19     ; Powerup status
BEQ Small   ; $19 is 0 if small Mario, so jump ahead
INC $0DBE   ; Increase lives
STZ $19     ; Remove powerup
LDA #$05    ; Life sfx
BRA Return
Small:
LDA #$2A    ; Incorrect sfx
Return:
STA $1DFC   ; Play sfx

X:
RTL
