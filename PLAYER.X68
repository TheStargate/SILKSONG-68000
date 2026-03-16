; ==============================================================================
; PLAYER MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
PLYINIT
; INITIALIZE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #TILESIZE+TILESIZE/2,(PLYPOSX)
            MOVE.W  #TILESIZE*13,(PLYPOSY)
            CLR.W   (PLYACCY)
            CLR.W   (PLYVELY)
            MOVE.B  #1,(TOUCHFL)
            CLR.B   (FACING)
            CLR.B   (PRJSHOT)
            CLR.W   (PPRJPOSX)
            CLR.W   (PPRJPOSY)
            CLR.B   (VELUPD)
            CLR.B   (GUNUPD)
            CLR.B   (ATKING)
            RTS
            
; ------------------------------------------------------------------------------
PLYUPD
; UPDATES THE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVE.W  D0,-(A7)
            MOVE.W  D1,-(A7)
            MOVE.L  A0,-(A7)
            MOVE.L  A1,-(A7)
                        
            ; CHECK IF PLAYER IS ATACKING            
            BTST.B  #6,(KBDVAL)
            BEQ     .UPDX
            SUBQ.W  #1,(ENERGY)
            SUBQ.W  #2,(SCHLTH)
            
.UPDX       ; UPDATE X COORDINATE
            MOVE.W  (PLYPOSX),D0
            BTST.B  #0,(KBDVAL)
            BEQ     .CHKRGT
            MOVE.B  #1,(FACING)
            TST.B   (VELUPD)
            BEQ     .NOUPD1
            SUB.W   #PLYSPEED/2,D0
.NOUPD1     SUB.W   #PLYSPEED,D0
.CHKRGT     BTST.B  #2,(KBDVAL)
            BEQ     .DONEX
            CLR.B   (FACING)
            TST.B   (VELUPD)
            BEQ     .NOUPD2
            ADD.W   #PLYSPEED/2,D0
.NOUPD2     ADD.W   #PLYSPEED,D0
            ; UPDATE X VARIABLE
.DONEX      MOVE.W  D0,(PLYPOSX)

            ; UPDATE Y COORDINATE 
            MOVE.W  (PLYPOSY),D0
            BTST.B  #4,(KBDEDGE)            ; CHECK PLAYER JUMP
            BEQ     .LNGJUMP
            
            TST.B   (TOUCHFL)               ; CHECK IF PLAYER IS TOUCHING GROUND
            BEQ     .LNGJUMP
            MOVE.W  #PLYJPVEL,(PLYVELY)     ; IF JUMP INCREMENT Y VELOCITY
            MOVE.W  #PLYJPVEL*2,(LNGJMPPW)    
            ; IF PLAYER IS ON A JUMP BLOCK, INCREMENT LONG JUMP POWER MORE
            CMP.B   #2,(TOUCHFL)
            BNE     .NOJMPB
            ADD.W   #PLYJPVEL,(LNGJMPPW)
.NOJMPB     MOVE.B  #0,(TOUCHFL)

.LNGJUMP    BTST.B  #4,(KBDVAL)             ; CHECK IF PLAYER IS DOING A LONG JUMP
            BNE     .ADJUSTY
            CLR.W   (LNGJMPPW)              ; IF NOT, SET LONG JUMP POWER TO 0
            
.ADJUSTY    TST.B   (TOUCHFL)               ; CHANGE ACCELERATION IF NOT TOUCHING GROUND
            BNE     .DONEY
            MOVE.W  (PLYACCY),D1            ; CHANGE PLAYER ACCELERATION            
            CMP.W   #-16,D1                  ; THE MINIMUM ACCELERATION IS -16
            BEQ     .TSTLJP                 
            SUBQ.W  #GRVTY,D1       
.TSTLJP     TST.W   (LNGJMPPW)              ; CHECK IF THE LONG JUMP STILL HAS POWER
            BEQ     .UPDACC
            ADDQ.W  #PLYJPVEL/2,D1          ; LONG JUMP DETECTED
            SUBQ.W  #1,LNGJMPPW             ; DECREMENT LONG JUMP POWER     
.UPDACC     MOVE.W  D1,(PLYACCY)            
            ADD.W   (PLYVELY),D1
            NEG.W   D1                      ; ADAPT Y DISPLACEMENT  TO THE COORDS
            ADD.W   D1,D0

            ; UPDATE Y VARIABLE
.DONEY      MOVE.W  D0,(PLYPOSY)
            SUB.W  #PLYHEIGH/4-1,D0
            MOVE.W  D0,(HEADPOSY)
            
            ; CHECK IF PLAYER GOES OUTSIDE THE SCREEN (CHANGE SCREEN)
            MOVE.W  (PLYPOSX),D0
            LSR.W   #5, D0
            ; CHECK RIGHT
            CMP.W   #MAPSCRW-1,D0
            BNE     .CHKLFT    
            JSR     DMMINIT              
            ADDQ.B  #1,(MAPPOSX)
            MOVE.W  #TILESIZE,(PLYPOSX)
            JSR     MAPPLOT
            JSR     MAPENMCR
            CLR.B   (PRJSHOT)
            CLR.W   (PPRJPOSX)
            CLR.W   (PPRJPOSY)
            BRA     .CHKCOL
.CHKLFT     ; CHECK LEFT
            CMP.W   #0,D0
            BNE     .CHKTOP   
            JSR     DMMINIT                             
            SUBQ.B  #1,(MAPPOSX)
            MOVE.W  #SCRWIDTH-TILESIZE-1,(PLYPOSX)
            JSR     MAPPLOT
            JSR     MAPENMCR
            CLR.B   (PRJSHOT)
            CLR.W   (PPRJPOSX)
            CLR.W   (PPRJPOSY)
            BRA     .CHKCOL
.CHKTOP     ; CHECK TOP
            MOVE.W  (PLYPOSY),D0
            LSR.W   #5, D0            
            CMP.W   #0,D0
            BNE     .CHKBOT      
            JSR     DMMINIT                          
            SUBQ.B  #1,(MAPPOSY)
            MOVE.W  #SCRHEIGH-TILESIZE*2,(PLYPOSY)
            JSR     MAPPLOT
            JSR     MAPENMCR
            CLR.B   (PRJSHOT)
            CLR.W   (PPRJPOSX)
            CLR.W   (PPRJPOSY)
            BRA     .CHKCOL
.CHKBOT     ; CHECK BOTTOM
            CMP.W   #MAPSCRH-1,D0
            BNE     .CHKCOL      
            JSR     DMMINIT                          
            ADDQ.B  #1,(MAPPOSY)
            MOVE.W  #TILESIZE,(PLYPOSY)
            JSR     MAPPLOT
            JSR     MAPENMCR
            CLR.B   (PRJSHOT)
            CLR.W   (PPRJPOSX)
            CLR.W   (PPRJPOSY)
            
.CHKCOL     ; CHECK MAP COLISIONS
            ; GET CURRENT SCREEN
            JSR     MAPUPD            
            MOVE.L  (MAPSCR),D0
            MOVEA   D0,A0
                                    
.BOTCOL     ; CHECK BOTTOM COLISIONS
            MOVE.B  #0,(TOUCHFL)
            ; GET BOTTOM TILE ID           
            MOVE.W  (PLYPOSX),D0
            ; CORRECT POSITION IF PLAYER IS MOVING
            BTST.B  #2,(KBDVAL)
            BEQ     .GETBID1
            TST.B   (VELUPD)
            BEQ     .NOUPD3
            SUB.W   #PLYSPEED/2,D0
.NOUPD3     SUB.W   #PLYSPEED,D0
.GETBID1    ADD.W   #TILESIZE/2-1,D0
            MOVE.W  (PLYPOSY),D1
            ADD.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .BOTDET
            ; GET BOTTOM TILE ID 2
            MOVE.W  (PLYPOSX),D0
            ; CORRECT POSITION IF PLAYER IS MOVING
            BTST.B  #0,(KBDVAL)
            BEQ     .GETBID2
            TST.B   (VELUPD)
            BEQ     .NOUPD4
            ADD.W   #PLYSPEED/2,D0
.NOUPD4     ADD.W   #PLYSPEED,D0
.GETBID2    SUB.W   #TILESIZE/2-1,D0
            MOVE.W  (PLYPOSY),D1
            ADD.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .TOPCOL
.BOTDET     ; BOTTOM COLLISION DETECTED
            AND.W   #$FFE0,(PLYPOSY)
            AND.W   #$FFE0,(HEADPOSY)
            ADD.W  #PLYHEIGH/4,(HEADPOSY)
            MOVE.B  #1,(TOUCHFL)
            CLR.W   (PLYVELY)
            CLR.W   (PLYACCY)
            BRA     .LFTCOL

.TOPCOL     ; CHECK TOP COLLISIONS          
            ; GET TOP TILE ID           
            MOVE.W  (PLYPOSX),D0
            ; CORRECT POSITION IF PLAYER IS MOVING
            BTST.B  #2,(KBDVAL)
            BEQ     .GETTID1
            TST.B   (VELUPD)
            BEQ     .NOUPD5
            SUB.W   #PLYSPEED/2,D0
.NOUPD5     SUB.W   #PLYSPEED,D0
.GETTID1    ADD.W   #TILESIZE/2-1,D0
            MOVE.W  (PLYPOSY),D1
            SUB.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .TOPDET
            ; GET TOP TILE ID 2
            MOVE.W  (PLYPOSX),D0
            ; CORRECT POSITION IF PLAYER IS MOVING
            BTST.B  #0,(KBDVAL)
            BEQ     .GETTID2
            TST.B   (VELUPD)
            BEQ     .NOUPD6
            ADD.W   #PLYSPEED/2,D0
.NOUPD6     ADD.W   #PLYSPEED,D0
            ADD.W   #PLYSPEED,D0
.GETTID2    SUB.W   #TILESIZE/2-1,D0
            MOVE.W  (PLYPOSY),D1
            SUB.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .LFTCOL
.TOPDET     ; TOP COLLISION DETECTED
            ADD.W   #TILESIZE,(PLYPOSY)
            CLR.W   (PLYVELY)
            CLR.W   (PLYACCY)            
            CLR.W   (LNGJMPPW)            
            AND.W   #$FFE0,(PLYPOSY)
            
.LFTCOL     ; CHECK LEFT COLLISIONS
            ; GET LEFT TILE ID           
            MOVE.W  (PLYPOSX),D0
            SUB.W   #TILESIZE/2,D0
            MOVE.W  (PLYPOSY),D1
            SUB.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .LFTDET
            ; GET LEFT TILE ID 2          
            MOVE.W  (PLYPOSX),D0
            SUB.W   #TILESIZE/2,D0
            MOVE.W  (PLYPOSY),D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .LFTDET
            ; GET LEFT TILE ID 3
            MOVE.W  (PLYPOSX),D0
            SUB.W   #TILESIZE/2,D0
            MOVE.W  (PLYPOSY),D1
            ADD.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .RGTCOL
.LFTDET     ; LEFT COLLISION DETECTED
            ADD.W   #TILESIZE/2,(PLYPOSX)            
            AND.W   #$FFF0,(PLYPOSX)
            BRA     .END
            
.RGTCOL     ; CHECK RIGHT COLLISIONS
            ; GET RIGHT TILE ID           
            MOVE.W  (PLYPOSX),D0
            ADD.W   #TILESIZE/2,D0
            MOVE.W  (PLYPOSY),D1
            SUB.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .RGTDET
            ; GET RIGHT TILE ID 2          
            MOVE.W  (PLYPOSX),D0
            ADD.W   #TILESIZE/2,D0
            MOVE.W  (PLYPOSY),D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .RGTDET
            ; GET RIGHT TILE ID 3
            MOVE.W  (PLYPOSX),D0
            ADD.W   #TILESIZE/2,D0
            MOVE.W  (PLYPOSY),D1
            ADD.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .END
.RGTDET     ; RIGHT COLLISION DETECTED
            AND.W   #$FFF0,(PLYPOSX)

.END
            ; CHECK SPECIAL TILES
            MOVE.W  (PLYPOSX),D0
            MOVE.W  (PLYPOSY),D1
            ADD.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK JUMP BLOCK
            CMP.B   #2,D0
            BNE     .CHK3
            MOVE.B  #2,(TOUCHFL)
            ; CHECK MAGMA BLOCK
.CHK3       CMP.B   #3,D0
            BNE     .CHK4
            SUBQ.W  #4,(SCHLTH)
.CHK4       ; CHECK GUN UPDATE
            CMP.B   #4,D0
            BNE     .CHK5       
            MOVE.B  #1,(GUNUPD)
            CLR.W   (ENERGY)
.CHK5       ; CHECK VELOCITY UPDATE
            CMP.B   #5,D0
            BNE     .NOBLOCK
            MOVE.B  #1,(VELUPD)
.NOBLOCK
            MOVE.L  (A7)+,A1
            MOVE.L  (A7)+,A0
            MOVE.W  (A7)+,D1
            MOVE.W  (A7)+,D0

            RTS
            
; ------------------------------------------------------------------------------
PLYPLOT
; PLOT THE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D4,-(A7)
            
            ; DRAW PLAYER DEPENDING ON WHETHER IS WALKING, STANDING OR ATACKING
            BTST.B  #6,(KBDVAL)
            BEQ     .TST1
            TST.B   (FACING)
            BNE     .INVERTED
            JSR     PLYPLT2
            ; DRAW ELIPSE
            MOVE.W  (PLYPOSX),D1
            MOVE.W  (PLYPOSY),D2
            SUB.W   #16,D2
            MOVE.W  D2,D4
            ADD.W   #48,D4
            ADD.W   #PLYWIDTH/2,D1
            MOVE.W  D1,D3
            ADD.W   #PLYWIDTH/2,D3
            MOVE.B  #88,D0
            TRAP    #15
            BRA     .ENDPLOT
.INVERTED   JSR     PLYPLT2I
            ; DRAW ELIPSE
            MOVE.W  (PLYPOSX),D1
            MOVE.W  (PLYPOSY),D2
            SUB.W   #16,D2
            MOVE.W  D2,D4
            ADD.W   #48,D4
            SUB.W   #PLYWIDTH/2,D1
            MOVE.W  D1,D3
            SUB.W   #PLYWIDTH/2,D3
            MOVE.B  #88,D0
            TRAP    #15
            BRA     .ENDPLOT
.TST1       BTST.B  #0,(KBDVAL)
            BEQ     .TST2
            JSR     PLYPLT2I
            BRA     .ENDPLOT
.TST2       BTST.B  #2,(KBDVAL)
            BEQ     .TST3
            JSR     PLYPLT2
            BRA     .ENDPLOT
.TST3       TST.B   (FACING)
            BNE     .INVRTED2
            JSR     PLYPLT1 
            BRA     .ENDPLOT
.INVRTED2   JSR     PLYPLT1I
            
.ENDPLOT    MOVEM.L (A7)+,D0-D4

            RTS































































































*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
