; ==============================================================================
; TITLE       : SILKSONG 68000
; AUTHORS     : JAUME JUAN HUGUET - ENRIC CLAUSEN LANGELAAN
; DATE        : 10-JAN-2025
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "DATA/MAPDATA.X68"
            INCLUDE "DATA/ENMDATA.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/UTLCONST.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "PRJCTILE.X68"
            INCLUDE "ENEMY.X68"
            INCLUDE "ENMPLOT.X68"
            INCLUDE "PLAYER.X68"
            INCLUDE "PLYPLOT.X68"
            INCLUDE "BAR.X68"
            INCLUDE "FPSDISP.X68"
            INCLUDE "GAME.X68"
            INCLUDE "TILE.X68"
            INCLUDE "MAP.X68"
            INCLUDE "INTRO.X68"
            INCLUDE "INSTRUCTIONS.X68"
            INCLUDE "WIN.X68"
            INCLUDE "GOVER.X68"
            INCLUDE "STATES.X68"
            
           
START

; --- INITIALIZATION -----------------------------------------------------------

            ORI.W   #$0700,SR
            JSR     SYSINIT
            JSR     STAINIT
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC
         
            JSR     STAUPD

; --- SYNC ---------------------------------------------------------------------

            ; CHECK IF SCRINTCT TO ADJUST FPS
            ; IF IT IS GREATER THAN 10, DO THE PLOT ANYWAYS
            CMP.B   #10,(SCRINTCT)
            BGT     .WINT   
            ; IF IT IS GREATER THAN 0, SKIP THE PLOT         
            TST.B   (SCRINTCT)
            BLE     .WINT
            SUBQ.B  #1,(SCRINTCT) 
            BRA     .LOOP            
.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            SUBQ.B  #1,(SCRINTCT)             

; --- PLOT ---------------------------------------------------------------------
            
            ADDQ.W  #1,(FPSCOUNT)
            JSR     STAPLOT
            
            TRAP    #SCRUPTN               ; UPDATE DOUBLE BUFFER

            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "SYSVARS.X68" 
            INCLUDE "LIB/DMMVARS.X68"


            END     START



















































*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
