; ==============================================================================
; ENEMY DATA
; ==============================================================================
; ENMDATA STORES, FOR EACH ENEMY IN THE MAP:
; - A WORD STATING SCREEN X (LOW BYTE) AND Y (HIGH BYTE) WHERE IS THE ENEMY.
; - THE DATA TO PASS TO D1 AND D2 IN ENMINIT:
;   - D1.L HIGH WORD INITIAL Y. LOW WORD INITIAL X
;   - D2.W HIGH BYTE ENEMY TYPE. LOW BYTE ENEMY INITIAL DIRECTION
; A WORD FFFF IS USED AS TERMINATOR.
; -----------------------------------------------------------------------------

ENMDATA     DC.W    $0000
            DC.W    TILESIZE*13
            DC.W    TILESIZE*14+TILESIZE/2
            DC.W    $0001

            DC.W    $0001
            DC.W    TILESIZE*3
            DC.W    TILESIZE*13+TILESIZE/2
            DC.W    $0000
            
            DC.W    $0002
            DC.W    TILESIZE*5
            DC.W    TILESIZE*16+TILESIZE/2
            DC.W    $0001
            
            DC.W    $0300
            DC.W    TILESIZE*13
            DC.W    TILESIZE*3+TILESIZE/2
            DC.W    $0000
            
            DC.W    $0300
            DC.W    TILESIZE*4
            DC.W    TILESIZE*11+TILESIZE/2
            DC.W    $0000

            DC.W    $0302
            DC.W    TILESIZE*9
            DC.W    TILESIZE*9+TILESIZE/2
            DC.W    $0000
            
            DC.W    $0401
            DC.W    TILESIZE*3
            DC.W    TILESIZE*8+TILESIZE/2
            DC.W    $0001
            
            DC.W    $0502
            DC.W    TILESIZE*8
            DC.W    TILESIZE*7+TILESIZE/2
            DC.W    $0001
            
            DC.W    $0502
            DC.W    TILESIZE*3
            DC.W    TILESIZE*13+TILESIZE/2
            DC.W    $0000
            
            DC.W    $0503
            DC.W    TILESIZE*12
            DC.W    TILESIZE*12+TILESIZE/2
            DC.W    $0001
            
            DC.W    $0503
            DC.W    TILESIZE*3
            DC.W    TILESIZE*6+TILESIZE/2
            DC.W    $0000
            
            DC.W    $0504
            DC.W    TILESIZE*6
            DC.W    TILESIZE*12+TILESIZE/2
            DC.W    $0001
            
            DC.W    $0504
            DC.W    TILESIZE*12
            DC.W    TILESIZE*3+TILESIZE/2
            DC.W    $0000
            
            DC.W    $0505
            DC.W    TILESIZE*13
            DC.W    TILESIZE*5+TILESIZE/2
            DC.W    $0000
            
            DC.W    $0505
            DC.W    TILESIZE*13
            DC.W    TILESIZE*16+TILESIZE/2
            DC.W    $0001

            DC.W    $FFFF



























*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
