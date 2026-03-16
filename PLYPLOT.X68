*-----------------------------------------------------------
* Title      : PLAYER PLOT SUBROUTINES
* INPUT      : NONE
* OUTPUT     : NONE
* MODIFIES   : NONE
*-----------------------------------------------------------
            
PLYPLT1:
* Title      : PLOT THE CHARACTER
* INPUT      : NONE
* OUTPUT     : NONE 
* MODIFIES   : NONE

            MOVEM.L D0-D4,-(A7)
            
            MOVE.B  #1,(DRAWFACE)
            
            JSR HEAD
            
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #CLOTCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE BODY
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX,D3
            MOVE.W  D2,D4
            ADD.W   #2*CLTSIDEY,D4
            
            JSR SQUARE
            
            ;DEFINE COORDINATES OF A LINE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX/2,D3
            MOVE.W  D2,D4
            ADD.W   #2*CLTSIDEY,D4
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            ADD.W   #2*CLTSIDEY,D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX/2,D3
            MOVE.W  D2,D4
            
            JSR LINE
            
            ;DEFINE COORDINATES FOR FILL
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX,D1
            SUB.W   #CLTSIDEX/8,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #CLTSIDEY+3,D2
            ADD.W   #CLTSIDEY/2,D2
            
            ; FILL  
            MOVE.B  #89,D0
            TRAP    #15
            
            ;SET LINE COLOR
            MOVE.B #80,D0
            MOVE.L #CLOTCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES OF A LINE(TO FIX INSIDE)
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            JSR GUARDARXY                   ; GET POSITION OF THE CORNER
            ADD.W   #2*CLTSIDEY,D4
            
            JSR LINE
            
            ;SET PEN COLOR
            MOVE.B #80,D0
            MOVE.L #NECKCOL,D1
            TRAP #15             
            
            ;MODIFY DRAWY
            MOVE.W (DRAWY),D1
            ADD.W   #HEADRADY/16,D1
            MOVE.W  D1,(DRAWY)
            
            JSR NECK
            
           ;REPAIR NECK WITH A LINE
            MOVE.W  (DRAWX),D1
            SUB.W   #HEADRADX/8,D1
            MOVE.W  (DRAWY),D2
            SUB.W   #NECKY/2,D2
            ADD.W   #2*CLTSIDEX,D1
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #NECKY,D4
            
            JSR LINE

            MOVEM.L (A7)+,D0-D4

            RTS
            
PLYPLT1I:
* Title      : PLOT THE CHARACTER (INVERTED)
* INPUT      : NONE
* OUTPUT     : NONE 
* MODIFIES   : NONE

            MOVEM.L D0-D4,-(A7)
            
            MOVE.B  #1,(DRAWFACE)
            
            JSR HEADI
            
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #CLOTCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE BODY
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX*-1,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX*-1,D3
            MOVE.W  D2,D4
            ADD.W   #2*CLTSIDEY,D4
            
            JSR SQUARE
            
            ;DEFINE COORDINATES OF A LINE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX*-1,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX*-1/2,D3
            MOVE.W  D2,D4
            ADD.W   #2*CLTSIDEY,D4
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX*-1,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            ADD.W   #2*CLTSIDEY,D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX*-1/2,D3
            MOVE.W  D2,D4
            
            JSR LINE
            
            ;DEFINE COORDINATES FOR FILL
            MOVE.W  (PLYPOSX),D1
            ADD.W   #CLTSIDEX,D1
            ADD.W   #CLTSIDEX/8,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #CLTSIDEY+5,D2
            ADD.W   #CLTSIDEY/2,D2
            
            ; FILL  
            MOVE.B  #89,D0
            TRAP    #15
            
            ;SET LINE COLOR
            MOVE.B #80,D0
            MOVE.L #CLOTCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES OF A LINE(TO FIX INSIDE)
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX*-1,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            JSR GUARDARXY                   ; GET POSITION OF THE CORNER
            ADD.W   #2*CLTSIDEY,D4
            
            JSR LINE
            
            ;SET PEN COLOR
            MOVE.B #80,D0
            MOVE.L #NECKCOL,D1
            TRAP #15             
            
            ;MODIFY DRAWY
            MOVE.W (DRAWY),D1
            ADD.W   #HEADRADY/16,D1
            MOVE.W  D1,(DRAWY)
            
            JSR NECKI
            
            ;REPAIR NECK WITH A LINE
            MOVE.W  (DRAWX),D1
            SUB.W   #HEADRADX*-1/8,D1
            MOVE.W  (DRAWY),D2
            SUB.W   #NECKY/2,D2
            ADD.W   #2*CLTSIDEX*-1,D1
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #NECKY,D4
            
            JSR LINE

            MOVEM.L (A7)+,D0-D4

            RTS
            
PLYPLT2:
* Title      : PLOT THE CHARACTER WALKING
* INPUT      : NONE
* OUTPUT     : NONE
* MODIFIES   : NONE

            MOVEM.L D0-D4,-(A7)
            
            MOVE.B  #0,(DRAWFACE)
            
            JSR HEAD

            ;SET CONTOUR COLOR
            MOVE.B #80,D0
            MOVE.L #CLOTCOLC,D1
            TRAP #15          
            
            ;DEFINE 1� LINE OF THE BODY
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX,D1
            SUB.W   #CLTSIDEX/4,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX,D3
            MOVE.W  D2,D4
            ADD.W   #2*CLTSIDEY,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE 2� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX/4,D3
            MOVE.W  D2,D4
            SUB.W   #CLTSIDEY/12,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE 3� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX/4,D3
            MOVE.W  D2,D4
            SUB.W   #CLTSIDEY/16,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 4� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX/4,D3
            MOVE.W  D2,D4
            ADD.W   #CLTSIDEY/16,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 5� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX/4,D3
            MOVE.W  D2,D4
            ADD.W   #CLTSIDEY/12,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 6� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX,D3
            MOVE.W  D2,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 7� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX/4,D3
            ADD.W   #CLTSIDEX/16,D3
            MOVE.W  D2,D4
            SUB.W   #2*CLTSIDEY,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE 8� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX/4,D3
            SUB.W   #CLTSIDEX/16,D3
            SUB.W   #2*CLTSIDEX,D3
            MOVE.W  D2,D4                   
            JSR GUARDARXY

            JSR LINE

            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #CLOTCOLF,D1
            TRAP #15
            
            ;DEFINE FILL LOCATION
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2      
            ADD.W   #CLTSIDEY+10,D2
            
            JSR FILL
            JSR NECK  

            ;DEFINE FILL LOCATION
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2      
            ADD.W   #CLTSIDEX,D1
            ADD.W   #CLTSIDEX/2,D1
            ADD.W   #CLTSIDEX/4,D1
            ADD.W   #CLTSIDEY/16,D2     

            JSR FILL  
            
            MOVEM.L (A7)+,D0-D4

            RTS

PLYPLT2I:
* Title      : PLOT THE INVERTED CHARACTER WALKING
* INPUT      : NONE
* OUTPUT     : NONE
* MODIFIES   : NONE

            MOVEM.L D0-D4,-(A7)
            
            MOVE.B  #0,(DRAWFACE)
            
            JSR HEADI

            ;SET CONTOUR COLOR
            MOVE.B #80,D0
            MOVE.L #CLOTCOLC,D1
            TRAP #15          
            
            ;DEFINE 1� LINE OF THE BODY
            MOVE.W  (PLYPOSX),D1
            SUB.W   #CLTSIDEX*-1,D1
            SUB.W   #CLTSIDEX*-1/4,D1
            MOVE.W  (HEADPOSY),D2
            ADD.W   #HEADRADY,D2
            ADD.W   #HEADRADY/8,D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX*-1,D3
            MOVE.W  D2,D4
            ADD.W   #2*CLTSIDEY,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE 2� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX*-1/4,D3
            MOVE.W  D2,D4
            SUB.W   #CLTSIDEY/12,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE 3� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX*-1/4,D3
            MOVE.W  D2,D4
            SUB.W   #CLTSIDEY/16,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 4� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX*-1/4,D3
            MOVE.W  D2,D4
            ADD.W   #CLTSIDEY/16,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 5� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX*-1/4,D3
            MOVE.W  D2,D4
            ADD.W   #CLTSIDEY/12,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 6� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX*-1,D3
            MOVE.W  D2,D4
            JSR GUARDARXY

            JSR LINE
            
            ;DEFINE 7� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #CLTSIDEX*-1/4,D3
            ADD.W   #CLTSIDEX*-1/16,D3
            MOVE.W  D2,D4
            SUB.W   #2*CLTSIDEY,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE 8� LINE OF THE BODY
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            SUB.W   #CLTSIDEX*-1/4,D3
            SUB.W   #CLTSIDEX*-1/16,D3
            SUB.W   #(2*CLTSIDEX)*-1,D3
            MOVE.W  D2,D4                   
            JSR GUARDARXY

            JSR LINE
            
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #CLOTCOLF,D1
            TRAP #15
            
            ;DEFINE FILL LOCATION
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2      
            ADD.W   #CLTSIDEY,D2
            
            JSR FILL
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #CLOTCOLF,D1
            TRAP #15
            
            ;DEFINE FILL LOCATION
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2      
            ADD.W   #CLTSIDEY,D2
            
            JSR FILL 
            
            JSR NECKI  

            ;DEFINE FILL LOCATION
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2      
            ADD.W   #CLTSIDEX*-1,D1
            ADD.W   #CLTSIDEX*-1/2,D1
            ADD.W   #CLTSIDEX*-1/4,D1
            ADD.W   #CLTSIDEY/16,D2     

            JSR FILL

            MOVEM.L (A7)+,D0-D4
            
            RTS
GUARDARXY
            MOVE.W  D3,DRAWX
            MOVE.W  D4,DRAWY
            RTS
FILL        
            ; FILL  
            MOVE.B  #89,D0
            TRAP    #15
            
            RTS
ELIPSE            
            ; DRAW ELIPSE
            MOVE.B  #88,D0
            TRAP    #15
            
            RTS
            
SQUARE
            ; DRAW SQUARE
            MOVE.B  #87,D0
            TRAP    #15
            
            RTS
            
LINE
            ; DRAW LINE
            MOVE.B  #84,D0
            TRAP    #15
            
            RTS
            
NECK        
            MOVEM.L D0-D4,-(A7)
            
            ;SET LINE COLOR FOR NECK
            MOVE.B #80,D0
            MOVE.L #NECKCOL,D1
            TRAP #15
            
            ;DEFINE COORDINATES OF A LINE1(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #NECKY,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE2(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX,D3
            ADD.W   #CLTSIDEX/4,D3
            ADD.W   #CLTSIDEX/16,D3
            MOVE.W  D2,D4
            ADD.W   #NECKY,D4
            ADD.W   #NECKY/2,D4
            ADD.W   #NECKY/8,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE3(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #NECKY,D4
            SUB.W   #NECKY/8,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE4(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            SUB.W   #2*CLTSIDEX,D3
            SUB.W   #CLTSIDEX/8,D3
            SUB.W   #CLTSIDEX/16,D3

            MOVE.W  D2,D4
            ADD.W   #NECKY/2,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;SET FILL COLOR FOR NECK
            MOVE.B #81,D0
            MOVE.L #NECKCOL,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR FILL1(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            ADD.W   #CLTSIDEX/8,D1
            SUB.W   #NECKY/4,D2
            
            JSR FILL
            
            ;DEFINE COORDINATES FOR FILL2(NECK)
            MOVE.W  (DRAWX),D1
            ADD.W   #CLTSIDEX,D1
            ADD.W   #CLTSIDEX/2,D1
            ADD.W   #CLTSIDEX/4,D1
            ADD.W   #CLTSIDEX/8,D1
            MOVE.W  (DRAWY),D2
            ADD.W   #NECKY/4,D2
            
            JSR FILL
            
            ;DEFINE COORDINATES FOR FILL3(NECK)
            MOVE.W  (DRAWX),D1
            ADD.W   #CLTSIDEX,D1
            ADD.W   #CLTSIDEX/2,D1
            ADD.W   #CLTSIDEX/4,D1
            ADD.W   #CLTSIDEX/8,D1
            MOVE.W  (DRAWY),D2
            SUB.W   #NECKY/4,D2
            
            JSR FILL
            
            ;DEFINE COORDINATES FOR THE RECTANGLE(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX,D3
            ADD.W   #CLTSIDEX/8,D3
            ADD.W   #CLTSIDEX/16,D3
            MOVE.W  D2,D4
            SUB.W   #NECKY/2,D4
            
            JSR SQUARE
            
            MOVEM.L (A7)+,D0-D4

            RTS

NECKI        
            MOVEM.L D0-D4,-(A7)
            
            ;SET LINE COLOR FOR NECK
            MOVE.B #80,D0
            MOVE.L #NECKCOL,D1
            TRAP #15
            
            ;DEFINE COORDINATES OF A LINE1(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #NECKY,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE2(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX*-1,D3
            ADD.W   #CLTSIDEX*-1/4,D3
            ADD.W   #CLTSIDEX*-1/16,D3
            MOVE.W  D2,D4
            ADD.W   #NECKY,D4
            ADD.W   #NECKY/2,D4
            ADD.W   #NECKY/8,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE3(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #NECKY,D4
            SUB.W   #NECKY/8,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;DEFINE COORDINATES OF A LINE4(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            SUB.W   #2*CLTSIDEX*-1,D3
            SUB.W   #CLTSIDEX*-1/8,D3
            SUB.W   #CLTSIDEX*-1/16,D3

            MOVE.W  D2,D4
            ADD.W   #NECKY/2,D4
            JSR GUARDARXY
            
            JSR LINE
            
            ;SET FILL COLOR FOR NECK
            MOVE.B #81,D0
            MOVE.L #NECKCOL,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR FILL1(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            ADD.W   #CLTSIDEX*-1/8,D1
            SUB.W   #NECKY/4,D2
            
            JSR FILL
            
            ;DEFINE COORDINATES FOR FILL2(NECK)
            MOVE.W  (DRAWX),D1
            ADD.W   #CLTSIDEX*-1,D1
            ADD.W   #CLTSIDEX*-1/2,D1
            ADD.W   #CLTSIDEX*-1/4,D1
            ADD.W   #CLTSIDEX*-1/8,D1
            MOVE.W  (DRAWY),D2
            ADD.W   #NECKY/4,D2
            
            JSR FILL
            
            ;DEFINE COORDINATES FOR FILL3(NECK)
            MOVE.W  (DRAWX),D1
            ADD.W   #CLTSIDEX*-1,D1
            ADD.W   #CLTSIDEX*-1/2,D1
            ADD.W   #CLTSIDEX*-1/4,D1
            ADD.W   #CLTSIDEX*-1/8,D1
            MOVE.W  (DRAWY),D2
            SUB.W   #NECKY/4,D2
            
            JSR FILL
            
            ;DEFINE COORDINATES FOR THE RECTANGLE(NECK)
            MOVE.W  (DRAWX),D1
            MOVE.W  (DRAWY),D2
            MOVE.W  D1,D3
            ADD.W   #2*CLTSIDEX*-1,D3
            ADD.W   #CLTSIDEX*-1/8,D3
            ADD.W   #CLTSIDEX*-1/16,D3
            MOVE.W  D2,D4
            SUB.W   #NECKY/2,D4
            
            JSR SQUARE
            
            MOVEM.L (A7)+,D0-D4

            RTS
            
HEAD       ; DRAW THE ENTIRE HEAD

            MOVEM.L D0-D5,-(A7)

            ;SET PEN COLOR
            MOVE.B #80,D0
            MOVE.L #HEADCOLC,D1             
            TRAP #15
            
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #HEADCOLF,D1
            TRAP #15

            ;DEFINE COORDINATES FOR THE HEAD
            MOVE.W  (PLYPOSX),D1
            SUB.W   #HEADRADX,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #HEADRADY,D2
            MOVE.W  D1,D3
            ADD.W   #2*HEADRADX,D3
            MOVE.W  D2,D4
            ADD.W   #2*HEADRADY,D4
            
            JSR ELIPSE
            
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #EYESCOLF,D1
            TRAP #15
            
            ;CHANGE EYES
            BTST.B #0,(DRAWFACE)
            BEQ NOEYE2
            
            ;DEFINE COORDINATES FOR THE LEFT EYE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #EYESRADX+1,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #EYESRADY,D2
            MOVE.W  D1,D3
            ADD.W   #2*EYESRADX+1,D3
            MOVE.W  D2,D4
            ADD.W   #2*EYESRADY+2,D4
            
            JSR ELIPSE  

            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #EYESCOLF,D1
            TRAP #15

            BRA CONTINUE
            
HEADI       ; DRAW THE ENTIRE HEAD INVERTED

            MOVEM.L D0-D5,-(A7)

            ;SET PEN COLOR
            MOVE.B #80,D0
            MOVE.L #HEADCOLC,D1             
            TRAP #15
            
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #HEADCOLF,D1
            TRAP #15

            ;DEFINE COORDINATES FOR THE HEAD
            MOVE.W  (PLYPOSX),D1
            SUB.W   #HEADRADX*-1,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #HEADRADY,D2
            MOVE.W  D1,D3
            ADD.W   #2*HEADRADX*-1,D3
            MOVE.W  D2,D4
            ADD.W   #2*HEADRADY,D4
            
            JSR ELIPSE
            
            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #EYESCOLF,D1
            TRAP #15
            
            ;CHANGE EYES
            BTST.B #0,(DRAWFACE)
            BEQ NOEYE2I
            
            ;DEFINE COORDINATES FOR THE LEFT EYE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #(EYESRADX*2-2),D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #EYESRADY,D2
            MOVE.W  D1,D3
            ADD.W   #(2*EYESRADX+1),D3
            MOVE.W  D2,D4
            ADD.W   #(2*EYESRADY+2),D4
            
            JSR ELIPSE  

            ;SET FILL COLOR
            MOVE.B #81,D0
            MOVE.L #EYESCOLF,D1
            TRAP #15

            BRA CONTINUEI

CONTINUE
            MOVE.W #5,D5
            BRA CENTRALEYE
NOEYE2
            MOVE.W #4,D5
            BRA CENTRALEYE
CONTINUEI
            MOVE.W #5,D5
            BRA CENTRALEYEI
NOEYE2I
            MOVE.W #4,D5
            BRA CENTRALEYEI
CENTRALEYE
            ;DEFINE COORDINATES FOR THE RIGTH EYE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #3*EYESRADX+2,D1
            ADDQ.W  #8,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #EYESRADY,D2
            ADD.W   D5,D1
            MOVE.W  D1,D3
            ADD.W   #2*EYESRADX,D3
            MOVE.W  D2,D4
            ADD.W   #2*EYESRADY,D4
            
            JSR ELIPSE

            ;SET HAT CONTOUR COLOR LIKE THE HAT FILL 
            MOVE.B #80,D0
            MOVE.L #HATCOLF,D1
            TRAP #15
            
            ;SET HAT FILL COLOR 
            MOVE.B #81,D0
            MOVE.L #HATCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE RECTANGLE(HAT)
            MOVE.W  (PLYPOSX),D1
            SUB.W   #HATSIDEX,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #4*HATSIDEY,D2
            MOVE.W  D1,D3
            ADD.W   #2*HATSIDEX,D3
            MOVE.W  D2,D4
            ADD.W   #2*HATSIDEY,D4
            
            JSR SQUARE
            
            ;SET HAT CONTOUR COLOR
            MOVE.B #80,D0
            MOVE.L #HATCOLC,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE ELIPSE(HAT)
            MOVE.W  (PLYPOSX),D1
            SUB.W   #HATSIDEX,D1
            SUB.W   #HATSIDEX/4,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #4*HATSIDEY,D2         
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX/4,D3
            MOVE.W  D2,D4
            ADD.W   #2*HATSIDEY,D4
            
            JSR ELIPSE
            
            ;DEFINE COORDINATES FOR THE ELIPSE(HAT)
            MOVE.W  (PLYPOSX),D1
            ADD.W   #HATSIDEX,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #4*HATSIDEY,D2         
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX/4,D3
            MOVE.W  D2,D4
            ADD.W   #2*HATSIDEY,D4
            
            JSR ELIPSE
            
            ;SET HAT CONTOUR COLOR LIKE THE HAT FILL 
            MOVE.B #80,D0
            MOVE.L #HATCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE RECTANGLE(HAT)
            MOVE.W  (PLYPOSX),D1
            ADD.W   #HATSIDEX,D1
            ADD.W   #HATSIDEX/16,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #3*HATSIDEY,D2
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX,D3
            MOVE.W  D2,D4
            ADD.W   #HATSIDEY,D4
            
            JSR SQUARE
           
            ;SET HAT CONTOUR COLOR
            MOVE.B #80,D0
            MOVE.L #HATCOLC2,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE ELIPSE(HAT)
            MOVE.W  (PLYPOSX),D1
            ADD.W   #HATSIDEX,D1
            ADD.W   #HATSIDEX/2,D1
            ADD.W   #HATSIDEX/4,D1
            ADD.W   #HATSIDEX/16,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #3*HATSIDEY,D2
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX/2,D3
            MOVE.W  D2,D4
            ADD.W   #HATSIDEY,D4
            
            JSR ELIPSE
            
            MOVEM.L (A7)+,D0-D5
            
            RTS

CENTRALEYEI
            ;DEFINE INVERTED COORDINATES FOR THE RIGTH EYE
            MOVE.W  (PLYPOSX),D1
            SUB.W   #(3*EYESRADX*4-2),D1
            ADDQ.W  #8,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #EYESRADY,D2
            ADD.W   D5,D1
            MOVE.W  D1,D3
            ADD.W   #2*EYESRADX,D3
            MOVE.W  D2,D4
            ADD.W   #2*EYESRADY,D4
            
            JSR ELIPSE

            ;SET HAT CONTOUR COLOR LIKE THE HAT FILL 
            MOVE.B #80,D0
            MOVE.L #HATCOLF,D1
            TRAP #15
            
            ;SET HAT FILL COLOR 
            MOVE.B #81,D0
            MOVE.L #HATCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE RECTANGLE(HAT)
            MOVE.W  (PLYPOSX),D1
            SUB.W   #HATSIDEX*-1,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #4*HATSIDEY,D2
            MOVE.W  D1,D3
            ADD.W   #2*HATSIDEX*-1,D3
            MOVE.W  D2,D4
            ADD.W   #2*HATSIDEY,D4
            
            JSR SQUARE
            
            ;SET HAT CONTOUR COLOR
            MOVE.B #80,D0
            MOVE.L #HATCOLC,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE ELIPSE(HAT)
            MOVE.W  (PLYPOSX),D1
            SUB.W   #HATSIDEX*-1,D1
            SUB.W   #HATSIDEX*-1/4,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #4*HATSIDEY,D2         
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX*-1/4,D3
            MOVE.W  D2,D4
            ADD.W   #2*HATSIDEY,D4
            
            JSR ELIPSE
            
            ;DEFINE COORDINATES FOR THE ELIPSE(HAT)
            MOVE.W  (PLYPOSX),D1
            ADD.W   #HATSIDEX*-1,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #4*HATSIDEY,D2         
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX*-1/4,D3
            MOVE.W  D2,D4
            ADD.W   #2*HATSIDEY,D4
            
            JSR ELIPSE
            
            ;SET HAT CONTOUR COLOR LIKE THE HAT FILL 
            MOVE.B #80,D0
            MOVE.L #HATCOLF,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE RECTANGLE(HAT)
            MOVE.W  (PLYPOSX),D1
            ADD.W   #HATSIDEX*-1,D1
            ADD.W   #HATSIDEX*-1/16,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #3*HATSIDEY,D2
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX*-1,D3
            MOVE.W  D2,D4
            ADD.W   #HATSIDEY,D4
            
            JSR SQUARE
           
            ;SET HAT CONTOUR COLOR
            MOVE.B #80,D0
            MOVE.L #HATCOLC2,D1
            TRAP #15
            
            ;DEFINE COORDINATES FOR THE ELIPSE(HAT)
            MOVE.W  (PLYPOSX),D1
            ADD.W   #HATSIDEX*-1,D1
            ADD.W   #HATSIDEX*-1/2,D1
            ADD.W   #HATSIDEX*-1/4,D1
            ADD.W   #HATSIDEX*-1/16,D1
            MOVE.W  (HEADPOSY),D2
            SUB.W   #3*HATSIDEY,D2
            MOVE.W  D1,D3
            ADD.W   #HATSIDEX*-1/2,D3
            MOVE.W  D2,D4
            ADD.W   #HATSIDEY,D4
            
            JSR ELIPSE
            
            MOVEM.L (A7)+,D0-D5
            
            RTS






*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
