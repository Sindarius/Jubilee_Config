; Home X Axis

; In case homex.g is called in isolation, ensure 
; (1) U axis is homed (which performs tool detection and sets machine tool state to a known state) and 
; (2) Y axis is homed (to prevent collisions with the tool posts)
; (3) Y axis is in a safe position (see 2)
; (4) No tools are loaded.
; Ask for user-intervention if either case fails.

G91                     ; Relative mode
G1 H2 Z5 F5000          ; Lower the bed
G1 Y20 F5000
G1 X-330 F3000 H1       ; Big negative move to search for endstop
G1 X4 F600              ; Back off the endstop
G1 X-10 F600 H1         ; Find endstop again slowly
G1 X20 F600          ; Find endstop again slowly
G1 Y-20 F5000
G1 H2 Z-5 F5000         ; Raise the bed
G90                     ; Set absolute mode
