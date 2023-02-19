M290 R0 S0                 ; Reset baby stepping
M561                       ; Disable any Mesh Bed Compensation
G0 F12000

;G30 P0 X152.5 Y5 Z-99999   ; probe near back leadscrew
;G30 P1 X295 Y295 Z-99999   ; probe near front left leadscrew
;G30 P2 X5 Y295 Z-99999 S3  ; probe near front right leadscrew and calibrate 3 motors
M98 P"set_z_probe_fast.g"
;Backup before tip broke
while true
    G30 P0 X295 Y65 Z-99999   ; probe near back leadscrew
    G30 P1 X5 Y65 Z-99999   ; probe near back leadscrew
    G30 P2 X295 Y285 Z-99999   ;Probe front corner
    G30 P3 X5 Y285 Z-99999 S3  
    if abs(move.calibration.initial.mean) < 0.01 || iterations > 5
        break;
M98 P"set_z_probe_slow.g"