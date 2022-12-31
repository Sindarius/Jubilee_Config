T-1         ; desect current tool
G90
G0 Z305 F500 ; move bed all the way to the bottom
M568 P0 R0 S0 A0
M568 P1 R0 S0 A0
M568 P2 R0 S0 A0
M568 P3 R0 S0 A0
M140 S0 ; turn off bed
G0 X0 Y0 F30000; return home
M84 S600; disable motors after ten mins of inactivity

