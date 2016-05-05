;	;	;	;	;	;	;	;	;	;	;	;
;
;	A generator that gives Mario a coin per second when ON is set, takes away a coin when
;	OFF is set, changes ON to OFF after a few seconds, and kills Mario when he has 0 coins
;
;	Insert as a generator
;	Does not use extra bit
;	Will kill Mario instantly if he enters the level with 0 coins
;	Thus the best placement is in a level after the entrance level, providing some coins
;	Limits max coins to 98
;	Credit much preferred
;	Done at request
;
;	;	;	;	;	;	;	;	;	;	;	;



dcb "INIT"
dcb "MAIN"


LDA $0DBF	; Coins
CMP #99		; If 99 coins...
BNE Bleh
DEC $0DBF	; Decrease by one to prevent 1-up via coins, and A0 graphic from displaying in coin counter
Bleh:


LDA $0DBF
BEQ Death	; Kill if 0 coins


LDA $14AF	; ON/OFF status
CMP #$01
BEQ Continue	; Continue if 01-FF (OFF)


LDA $13		; Frame count
BEQ ONOFFSwitch	; Set OFF after maximum of 4.25 seconds


Continue:
LDA $13		; Frame count
AND #$3F	; Continue only once per second
BNE Return


LDA $14AF	; ON/OFF
BEQ ON		; If 00 (ON), branch


;OFF:
DEC $0DBF	; Take coin
LDA #$2A	; Incorrect SFX
STA $1DFC
BRA Return



ON:
INC $0DBF	; Give coin
LDA #$01	; Coin SFX
STA $1DFC
BRA Return



Death:
LDA $188A	; Prevents death from running every frame
BNE Return
JSL $F606	; Die Mario, die!
LDA #$01	
STA $188A	; Sets flag in free RAM to prevent death from running every frame (cleared on overworld)
BRA Return


ONOFFSwitch:
LDA #$01
STA $14AF	; Switch OFF
LDA #$1C	; SFX
STA $1DFC


Return:
RTL
