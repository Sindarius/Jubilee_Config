;if exists(param.X) & exists(param.Y) & exists(param.U) & exists(param.V)
;	M557 X{param.X}^":"^{param.U} Y{param.U}^":"^{param.V} P7

G91 ; relative moves
G1 Z1 F900 ; raise tool 1mm
G90 ; absolute moves
T-1 ; Make sure nothing is parked on the carriage
G0 X150 Y150 F10000; Move to the center of the print area
M558 F500  ; Set the probing speed
G30 ; Do a single probe
M558 F15  ; Set the probing speed
G30 ; Do a second probe
M98 P"set_z_probe_fast.g"
G29 S0 ;Probe bed
G29 S1 ;Load and enable mesh bed