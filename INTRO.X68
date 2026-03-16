; ==============================================================================
; INTRO SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
ISCINIT
; INTRO SCREEN INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (STATIMER)
            ; STOP MUSIC
            MOVE.L  #3, D2         
            MOVE.W  #76, D0
            TRAP    #15
            ; PLAY TITLE MUSIC
            MOVE.B  #SNDTITL,D7
            TRAP    #SNDPLTN
            RTS

; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            MOVE.W  #2,(STANEXT)
            
.CONT       ADDQ.W  #1,(STATIMER)
            CMP.W   #SCRFPS*10,(STATIMER)
            BLT     .DONE
            MOVE.W  #1,(STANEXT)
.DONE       RTS

; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
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
            
            BTST.B  #5,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0

            RTS
.TXT1       DC.B    'SILKSONG 68000',0
.TXT2       DC.B    'PRESS JUMP TO START',0
            DS.W    0
























*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
