;Exchanges Mario's powerup for one life, otherwise plays an "incorrect" sound
;No credit needed

JMP Below : JMP Above : JMP Side : JMP X : JMP X : JMP X : JMP X

Below:
Above:
Side:
LDA $19    ;powerup status
BEQ Small  ;$19 is 0 if small Mario, so jump ahead
INC $0DBE  ;increase lives
STZ $19    ;remove powerup
LDA #$05   ;life sfx
BRA Return
Small:
LDA #$2A   ;incorrect sfx
Return:
STA $1DFC  ;play sfx

X:
RTL
