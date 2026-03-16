; ==============================================================================
; MAP MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
MAPINIT
; INITIALIZE MAP.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.B  #0,(MAPPOSX)
            MOVE.B  #0,(MAPPOSY)
            MOVE.L  #0,(MAPSCR)
            JSR     MAPENMCR
            RTS
; ------------------------------------------------------------------------------
MAPUPD
; UPDATE THE MAP (GET CURRENT SCREEN)
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            AND.L   #$000000FF,D0
            ; GET CURRENT SCREEN FROM MAP VECTOR
            LEA MAPVEC,A0
            ; GET X SCREEN
            MOVE.B  (MAPPOSX),D0
            ASL.B   #2,D0
            ADD.L   D0,A0
            ; GET Y SCREEN (8 SCREENS FOR ROW. MULTIPLY MAPPOSY BY 8)
            MOVE.B  (MAPPOSY),D0
            ASL.B   #5,D0
            ADD.L   D0,A0
            MOVE.L  (A0),D0
            MOVE.L  D0,(MAPSCR)
            MOVEM.L (A7)+,D0/A0            
            RTS
; ------------------------------------------------------------------------------
MAPPLOT
; PLOT THE MAP.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2/A0-A1,-(A7)
             
            ; GET CURRENT SCREEN
            MOVE.L  (MAPSCR),D0
            MOVEA   D0,A0
                        
            MOVE.W #0,(DRAWX)
            MOVE.W #0,(DRAWY)
            
            ; PLOT EVERY TILE OF THE CURRENT SCREEN
            MOVE.W #MAPSCRH-1,D1
.NEXTROW
            MOVE.W #MAPSCRW-1,D0
.DRAWROW
            MOVE.B (A0)+,D2                 ; GET TILE ID
            BEQ   .DONE                     ; SKIP IF D2 = 0 (EMPTY TILE)
            ; ADAPT THE ID TO THE TILE PLOT VECTOR
            AND.W #$00FF,D2
            ASL.W #2,D2
            SUBQ.W  #4,D2
            
            ; PLOT THE CORRESPONDING TILE
            LEA     TILEVEC,A1             
            MOVE.L  (A1,D2),A1
            JSR     (A1)
            
            ; GO TO NEXT TILE
.DONE       ADD.W #TILESIZE,(DRAWX)
            DBRA D0,.DRAWROW
            ; GO TO NEXT ROW
            MOVE.W #0,(DRAWX)
            ADD.W #TILESIZE,(DRAWY)
            DBRA D1,.NEXTROW
            
            MOVEM.L (A7)+,D0-D2/A0-A1

            RTS

; -----------------------------------------------------------------------------
MAPENMCR
; CREATES ENEMIES FOR THE CURRENT SCREEN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4/A0-A3,-(A7)
            CLR.B   D3                      ; ENEMY COUNTER
            CLR.W   D4                      ; CURRENT MAP SCREEN
            MOVE.B  (MAPPOSY),D4            
            ASL.W   #8,D4
            MOVE.B  (MAPPOSX),D4
            LEA     ENMDATA,A0              ; GET ENEMY LIST
.LOOP       MOVE.W  (A0),D1                 ; GET DATA
            CMP.W   #$FFFF,D1               ; TERMINATOR REACHED?
            BEQ     .END                    ; IF SO, EXIT
            CMP.W   D1,D4                   ; ENEMY IN CURRENT SCREEN
            BNE     .NEXT
            ADDQ.B  #1,D3                   ; COUNT ENEMIES
            ; CREATE ENEMY
            LEA     ENMINIT,A1
            LEA     ENMUPD,A2
            LEA     ENMPLOT,A3
            MOVE.W  #ENMAT,D0
            MOVE.L  2(A0),D1
            MOVE.W  6(A0),D2
            JSR     AGLADD
.NEXT       ADD.L   #8,A0                   ; GO TO NEXT ENEMY
            BRA     .LOOP
.END        MOVE.B  D3,(MAPNUMEN)           ; STORE THE NUMBER OF ENEMIES
            MOVEM.L (A7)+,D0-D4/A0-A3
            RTS







*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
