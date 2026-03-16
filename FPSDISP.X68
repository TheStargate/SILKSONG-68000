; ==============================================================================
; FPS DISPLAY MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
FDSINIT
; INITIALIZE FPS DISPLAY
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (FPSCOUNT)
            CLR.W   (PREFPSCT)
            RTS
            
; ------------------------------------------------------------------------------
FDSPLOT
; PLOT THE FPS DISPLAY
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A1,-(A7)

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #FDSFCOL,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #FDSLINE1,D1
            TRAP    #15

            ; PRINT FIRST LINE
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.W  #SCRFPS,D1
            MOVE.B  #17,D0
            TRAP    #15
            
            LEA     .TXT3,A1
            MOVE.B  #14,D0
            TRAP    #15

            ; SET SECOND LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #FDSLINE2,D1
            TRAP    #15

            ; UPDATE THE FPS COUNTER EVERY SECOND
            TST.B   (SECINTCT)
            BEQ     .WSEC
            MOVE.W  (FPSCOUNT),D1
            MOVE.W  (FPSCOUNT),(PREFPSCT)
            CLR.B   (SECINTCT)
            CLR.W   (FPSCOUNT)
            BRA     .PRT

            ; KEEP PREVIOUS VALUE
.WSEC       MOVE.W  (PREFPSCT),D1

            ; PRINT SECOND LINE
.PRT        LEA     .TXT2,A1
            MOVE.B  #17,D0
            TRAP    #15
            
            LEA     .TXT3,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            
            RTS
            
.TXT1       DC.B    'GOAL:   ',0
.TXT2       DC.B    'ACTUAL: ',0
.TXT3       DC.B    ' FPS',0
            DS.W    0




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
