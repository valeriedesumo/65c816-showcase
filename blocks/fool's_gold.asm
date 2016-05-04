;Hurts Mario unless he has more than a customizable number of coins
;No credit needed

JMP Below : JMP Above : JMP Side : JMP X : JMP X : JMP X : JMP X

Below:
Above:
Side:
LDA $0DBF   ;current coins
CMP #30	    ;number of coins Mario must have LESS than to get hurt
BCS Return
JSL $00F5B7 ;hurt routine
Return:

X:
RTL
