; ==============================================================================
; VICTORY SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
WININIT
; VICTORY SCREEN INITIALIZATION
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ; STOP MUSIC
            MOVE.L  #3, D2         
            MOVE.W  #76, D0
            TRAP    #15
            
            ; PLAY END MUSIC
            MOVE.B  #SNDEND,D7
            TRAP    #SNDPLTN
; ------------------------------------------------------------------------------
WINUPD
; VICTORY SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)
.CONT       RTS

; ------------------------------------------------------------------------------
WINPLOT
; VICTORY SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .TXT1,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT
            
            LEA     .TXT2,A0
            MOVE.B  #11,D0
            JSR     UTLPRINT
            
            BTST.B  #5,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .TXT3,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0

            RTS
.TXT1       DC.B    'YOU WON!',0
.TXT2       DC.B    'MAYBE SILKSONG WERE THE FRIENDS WE MADE ALONG THE WAY',0
.TXT3       DC.B    'PRESS JUMP TO CONTINUE',0
            DS.W    0















*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
