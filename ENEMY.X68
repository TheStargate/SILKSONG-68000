; =============================================================================
; ENEMY MANAGEMENT (AGENT)
; ENMPOSX (W)  (A0)
; ENMPOSY (W) 2(A0)
; ENMDIR  (B) 4(A0)
; ENMTYPE (B) 6(A0)
; =============================================================================

; -----------------------------------------------------------------------------
ENMINIT
; INITIALIZES THE ENEMY
; INPUT    - A0 POINTER TO THE AGENT DATA BLOCK
;            D1.L HIGH WORD INITIAL Y. LOW WORD INITIAL X
;            D2.W HIGH BYTE ENEMY TYPE. LOW BYTE ENEMY INITIAL DIRECTION
; OUTPUT   - NONE
; MODIFIES - D1 AND D2
; -----------------------------------------------------------------------------
            MOVE.W  D1,(A0)                 ; WRITE INITIAL X
            SWAP    D1                      
            MOVE.W  D1,2(A0)                ; WRITE INITIAL Y
            MOVE.B  D2,4(A0)                ; WRITE ENEMY DIRECTION
            ANDI.L  #$FF00, D2
            LSR.W   #8, D2
            MOVE.B  D2,6(A0)                ; WRITE ENEMY TYPE
            CLR.B   (SECPRJCT)
            RTS

; -----------------------------------------------------------------------------
ENMUPD
; UPDATES THE ENEMY MOTION
; INPUT    - A0 POINTER TO THE AGENT DATA BLOCK
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            MOVEM.W D0-D2,-(A7)
            MOVE.L A1,-(A7)

            ; UPDATE ENEMY COORDINATES
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            MOVE.B  4(A0),D2
            
            ADD.W   #ENMSPEED,D1
            
            ; CHECK DIRECTION
            CMP.B   #0,D2
            BNE     .CHKT1
            ADD.W   #ENMSPEED,D0
            ; GENERATE PROJECTILE IF PLAYER IS WITHIN RANGE
            CMP.W   (PLYPOSX),D0
            BGE     .CHKSCOL
            BRA     .NEWPRJ
.CHKT1      CMP.B   #1,D2
            BNE     .CHKT2
            SUB.W   #ENMSPEED,D0
            ; GENERATE PROJECTILE IF PLAYER IS WITHIN RANGE
            CMP.W   (PLYPOSX),D0
            BLE     .CHKSCOL
            BRA     .NEWPRJ
.CHKT2      CMP.B   #2,D2
            BNE     .CHKT3
            SUB.W   #ENMSPEED,D1
            BRA     .CHKSCOL
.CHKT3      ADD.W   #ENMSPEED,D1
            BRA     .CHKSCOL
            
.NEWPRJ     ; GENERATE PROJECTILE (ONLY EVERY 4 SECONDS)
            CMP.B   #3,(SECPRJCT)
            BLE     .CHKSCOL
            CLR.B   (SECPRJCT)
            LEA     PRJINIT,A1
            LEA     PRJUPD,A2
            LEA     PRJPLOT,A3
            JSR     AGLADD
            
.CHKSCOL    ; CHECK HORIZONTAL COLLISIONS
            CMP.W   #SCRWIDTH-ENMWIDTH/2,D0
            BGT     .COLWALL
            CMP.W   #ENMWIDTH/2,D0
            BLT     .COLWALL
            ; CHECK VERTICAL COLLISIONS
            CMP.W   #SCRHEIGH-ENMWIDTH/2,D1
            BGT     .COLWALL
            CMP.W   #ENMWIDTH/2,D1
            BLT     .COLWALL
            BRA     .CHKPLY
            
            ; WALL COLLISION (CHANGE DIRECTION)
.COLWALL    TST.B   4(A0)
            BEQ     .CHGTO1
            SUBQ.B  #1,4(A0)
            BRA     .CHKPLY
.CHGTO1     ADDQ.B  #1,4(A0)

            ; CHECK PLAYER COLLISIONS
.CHKPLY     MOVE.W  (PLYPOSX),D2
            SUB.W   D0,D2
            BPL     .ISPOS
            NEG.W   D2
.ISPOS      ; CHECK DIRECTION
            CMP.B   #2,4(A0)
            BGE     .INVCOL            
            CMP.W   #PLYWIDTH/2+ENMWIDTH/2,D2
            BGT     .DONE
            MOVE.W  (PLYPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS2
            NEG.W   D2
.ISPOS2     CMP.W   #PLYHEIGH/2+ENMHEIGH/2,D2
            BGT     .DONE
            BRA     .PLYCOL
            
.INVCOL     CMP.W   #PLYWIDTH/2+ENMHEIGH/2,D2
            BGT     .DONE
            MOVE.W  (PLYPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS3
            NEG.W   D2
.ISPOS3     CMP.W   #PLYHEIGH/2+ENMWIDTH/2,D2
            BGT     .DONE
            
.PLYCOL     ; PLAYER COLLISION
            SUBQ.W  #4,(SCHLTH)

            ; STORE POSITION
.DONE       MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)
            
            ; CHECK PLAYER PROJECTILE COLLISIONS
.CHKPRJ     MOVE.W  (PPRJPOSX),D2
            SUB.W   D0,D2
            BPL     .ISPOS4
            NEG.W   D2
.ISPOS4     ; CHECK DIRECTION
            CMP.B   #2,4(A0)
            BGE     .INVCOL2            
            CMP.W   #PRJWIDTH/2+ENMWIDTH/2,D2
            BGT     .DONE2
            MOVE.W  (PPRJPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS5
            NEG.W   D2
.ISPOS5     CMP.W   #PRJHEIGH/2+ENMHEIGH/2,D2
            BGT     .DONE2
            BRA     .PRJCOL
            
.INVCOL2    CMP.W   #PRJWIDTH/2+ENMHEIGH/2,D2
            BGT     .DONE2
            MOVE.W  (PLYPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS6
            NEG.W   D2
.ISPOS6     CMP.W   #PRJHEIGH/2+ENMWIDTH/2,D2
            BGT     .DONE2
            
.PRJCOL     ; PLAYER PROJECTILE COLLISION
            CLR.B   (PRJSHOT)
            CLR.W   (PPRJPOSX)
            CLR.W   (PPRJPOSY)
            JSR     AGLKILL
            
            ; STORE POSITION
.DONE2      MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)
            
            ; CHECK PLAYER ATACK COLLISIONS
            BTST.B  #6,(KBDVAL)
            BEQ     .CHKCOL
            MOVE.W  (PLYPOSX),D2
            TST.B   (FACING)
            BEQ     .FLEFT
            SUB.W   #64,D2
.FLEFT      ADD.W   #32,D2
            SUB.W   D0,D2
            BPL     .ISPOS7
            NEG.W   D2
.ISPOS7      ; CHECK DIRECTION
            CMP.B   #2,4(A0)
            BGE     .INVCOL3            
            CMP.W   #PLYWIDTH/2+ENMWIDTH/2,D2
            BGT     .DONE3
            MOVE.W  (PLYPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS8
            NEG.W   D2
.ISPOS8     CMP.W   #PLYHEIGH/2+ENMHEIGH/2,D2
            BGT     .DONE3
            BRA     .PLYACOL    
            
.INVCOL3    CMP.W   #PLYWIDTH/2+ENMHEIGH/2,D2
            BGT     .DONE
            MOVE.W  (PLYPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS9
            NEG.W   D2
.ISPOS9     CMP.W   #PLYHEIGH/2+ENMWIDTH/2,D2
            BGT     .DONE3
            
.PLYACOL    ; PLAYER ATACK COLLISION
            ADD.W   #50,(SCHLTH)
            JSR     AGLKILL
            
            ; STORE POSITION
.DONE3      MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)
            
.CHKCOL     ; CHECK MAP COLISIONS
            MOVE.L  A0,A1                   ; SAVE AGENT DATA POINTER
            ; GET CURRENT SCREEN
            JSR     MAPUPD            
            MOVE.L  (MAPSCR),D0
            MOVEA   D0,A0

.BOTCOL     ; CHECK BOTTOM COLISIONS
            ; GET BOTTOM TILE ID           
            MOVE.W  (A1),D0
            SUB.W   #ENMSPEED,D0
            ADD.W   #TILESIZE/2-1,D0
            MOVE.W  2(A1),D1
            ADD.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .BOTDET
            ; GET BOTTOM TILE ID 2
            MOVE.W  (A1),D0
            ADD.W   #ENMSPEED,D0
            SUB.W   #TILESIZE/2-1,D0
            MOVE.W  2(A1),D1
            ADD.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .TOPCOL
.BOTDET     ; BOTTOM COLLISION DETECTED
            AND.W   #$FFE0,2(A1)
            ;CLR.W   (PLYVELY)
            ;CLR.W   (PLYACCY)
            BRA     .LFTCOL

.TOPCOL     ; CHECK TOP COLLISIONS          
            ; GET TOP TILE ID           
            MOVE.W  (A1),D0
            SUB.W   #ENMSPEED,D0
            ADD.W   #TILESIZE/2-1,D0
            MOVE.W  2(A1),D1
            SUB.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .TOPDET
            ; GET TOP TILE ID 2
            MOVE.W  (A1),D0
            ADD.W   #ENMSPEED,D0
            SUB.W   #TILESIZE/2-1,D0
            MOVE.W  2(A1),D1
            SUB.W   #TILESIZE,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .LFTCOL
.TOPDET     ; TOP COLLISION DETECTED
            ADD.W   #TILESIZE,2(A1)
            ;CLR.W   (PLYVELY)
            ;CLR.W   (PLYACCY)            
            AND.W   #$FFE0,2(A1)
            
.LFTCOL     ; CHECK LEFT COLLISIONS
            ; GET LEFT TILE ID           
            MOVE.W  (A1),D0
            SUB.W   #TILESIZE/2,D0
            MOVE.W  2(A1),D1
            SUB.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .LFTDET
            ; GET LEFT TILE ID 2          
            MOVE.W  (A1),D0
            SUB.W   #TILESIZE/2,D0
            MOVE.W  2(A1),D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .LFTDET
            ; GET LEFT TILE ID 3
            MOVE.W  (A1),D0
            SUB.W   #TILESIZE/2,D0
            MOVE.W  2(A1),D1
            ADD.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .RGTCOL
.LFTDET     ; LEFT COLLISION DETECTED
            ADD.W   #TILESIZE/2,(A1)            
            AND.W   #$FFF0,(A1)
            CLR.B   4(A1)
            BRA     .END
            
.RGTCOL     ; CHECK RIGHT COLLISIONS
            ; GET RIGHT TILE ID           
            MOVE.W  (A1),D0
            ADD.W   #TILESIZE/2,D0
            MOVE.W  2(A1),D1
            SUB.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .RGTDET
            ; GET RIGHT TILE ID 2          
            MOVE.W  (A1),D0
            ADD.W   #TILESIZE/2,D0
            MOVE.W  2(A1),D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BNE     .RGTDET
            ; GET RIGHT TILE ID 3
            MOVE.W  (A1),D0
            ADD.W   #TILESIZE/2,D0
            MOVE.W  2(A1),D1
            ADD.W   #TILESIZE-1,D1
            JSR     GETTILE
            ; CHECK IF IT IS AIR
            CMP.B   #0,D0
            BEQ     .END
.RGTDET     ; RIGHT COLLISION DETECTED
            AND.W   #$FFF0,(A1)
            MOVE.B  #1,4(A1)

.END        MOVE.L  A1,A0                   ; RESTORE AGENT DATA POINTER

            MOVE.L  (A7)+,A1 
            MOVEM.W (A7)+,D0-D2

            RTS

; -----------------------------------------------------------------------------
ENMPLOT
; PLOTS THE ENEMY
; INPUT    - A0 POINTER TO THE AGENT DATA BLOCK
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVEM.L D0-D4,-(A7)


            ; DEFINE COORDINATES
            MOVE.W  (A0),D1
            SUB.W   #ENMWIDTH/2,D1
            MOVE.W  2(A0),D2
            SUB.W   #ENMHEIGH/3,D2
            
            ; PRINT ENEMY IMAGE
            JSR     ENMPIMG
            
            MOVEM.L (A7)+,D0-D4

            RTS



























*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
