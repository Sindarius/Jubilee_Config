G90 				;Absolute 
G0 X150 Y150 F30000 ;Go to center and move z down a little bit
M400                ;Wait for moves to complete
G4 P500				;Dwell 500ms

;Turn on HCL #50
M569 P50.0 D4       ;Turn on Closed Loop Mode
M569.6 P50.0 V31    ;Perform tuning move

G4 P500				;Dwell 500ms
;Turn on HCL #51
M569 P51.0 D4       ;Turn on Closed Loop Mode
M569.6 P51.0 V31    ;Perform tuning move