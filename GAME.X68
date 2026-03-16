; ==============================================================================
; GAME MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; INITIALIZES GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     DMMINIT
            JSR     PLYINIT
            JSR     MAPINIT
            JSR     ENMPINIT
            JSR     BARINIT
            JSR     FDSINIT
            
            ; STOP MUSIC
            MOVE.L  #3, D2         
            MOVE.W  #76, D0
            TRAP    #15
            
            ; PLAY GAME MUSIC
            MOVE.B  #SNDMSIC,D7
            TRAP    #SNDPLTN

            RTS
            
; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1-A3,-(A7)
            
            ; CHECK PLAYER SHOT
            TST.B   (GUNUPD)
            BEQ     .GOUPD
            BTST.B  #5,(KBDEDGE)
            BEQ     .GOUPD
            TST.B   (PRJSHOT)
            BNE     .GOUPD
            CMP.W   #100,(ENERGY)
            BLT     .GOUPD
            
            ; GENERATE PROJECTILE
            SUB.W   #100,(ENERGY)
            LEA     PRJINIT,A1
            LEA     PRJUPD,A2
            LEA     PRJPLOT,A3
            MOVE.W  #PRJPLYAT,D0
            JSR     AGLADD

.GOUPD      JSR     MAPUPD  
            JSR     AGLUPD
            JSR     PLYUPD
            JSR     BARUPD
    
            ; CHECK HEALTH
            TST.W   (SCHLTH)
            BLE     .GOVER
            BRA     .CHKWIN
.GOVER      MOVE.W  #4,(STANEXT)
            BRA     .DONE
            
.CHKWIN     ;CHECK SCREEEN
            CMP.B   #5,(MAPPOSX)
            BNE     .DONE
            CMP.B   #4,(MAPPOSY)
            BNE     .DONE
.WIN        MOVE.W  #3,(STANEXT)
    
.DONE       MOVEM.L (A7)+,D0/A1-A3
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     MAPPLOT
            JSR     AGLPLOT
            JSR     FDSPLOT
            JSR     BARPLOT
            BRA     PLYPLOT







































*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
