;	;	;	;	;	;	;	;	;	;	;	;
;
;	Teleports Mario after playing the Passed Boss music (0B)
;
;	Insert as a generator
;	Does not use extra bit
;	Credit preferred
;	Done at request
;
;	;	;	;	;	;	;	;	;	;	;	;

dcb "INIT"
dcb "MAIN"

LDA $1B98
CMP #$09   ; Warp after 9 seconds, the length of the Passed Boss music
BEQ Warp

LDA $1B97  ; Prevents music reset
BNE Continue

LDA #$0B   ; Music
STA $1DFB  ; Play
LDA #$01   ; Set flag to
STA $1B97  ; prevent music reset

Continue:
LDA $13	   ; Frame count
AND #$3F
BNE Return ; Continue only once per second
INC $1B98  ; Counts seconds
RTL

Warp:
LDA #$06  ;\
STA $71   ; Enter pipe
STZ $89   ;/
STZ $88   ; Instantly warp

Return:
RTL
