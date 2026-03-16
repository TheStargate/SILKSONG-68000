; ==============================================================================
; SYSTEM VARIABLES
; ==============================================================================
            
; --- KEYBOARD RELATED VARIABLES -----------------------------------------------

KBDVAL      DS.B    1                       ; KEY STATE
KBDEDGE     DS.B    1                       ; KEY EDGE

; --- TIMED INTERRUPT RELATED VARIABLES ----------------------------------------

SCRINTCT    DS.B    1                       ; INTERRUPT COUNTER
SECINTCT    DS.B    1                       ; INTERRUPT COUNTER 2
SCRCYCCT    DS.B    1                       ; CYCLE COUNTER

; --- FRAMES PER SECOND RELATED VARIABLES --------------------------------------
FPSCOUNT    DS.W    1                       ; FPS COUNTER
PREFPSCT    DS.W    1                       ; PREVIOUS FPS COUNTER VALUE











*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
