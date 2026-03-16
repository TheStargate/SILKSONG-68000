; ==============================================================================
; PROJECTILE MANAGEMENT (AGENT)
; PRJPOSX (W)  (A0)
; PRJPOSY (W) 2(A0)
; PRJDIR  (B) 4(A0) (0 IF RIGHT, 1 IF LEFT, 2 IF UP, 3 IF DOWN)
; PRJTYPE (B) 6(A0) (0 IF PLAYER PROJECTILE, 1 IF ENEMY PROJECTILE)
; ==============================================================================

; ------------------------------------------------------------------------------
PRJINIT
; INITIALIZE PROJECTILE.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
;            D0 IF 0 PROJECTILE IS FROM PLAYER, IF NOT ENMPOSX
;            D1 ENMPOSY (OR NOTHING)
;            D2 ENMDIR (OR NOTHING)
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CMP.W   #PRJPLYAT,D0
            BNE     .ENMPRJ
            BRA     .PLYPRJ
.ENMPRJ     ; ENEMY PROJECTILE INITIALIZATION
            MOVE.B  #1,6(A0)
            ; SET DIRECTION AND POSITION
            MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)
            TST.B   D2
            BNE     .NEGDIR
            MOVE.B  #0,4(A0)
            RTS
.NEGDIR     MOVE.B  #1,4(A0)
            RTS

.PLYPRJ     ; PLAYER PROJECTILE INITIALIZATION
            MOVE.B  #0,6(A0)
.PLYINIT    MOVE.B  #1,(PRJSHOT)
            ; SET DIRECTION
            BTST.B  #1,(KBDVAL)
            BEQ     .CHKS
            MOVE.B  #2,4(A0)
            BRA     .INITPOS
.CHKS       BTST.B  #3,(KBDVAL)
            BEQ     .NOKEY
            MOVE.B  #3,4(A0)
            BRA     .INITPOS
.NOKEY      MOVE.B  (FACING),4(A0)

.INITPOS    ; SET INITIAL POSITION
            MOVE.W  (PLYPOSX),(A0)
            MOVE.W  (PLYPOSY),2(A0)
            CMP.B   #0,4(A0)
            BNE     .LEFT
            ADD.W   #PRJWIDTH,(A0)
            BRA     .ENDINIT
.LEFT       CMP.B   #1,4(A0)
            BNE     .UP
            SUB.W   #PRJWIDTH,(A0)
            BRA     .ENDINIT
.UP         CMP.B   #2,4(A0)
            BNE     .DOWN
            SUB.W   #PRJWIDTH,2(A0)
            BRA     .ENDINIT
.DOWN       ADD.W   #PRJWIDTH,2(A0)
            
.ENDINIT    RTS

; ------------------------------------------------------------------------------
PRJUPD
; UPDATES THE PROJECTILE.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES  
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.W D0-D2,-(A7)

            ; CHECK IF THE PROJECTILE IS FROM THE PLAYER
            TST.B   6(A0)
            BNE     .UPD
            ; CHECK IF WE NEED TO UPDATE THE PROJECTILE
            TST.B   (PRJSHOT)
            BNE     .UPD
            JSR     AGLKILL
            BRA     .DONE

.UPD        ; UPDATE PROJECTILE COORDINATES
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            MOVE.B  4(A0),D2
            
            ; CHECK DIRECTION
            CMP.B   #0,D2
            BNE     .CHKLEFT
            ADD.W   #PRJSPEED,D0
            BRA     .CHKCOL
.CHKLEFT    CMP.B   #1,D2
            BNE     .CHKUP
            SUB.W   #PRJSPEED,D0
            BRA     .CHKCOL
.CHKUP      CMP.B   #2,D2
            BNE     .CHKDOWN
            SUB.W   #PRJSPEED,D1
            BRA     .CHKCOL
.CHKDOWN    ADD.W   #PRJSPEED,D1
            
.CHKCOL     ; CHECK HORIZONTAL COLLISIONS
            CMP.W   #SCRWIDTH-PRJWIDTH/2,D0
            BGT     .COLWALL
            CMP.W   #PRJWIDTH/2,D0
            BLT     .COLWALL
            ; CHECK VERTICAL COLLISIONS
            CMP.W   #SCRHEIGH-PRJWIDTH/2,D1
            BGT     .COLWALL
            CMP.W   #PRJWIDTH/2,D1
            BLT     .COLWALL
            BRA     .CHKPLY
            
            ; WALL COLLISION
.COLWALL    ; CHECK IF THE PROJECTILE IS FROM THE PLAYER
            TST.B   6(A0)
            BNE     .KILL
            CLR.B   (PRJSHOT)
.KILL       JSR     AGLKILL
            BRA     .DONE
            
            ; CHECK PLAYER COLLISIONS (ONLY FOR ENEMY PROJECTILES)
.CHKPLY     TST.B   6(A0)
            BEQ     .UPDVAR
            MOVE.W  (PLYPOSX),D2
            SUB.W   D0,D2
            BPL     .ISPOS
            NEG.W   D2
.ISPOS      ; CHECK DIRECTION
            CMP.B   #2,4(A0)
            BGE     .INVCOL            
            CMP.W   #PLYWIDTH/2+PRJWIDTH/2,D2
            BGT     .DONE
            MOVE.W  (PLYPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS2
            NEG.W   D2
.ISPOS2     CMP.W   #PLYHEIGH/2+PRJHEIGH/2,D2
            BGT     .DONE
            BRA     .PLYCOL
            
.INVCOL     CMP.W   #PLYWIDTH/2+PRJHEIGH/2,D2
            BGT     .DONE
            MOVE.W  (PLYPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS3
            NEG.W   D2
.ISPOS3     CMP.W   #PLYHEIGH/2+PRJWIDTH/2,D2
            BGT     .DONE
            
.PLYCOL     ; PLAYER COLLISION
            SUB.W   #200,(SCHLTH)
            JSR     AGLKILL
            BRA     .DONE

.UPDVAR     ; UPDATE PLAYER PROJECTILE COORDS
            MOVE.W  D0,(PPRJPOSX)
            MOVE.W  D1,(PPRJPOSY)

            ; STORE POSITION
.DONE       MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)

            MOVEM.W (A7)+,D0-D2

            RTS
            
; ------------------------------------------------------------------------------
PRJPLOT
; PLOT THE PROJECTILE.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)

            ; SET PEN COLOR
            MOVE.B  #80,D0
            TST.B   6(A0)
            BEQ     .PLYP
            MOVE.L  #PRJPCOL2,D1
            TRAP    #15
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PRJFCOL2,D1
            TRAP    #15
            BRA     .CHKDIR
.PLYP       MOVE.L  #PRJPCOL1,D1
            TRAP    #15
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PRJFCOL1,D1
            TRAP    #15
            
.CHKDIR     ; CHECK DIRECTION
            CMP.B   #2,4(A0)
            BGE     .INVERTED
            ; DEFINE COORDINATES
            MOVE.W  (A0),D1
            SUB.W   #PRJWIDTH/2,D1
            MOVE.W  D1,D3
            ADD.W   #PRJWIDTH,D3
            MOVE.W  2(A0),D2
            SUB.W   #PRJHEIGH/2,D2
            MOVE.W  D2,D4
            ADD.W   #PRJHEIGH,D4
            BRA     .DRAW
            
.INVERTED   MOVE.W  (A0),D1
            SUB.W   #PRJHEIGH/2,D1
            MOVE.W  D1,D3
            ADD.W   #PRJHEIGH,D3
            MOVE.W  2(A0),D2
            SUB.W   #PRJWIDTH/2,D2
            MOVE.W  D2,D4
            ADD.W   #PRJWIDTH,D4

.DRAW       ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS

























*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
