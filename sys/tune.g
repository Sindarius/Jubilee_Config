G91 
G0 Z10 F6000

G90 				;Absolute 

;Configure Closed Loop 



G0 X150 Y150 F30000 ;Go to center and move z down a little bit
M400                ;Wait for moves to complete
G4 P500				;Dwell 500ms

;Turn on HCL #50
;M569.1 P50.0 R80 I3000 D0.12 T2 C1000 H80 S200        ; Drive 0 | X stepper 1000PPR
M569 P50.0 D4       ;Turn on Closed Loop Mode
M569.6 P50.0 V1    ;Perform tuning move

G4 P500				;Dwell 500ms
;Turn on HCL #51
;M569.1 P51.0 R80 I3000 D0.12 T2 C1000 H80 S200         ; Drive 1 | Y Stepper 1000PPR
M569 P51.0 D4       ;Turn on Closed Loop Mode
M569.6 P51.0 V1    ;Perform tuning move

G4 P500				;Dwell 500ms

G91 
G0 Z-10 F6000
G90