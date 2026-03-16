; =============================================================================
; ENEMY PLOT MANAGEMENT
; =============================================================================
FNAME       DC.B 'DATA/enemy.bin',0
            DS.W 0
BUFFER      DS.B 10000
; -----------------------------------------------------------------------------
ENMPINIT
; INITIALIZES THE ENEMY PLOT (READS DATA FROM FILE) 
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVE.B  D0,-(A7)
            MOVEM.L D2/A1,-(A7)

            MOVE.B #50,D0                   ; CLOSE ALL FILES
            TRAP #15
    
            LEA  FNAME,A1   
            ; OPEN FILE (ASSUME A1 POINTS TO FILENAME)
            MOVE.B  #51,D0
            TRAP    #15                     ; D1.L=FILE HANDLER

            ; READ DATA
            LEA BUFFER,A1
.LOOP       
            MOVE.B  #53,D0 
            MOVE.L  #1,D2                   ; BYTES TO READ (ONE BY ONE)
            TRAP #15
            ADD.L   D2,A1                   ; ADVANCE POINTER
   
            TST.B   D0                      ; END OF FILE OR ERROR?
            BEQ     .LOOP                   ; NO: READ MORE
            CLR.B   (A1)                    ; PUT A ZERO-TERMINATOR.
    
            ; CLOSE THE FILE
            MOVE.B  #56,D0
            TRAP    #15
            
            MOVE.B (A7)+,D0
            MOVEM.L (A7)+,D2/A1

            RTS
; -----------------------------------------------------------------------------
ENMPIMG
; PRINT AN IMAGE TO PLOT THE ENEMY
; INPUT    - D1 COORD X TO START DRAWING
;            D2 COORD Y TO START DRAWING
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            MOVE.B  D0,-(A7)
            MOVEM.L D3-D6/A1-A2,-(A7)
   
            MOVE.L D1,D4                    ; COORD X OF THE CURRENT PIXEL
            MOVE.L D2,D3                    ; COORD Y OF THE CURRENT PIXEL
            
            MOVEM.L D1-D2,-(A7)


   
            LEA BUFFER,A1
            MOVE.B (A1)+,D6                 ; HEIGHT
            SUBQ.W #1,D6
            MOVE.B (A1),D5                  ; WIDTH
            SUBQ.W #1,D5
    
            ; READ EACH PIXEL OF THE FILE
            LEA BUFFER,A1
            LEA BUFFER,A2
            ADDQ.L #2,A1
    
            BRA .PRNTPIX
.LONGX
            CLR.L D6
            MOVE.B (A2),D6                  ; RESTORE HEIGHT COUNTER
            SUBQ.W #1,D6
            ADDQ.W #1,D4
            SUB.W  D6,D3      
            BRA .PRNTPIX
.LONGY
            ADDQ.W #1,D3
.PRNTPIX
    
            ; PRINT THE PIXEL
            MOVE.B #80,D0
            MOVE.L (A1)+,D1                 ; DEFINE THE COLOR
            TST.L  D1
            BEQ    .CONT                    ; SKIP IF THE PIXEL IS BLACK
            TRAP #15
    
            CLR.L D1
            CLR.L D2
    
            MOVE.B #82,D0
            MOVE.W D4,D1
            MOVE.W D3,D2
            TRAP #15
    
.CONT       DBRA D6,.LONGY                  ; HEIGHT COUNTER
            DBRA D5,.LONGX                  ; WIDTH COUNTER
    
            MOVEM.L (A7)+,D1-D2
            MOVEM.L (A7)+,D3-D6/A1-A2
            MOVE.B (A7)+,D0
            
            RTS

















*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
