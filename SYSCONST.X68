; ==============================================================================
; SYSTEM CONSTANTS
; ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH    EQU     640                     ; SCREEN WIDTH
SCRHEIGH    EQU     480                     ; SCREEN HEIGHT
SCRFPS      EQU     64                      ; SCREEN FRAMES PER SECOND

; --- KEYCODES -----------------------------------------------------------------

KBDLEFT     EQU     'A'
KBDUP       EQU     'W'
KBDRIGHT    EQU     'D'
KBDDOWN     EQU     'S'
KBDJUMP     EQU     ' '
KBDFIRE1    EQU     'F'
KBDFIRE2    EQU     'E'
KBDPAUSE    EQU     'P'

; --- TRAP NUMBERS -------------------------------------------------------------

SCRUPTN     EQU     0                       ; SCREN UPDATE TRAP NUMBER
KBDUPTN     EQU     1                       ; KEYBOARD UPDATE TRAP NUMBER
SNDPLTN     EQU     2                       ; SOUND PLAY TRAP NUMBER

; --- SOUND IDENTIFIERS --------------------------------------------------------

SNDMSIC     EQU     0
SNDEND      EQU     1
SNDBOSS     EQU     4
SNDTITL     EQU     2
SNDDIE      EQU     3

; --- INTERRUPT NUMBERS --------------------------------------------------------

SCRINTN     EQU     1                       ; TIMED INTERRUPT NUMBER
SECINTN     EQU     2                       ; TIMED INTERRUPT NUMBER 2 (1000ms)



























*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
