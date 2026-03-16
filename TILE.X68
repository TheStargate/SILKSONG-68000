; ==============================================================================
; MAP TILE MANAGMENT
; ==============================================================================

; ------------------------------------------------------------------------------
GETTILE
; GET A TILE ID BASED ON THE GIVEN COORDS (IN PIXELS)
; INPUT    : D0 - X COORD (IN PIXELS) OF THE DESIRED TILE
;            D1 - Y COORD (IN PIXELS) OF THE DESIRED TILE
;            A0 - MAP ADDRESS
; OUTPUT   : D0 - TILE ID
; MODIFIES : D0 AND D1 (TO CALCULATE THE TILE POSITION)
; ------------------------------------------------------------------------------
            MOVE.L A1,-(A7)
            
            MOVEA.L A0,A1
            
            ; GET TILE POSITION X
            ; DIVIDE BY 32 (TILESIZE)
            LSR.W   #5, D0            
            ADD.W   D0,A1
            
            ; GET TILE POSITION Y
            ; DIVIDE BY 32/20 (TILESIZE/MAPSCRW)
            LSR.W   #5, D1
            MULU    #MAPSCRW, D1  
            ADD.W   D1,A1
           
            ; GET TILE ID
            MOVE.B  (A1),D0
            
            MOVE.L (A7)+,A1
            RTS       

; ------------------------------------------------------------------------------
TILEVEC     DC.L    TILE1,TILE2,TILE3,TILE4,TILE5
; LIST OF TILE PLOT SUBROUTINES
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
TILE1       MOVE.L D1,-(A7)
            MOVE.L #$00775533,D1
            JSR DRAWTILE
            MOVE.L (A7)+,D1
            RTS       
; ------------------------------------------------------------------------------            
TILE2       ; JUMP BLOCK TILE
            MOVE.L D1,-(A7)
            MOVE.L #$00FF00FF,D1
            JSR DRAWTILE
            MOVE.L (A7)+,D1
            RTS
; ------------------------------------------------------------------------------            
TILE3       ; MAGMA BLOCK TILE
            MOVE.L D1,-(A7)
            MOVE.L #$000050FF,D1
            JSR DRAWTILE
            MOVE.L (A7)+,D1
            RTS
; ------------------------------------------------------------------------------            
TILE4       ; GUN UPDATE TILE
            MOVE.L D1,-(A7)
            MOVE.L #$00FFFF00,D1
            JSR DRAWTILE
            MOVE.L (A7)+,D1
            RTS
; ------------------------------------------------------------------------------            
TILE5       ; VELOCITY UPDATE TILE
            MOVE.L D1,-(A7)
            MOVE.L #$0000FFFF,D1
            JSR DRAWTILE
            MOVE.L (A7)+,D1
            RTS
            
; ------------------------------------------------------------------------------
DRAWTILE
; DRAW GENERIC TILE DEPENDING ON INPUT
; INPUT    : D1 - TILE FILL COLOR
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D4,-(A7)
            
            ; SET TILE COLOR
            MOVE.B #81,D0
            TRAP #15
            ;MOVE.L #$00000000,D1
            MOVE.B #80,D0
            TRAP #15

            ; DRAW SQUARE
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W  #TILESIZE,D3
            MOVE.W  D2,D4
            ADD.W  #TILESIZE,D4
            
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS
















*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
