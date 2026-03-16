; ==============================================================================
; GAME CONSTANTS
; ==============================================================================

; --- WORLD RELATED CONSTANTS --------------------------------------------------

GRVTY       EQU     1                       ; WORLD GRAVITY

; --- PROJECTILE RELATED CONTANTS ----------------------------------------------

PRJWIDTH    EQU     64                      ; PROJECTILE WIDTH
PRJHEIGH    EQU     16                      ; PROJECTILE HEIGHT
PRJPCOL1    EQU     $00AA0000               ; PLAYER PROJECTILE CONTOUR COLOR
PRJFCOL1    EQU     $00FF0000               ; PLAYER PROJECTILE FILL COLOR
PRJPCOL2    EQU     $000000AA               ; ENEMY PROJECTILE CONTOUR COLOR
PRJFCOL2    EQU     $000000FF               ; ENEMY PROJECTILE FILL COLOR
PRJSPEED    EQU     10                      ; MAGNITUDE OF THE Y DISPLACEMENT

PRJPLYAT    EQU     1                       ; AGENT TYPE FOR PLAYER PROJECTILE

; --- ENEMY RELATED CONTANTS ---------------------------------------------------

ENMWIDTH    EQU     32                      ; ENEMY WIDTH
ENMHEIGH    EQU     64                      ; ENEMY HEIGHT
ENMPCOL     EQU     $0000AA00               ; ENEMY CONTOUR COLOR
ENMFCOL     EQU     $0000FF00               ; ENEMY FILL COLOR
ENMSPEED    EQU     2                       ; MAGNITUDE OF THE X DISPLACEMENT

ENMAT       EQU     3                       ; AGENT TYPE FOR ENEMY

; --- PLAYER RELATED CONSTANTS -------------------------------------------------

PLYSPEED    EQU     4                       ; MAGNITUDE OF THE X DISPLACEMENT
PLYJPVEL    EQU     4                       ; MAGNITUDE OF THE JUMP POWER

PLYWIDTH    EQU     32                      ; PLAYER WIDTH
PLYHEIGH    EQU     64                      ; PLAYER HEIGHT

HEADRADX    EQU     11                      ; HEAD RADIUS X
HEADRADY    EQU     14                      ; HEAD RADIUS Y

EYESRADX    EQU     2                       ; EYES RADIUS X
EYESRADY    EQU     4                       ; EYES RADIUS Y

CLTSIDEX    EQU     8                       ; CLOTHES HALF X SIZE 
CLTSIDEY    EQU     16                      ; CLOTHES HALF Y SIZE 

NECKY       EQU     6                       ; NECK Y SIZE

HATSIDEX    EQU     8                       ; HAT HALF X SIZE
HATSIDEY    EQU     5                       ; HAT HALF Y SIZE

ATKSIZEX    EQU     32                      ; ATTACK X SIZE
ATKSIZEY    EQU     64                      ; ATTACK Y SIZE

; --- PLAYER COLOR RELATED CONSTANTS -------------------------------------------

HEADCOLC    EQU     $004A4A4A               ; HEAD CONTOUR COLOR
HEADCOLF    EQU     $00E1E1E1               ; HEAD FILL COLOR

EYESCOLC    EQU     $004A4A4A               ; EYES CONTOUR COLOR
EYESCOLF    EQU     $00000000               ; EYES FILL COLOR

CLOTCOLC    EQU     $004A4A4A               ; CLOTHES CONTOUR COLOR
CLOTCOLF    EQU     $00302823               ; CLOTHES FILL COLOR

NECKCOL     EQU     $005E1124               ; NECKERCHIEF COLOR

HATCOLC     EQU     $004A4A4A               ; HAY CONTOUR COLOR
HATCOLC2    EQU     $003E3E3E               ; HAY CONTOUR COLOR 2
HATCOLF     EQU     $00302823               ; HAT FILL COLOR

ATACKCOL    EQU     $00FFFFFF               ; ATTACK FILL AND CONTOUR COLOR

; --- FPS DISPLAY RELATED CONSTANTS --------------------------------------------

FDSFCOL     EQU     $00000000               ; TEXT BACKGROUND COLOR
FDSLINE1    EQU     $0103                   ; FIRST TEXT LINE COORDINATES
FDSLINE2    EQU     $0104                   ; SECOND TEXT LINE COORDINATES

; --- STATE RELATED CONSTANTS --------------------------------------------------

STANONE     EQU     -1                      ; NON-EXISTENT STATE NUMBER

; --- MAP RELATED CONSTANTS ----------------------------------------------------

MAPWIDTH    EQU     8                       ; NUMBER OF SCREENS HORIZONTALLY
MAPHEIGH    EQU     8                       ; NUMBER OF SCREENS VERTICALLY
MAPSCRW     EQU     20                      ; TILES PER SCREEN HORIZONTALLY
MAPSCRH     EQU     15                      ; TILES PER SCREEN VERTICALLY
TILESIZE    EQU     32                      ; MAP TILE SIZE




















































*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
