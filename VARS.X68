; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- PLAYER RELATED VARIABLES -------------------------------------------------

PLYPOSX     DS.W    1                       ; PLAYER X COORDINATE
PLYPOSY     DS.W    1                       ; PLAYER Y COORDINATE
HEADPOSY    DS.W    1                       ; PLAYER HEAD Y COORDINATE
PLYVELY     DS.W    1                       ; PLAYER Y VELOCITY
PLYACCY     DS.W    1                       ; PLAYER Y ACCELERATION
LNGJMPPW    DS.W    1                       ; CURRENT POWER OF THE LONG JUMP
            ; 1 IF PLAYER TOUCH FLOOR, 0 IF NOT, 2 IF TOUCHING JUMP BLOCK
TOUCHFL     DS.B    1                       
FACING      DS.B    1                       ; 0 IF FACING RIGHT, 1 IF LEFT
ATKING      DS.B    1                       ; 1 IF PLAYER IS ATACKING, 0 IF NOT

            ; PLAYER HABILITIES
VELUPD      DS.B    1                       ; 1 IF VELOCITY UPDATE, 0 IF NOT
GUNUPD      DS.B    1                       ; 1 IF GUN UPDATE, 0 IF NOT

; --- PROJECTILE RELATED VARIABLES ---------------------------------------------

PPRJPOSX    DS.W    1                       ; PLAYER PROJECTILE X COORDINATE
PPRJPOSY    DS.W    1                       ; PLAYER PROJECTILE Y COORDINATE
            ; 1 IF THERE IS A PLAYER PROJECTILE ON SCREEN, 0 IF NOT
PRJSHOT     DS.B    1  
            ; SECOND COUNTER (ENEMIES GENERATE PROJECTILES EVERY 5 SECONDS)                   
SECPRJCT    DS.B    1

; --- ENERGY BAR RELATED VARIABLES ---------------------------------------------

ENERGY      DS.W    1                       ; CURRENT ENERGY AVAILABLE

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCORE       DS.W    1                       ; PLAYER SCORE
SCHLTH      DS.W    1                       ; PLAYER HEALTH

; --- STATE RELATED VARIABLES --------------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE
STATIMER    DS.W    1                       ; INTRO TIMER

; --- MAP RELATED VARIABLES ----------------------------------------------------

MAPPOSX     DS.B    1                       ; CURRENT SCREEN X COORD
MAPPOSY     DS.B    1                       ; CURRENT SCREEN Y COORD
MAPNUMEN    DS.B    1                       ; CURRENT SCREEN ENEMY COUNTER
MAPSCR      DS.L    1                       ; CURRENT SCREEN ADDRESS

; --- PLOT VARIABLES -----------------------------------------------------------

DRAWX       DS.W    1                       ; X COORDINATE
DRAWY       DS.W    1                       ; Y COORDINATE

DRAWFACE    DS.W    1                       ; TYPE OF FACE TO DRAW

COLORBACK   DS.L     1                      ; THE COLOR OF THE BACKGROUND




































*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
