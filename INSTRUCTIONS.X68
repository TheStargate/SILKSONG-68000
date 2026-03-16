; ==============================================================================
; INSTRUCTIONS SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
INSINIT
; INSTRUCTIONS SCREEN INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (STATIMER)
            RTS

; ------------------------------------------------------------------------------
INSUPD
; INSTRUCTIONS SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)
.CONT       ADDQ.W  #1,(STATIMER)
            CMP.W   #SCRFPS*10,(STATIMER)
            BLT     .DONE
            CLR.W   (STANEXT)
.DONE       RTS

; ------------------------------------------------------------------------------
INSPLOT
; INSTRUCTIONS SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A0-A1,-(A7)
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            MOVE.B  #11,D0
            LEA     .TXTLST,A1
.LOOP       MOVE.L  (A1)+,D1
            BEQ     .DONE
            MOVE.L  D1,A0
            JSR     UTLPRINT
            BRA     .LOOP
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1
            RTS
.TXT1       DC.B    'WELCOME TO SILKSONG, FINALLY!',0
.TXT2       DC.B    'YOU NEED TO REACH THE END OF THE CAVE',0
.TXT3       DC.B    'USE WASD AND SPACE TO MOVE THE CHARACTER',0
.TXT4       DC.B    'PRESS E TO ATACK ENEMIES (IT WILL HURT YOU!)',0
.TXT5       DC.B    'GET UPDATES FOR YOUR PLAYER ON THE MAP',0
.TXT6       DC.B    'GET THE GUN UPDATE TO SHOT YOUR ENEMIES',0
.TXT7       DC.B    'PRESS F TO SHOT (IT CONSUMES ENERGY)',0
.TXT8       DC.B    'BEWARE OF THE MAGMA BLOCKS',0
.TXT9       DC.B    'HAVE FUN!',0
            DS.W    0
.TXTLST     DC.L    .TXT1,.TXT2,.TXT3,.TXT4,.TXT5,.TXT6,.TXT7,.TXT8,.TXT9,0









*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
