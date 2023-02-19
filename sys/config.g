; Jubilee CoreXY ToolChanging Printer - Config File
; This file intended for Duet 3 hardware, main board plus onr expansion boards

;Notes facing from rear of machine
; 50.0 X 51.0 Y  Left and Right 1HCL 
; 0.4 Front Right 297.5 313.5
; 0.3 Back        150 -16.5
; 0.2 Front Left  2.5 313.5


; Name and network
; This is configured from the connected Raspberry Pi or here if in stand alone
; mode
;-------------------------------------------------------------------------------
; Networking
M550 P"Jubilee"           ; Name used in ui and for mDNS  http://Jubilee.local
;M552 P192.168.10.14 S1          ; Use Ethernet with a static IP, 0.0.0.0 for dhcp
M552 P0.0.0.0 S1          ; Use Ethernet with a static IP, 0.0.0.0 for dhcp
M553 P255.255.255.0       ; Netmask
;M554 192.168.2.1          ; Gateway

global versionnumber = "1.4T8"

; General setup
;-------------------------------------------------------------------------------
M111 S0                    ; Debug off 
M929 P"eventlog.txt" S1    ; Start logging to file eventlog.txt

; General Preferences
M555 P2                    ; Set Marlin-style output
G21                        ; Set dimensions to millimetres
G90                        ; Send absolute coordinates...
M83                        ; ...but relative extruder moves
G4 S5

; Stepper mapping
;-------------------------------------------------------------------------------

;Configure Closed Loop 
M569.1 P50.0 R80 I3000 D0.12 T2 C1000 H80 S200        ; Drive 0 | X stepper 1000PPR
M569.1 P51.0 R80 I3000 D0.12 T2 C1000 H80 S200         ; Drive 1 | Y Stepper 1000PPR

;Configure Stepper

;## XY ##
M569 P50.0 D2 S1                 ; Drive 0 | X stepper Start in SpreadCycle
M569 P51.0 D2 S1                 ; Drive 1 | Y Stepper Start in SpreadCycle

;M584 X50.0:51.0                ; (Single X Test for Closed Loop Plugin)
M584 X50.0 Y51.0                ; X and Y for CoreXY

M906 X1500 ;{0.9*sqrt(2)*2000}  ; LDO XY 2000mA RMS the TMC5160 driver on duet3
M906 Y1500 ;{0.9*sqrt(2)*2000}  ; generates a sinusoidal coil current so we can 
                          ; multply by sqrt(2) to get peak used for M906
                          ; Do not exceed 90% without heatsinking the XY 
                          ; steppers.
M917 X100 Y100                       ;Hold Current						  

;## U - Tool Lock##
M584 U0.0                       ; U for toolchanger lock                                    
M569 P0.0 S0                  ; Drive 0 | U Tool Changer Lock  670mA
M906 U{0.7*sqrt(2)*670} I70 ; 70% of 670mA RMS idle 60%
                            ; Note that the idle will be shared for all drivers

;## Z - Check Motor Order - Facing from board side of the machine## 
M584 Z0.2:0.3:0.4               ; Z has three drivers for kinematic bed suspension. 
M569 P0.2 S0                ; Drive 2 | Front Left Z
M569 P0.3 S0                ; Drive 3 | Back
M569 P0.4 S0                ; Drive 4 | Front Right
;M906 Z{0.7*sqrt(2)*1680}  ; 70% of 1680mA RMS
M906 Z1200  ; 70% of 1680mA RMS


;## TOOLS T0 = 20
M584 E20.0:21.0:22.0:23.0    ;Extruder
M569 P20.0 S1 D2 ; Direction
M569 P21.0 S0 D2;Reversed the wiring on this one
M569 P22.0 S1 D2; Direction
M569 P23.0 S1 D2 ; Direction

;#tool movement (4 tools)
M350 E16:16:16:16 I1           ;microstepping
M92 E676.2:676.2:676.2:676.2			  ;steps
M203 E7200:7200:7200:7200            ;max feed rate
M566 E700:700:700:700             ;jerk
M201 E10000:10000:10000:10000           ;max accel
M906 E1000:1000:1000:1000 I90        ;Current (I Idle%)
;M572 D0:1:2:3 S0.04            ;Pressure Advance
M572 D0:1:2:3 S0.02


; Kinematics
;-------------------------------------------------------------------------------
M669 K1                   ; CoreXY mode

; Kinematic bed ball locations.
; Locations are extracted from CAD model assuming lower left build plate corner
; is (0, 0) on a 305x305mm plate.
M671 x297.5:150:2.5 y313.5:-16.5:313.5 S10 ; Front Left: (297.5, 313.5)
                                           ; Front Right: (2.5, 313.5)
                                           ; Back: (150, -16.5)
                                           ; Up to 10mm correction


; Probing
;M557 X25:275 Y25:275 P7
M557 X25:275 Y25:275 P3 


; Axis and motor configuration 
;-------------------------------------------------------------------------------

M350 X1 Y1 Z1 U1  ; Disable microstepping to simplify calculations

;M92 X{1/(0.9*16/180)}  ; step angle * tooth count / 180
;M92 Y{1/(0.9*16/180)}  ; The 2mm tooth spacing cancel out with diam to radius
M92 X{1/(1.8*16/180)}  ; step angle * tooth count / 180
M92 Y{1/(1.8*16/180)}  ; The 2mm tooth spacing cancel out with diam to radius


M92 Z{360/0.9/4}       ; 0.9 deg stepper / lead (2mm) of screw  4 start vs 2 start
M92 U{13.76/1.8}       ; gear ration / step angle for tool lock geared motor.
;M92 E51.875            ; Extruder - BMG 0.9 deg/step

; Enable microstepping all step per unit will be multiplied by the new step def
M350 X32 Y32 I1        ; 32x microstepping for CoreXY axes. Use interpolation. 32X to take advantage of closed loop motors
M350 U4 I1             ; 4x for toolchanger lock. Use interpolation.
M350 Z16 I1            ; 16x microstepping for Z axes. Use interpolation.
;M350 E16:16 I1         ; 16x microstepping for Extruder axes. Use interpolation.

; Speed and acceleration (X/Y/Z)
;-------------------------------------------------------------------------------
M201 X8000 Y8000                        ; Accelerations (mm/s^2) 11000 default
M201 Z100                               ; LDO ZZZ Acceleration
M201 U800                               ; LDO U Accelerations (mm/s^2)

M203 X20000 Y20000 Z800 U9000     ; Maximum axis speeds (mm/min)
;M566 X700 Y700 Z500 U50           ; Maximum jerk speeds (mm/min)
M566 X400 Y400 Z500 U50           ; Maximum jerk speeds (mm/min)



; Endstops and probes 
;-------------------------------------------------------------------------------
; Connected to the MB6HC as the table below.
; | U | Z |
; | X |
; | Y |

M574 U1 S1 P"^io0.in"  ; homing position U1 = low-end, type S1 = switch
M574 X1 S1 P"^io1.in"  ; homing position X1 = low-end, type S1 = switch
M574 Y1 S1 P"^io3.in"  ; homing position Y1 = low-end, type S1 = switch

M574 Z0                ; we will use the switch as a Z probe not endstop 
;M558 P8 C"io2.in" H3 F360 T6000 ; H = dive height F probe speed T travel speed
M98 P"set_z_probe.g"

;Moved to set_z_probe.g
;G31 K0 X0 Y0 Z-2    ; Set the limit switch position as the  "Control Point."
                    ; Note: the switch free (unclicked) position is 7.2mm,
                    ; but the operating position (clicked) is 6.4 +/- 0.2mm. 
                    ; A 1mm offset (i.e: 7.2-6.2 = 1mm) would be the 
                    ; Z to worst-case free position, but we add an extra 1mm
                    ; such that XY travel moves across the bed when z=0
                    ; do *not* scrape or shear the limit switch.

; Set axis software limits and min/max switch-triggering positions.
; Adjusted such that (0,0) lies at the lower left corner of a 300x300mm square 
; in the 305mmx305mm build plate.
M208 X-13.75:313.75 Y-44:341 Z0:295
M208 U0:200            ; Set Elastic Lock (U axis) max rotation angle

;# GLOBALS
if exists(global.fanCount)
	set global.fanCount = -1
else
	global fanCount = -1

if exists(global.heaterIndex)
	set global.heaterIndex = 0
else 
	global heaterIndex = 0 ;Bed is at zero

global stopProcess = false
global daemonLoop = true;

; Heaters and temperature sensors
;-------------------------------------------------------------------------------

; Bed
M308 S0 P"temp0" Y"thermistor" T100000 B3950 A"Bed" ; Keenovo thermistor
M950 H0 C"out0" T0                  ; H = Heater 0
                                    ; C is output for heater itself
                                    ; T = Temperature sensor
M143 H0 S130                        ; Set maximum temperature for bed to 130C    
M307 H0 A589.8 C589.8 D20.2 V24.1 B0 ; Keenovo 750w 230v built in thermistor
                                    ; mandala rose bed
M140 H0                             ; Assign H0 to the bed

;There appears to be a 0.10 offset after probing with knobprobe that needs to be accounted for. Trigger offset?
M98 P"Tools/BabyBullet.g" B20 T0 S"Tool 0" ;X0.03 Y33.03  Z-4.891
M98 P"Tools/BabyBullet.g" B21 T1 S"Tool 1" ;X0.16 Y33.01 Z-4.579
M98 P"Tools/BabyBullet.g" B22 T2 S"Tool 2" ;X-0.1 Y32.95 Z-4.608
M98 P"Tools/BabyBullet.g" B23 T3 S"Tool 3" ;X-0.314 Y32.853 Z-4.686

;M308 S20 P"20.temp1" Y"thermistor" T100000 B4725 C7.06e-8 A"Test" ;Thermistor

;Accel
M955 P20.0 I54

;Pebble Wiper
;---------------------------------------------------------------------------------
;M950 F10 C"^0.out6" Q600					;Wipe Servo
;M106 P10 C"Wipe" 					;Wipe Servo




M501                        ; Load saved parameters from non-volatile memory


;PRINT SETTINGS
;M207 S0.2 F7200 Z0.1  ;Firmware retraction
M207 S0.5 F7200 Z0.1
;M593 P"zvdd" F48.0 ;Input Shaping


M98 P"xy_offsets.g"
M98 P"z_offsets.g"

;Builder3D Testing
;M950 P1 C"out6" Q0 ; door lock output
;M950 J0 C"!^io6.in" ; door status input ; changed from io4.in to io5.in


M586 C"*"

;CAN Triggers
M950 J2 C"20.button0"
M581 P2 T2 R2
M950 J3 C"20.button1"
M581 P3 T3 R2

M950 J4 C"21.button0"
M581 P4 T4 R2
M950 J5 C"21.button1"
M581 P5 T5 R2

M950 J6 C"22.button0"
M581 P6 T6 R2
M950 J7 C"22.button1"
M581 P7 T7 R2

M950 J8 C"23.button0"
M581 P8 T8 R2
M950 J9 C"23.button1"
M581 P9 T9 R2


;Testing Delta
; General preferences
;M665 R105.6 L215.0 B85 H235     ; set delta radius, diagonal rod length, printable radius and homed height
;M666 X0 Y0 Z0                   ; put your endstop adjustments here
;M665 L160.000:160.000:160.000 R81.000 H173.674 B80; Set delta radius, diagonal rod length, printable radius and homed height
;M666 X0.909 Y-0.405 Z-0.504                    ; Put your endstop adjustments here, or let auto calibration find them
