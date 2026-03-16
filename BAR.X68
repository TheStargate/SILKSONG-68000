; ==============================================================================
; HEALTH AND ENERGY BAR MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
BARINIT
; INITIALIZE HEALTH AND ENERGY BAR
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (ENERGY)
            MOVE.W  #SCRWIDTH-64,(SCHLTH)
            RTS
             
; ------------------------------------------------------------------------------
BARUPD ; 
; UPDATES HEALTH AND ENERGY BAR
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ------------------------------------------------------------------------------
            CMP.W   #SCRWIDTH-64,(ENERGY)
            BGE     .DONE
            ADDQ.W  #1,(ENERGY)
.DONE       CMP.W   #SCRWIDTH-64,(SCHLTH)
            BLE     .END
            MOVE.W  #SCRWIDTH-64,(SCHLTH)
.END        RTS

; ------------------------------------------------------------------------------
BARPLOT
; PLOT THE ENERGY BAR
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D4,-(A7)
            
            TST.B   (GUNUPD)
            BNE     .PLOT
            BRA     .PLOTH
.PLOT       ; PLOT ENERGY BAR

            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PRJPCOL1,D1
            TRAP    #15
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PRJFCOL1,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  #32,D1
            MOVE.W  #32,D3
            ADD.W   (ENERGY),D3
            MOVE.W  #8,D2
            MOVE.W  #24,D4
            
            ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15
            

.PLOTH      ; PLOT HEALTH BAR

            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PRJPCOL2,D1
            TRAP    #15
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PRJFCOL2,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  #32,D1
            MOVE.W  #32,D3
            ADD.W   (SCHLTH),D3
            MOVE.W  #24,D2
            MOVE.W  #40,D4
            
            ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15

            MOVEM.L (A7)+,D0-D4

            RTS













*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
