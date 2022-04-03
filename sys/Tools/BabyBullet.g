;## Create Baby Bulet Tool with safe offset
;## Juan Rosario (Sindarius)
;## Expected Params
;## Tool : T# 
;## Offsets X Y Z 
;## S - Name

var x = 0 ; X Offset 
var y = 0 ; YOffset
var z = 0 ; ZOffset
var s = "Tool" ;Tool Name
var t = -1;  ;Tool Index
var b = -1 ;Tool Board Index

echo "Start"

if !exists(param.T)
	echo "Tool not specified"
	abort

if exists(param.X)
	set var.x = param.X

if exists(param.Y)
	set var.y = param.Y
	
if exists(param.Z)
	set var.z = param.Z
	
if exists(param.S)
	set var.s = param.S


if !exists(param.B)
	abort "Board ID not specified"
	

;#Heaters
var heater = param.B ^ ".out0"
var heaterIndex = global.heaterIndex + 1

var temp = param.B ^ ".temp0"
var heaterName = "Hot End " ^ param.T

M308 S{var.heaterIndex} P{var.temp} Y"thermistor" T100000 B4725 C7.06e-8 A{var.heaterName} ;Thermistor
M950 H{var.heaterIndex} C{var.heater} T{var.heaterIndex}                              ;Heater
M307 H{var.heaterIndex} B0 S1.0
M143 H{var.heaterIndex} S265

;#Fans
var fan0 = param.B ^ ".out1" ;Hotend Fan
var fan0Index = global.fanCount + 1
var fan1 = param.B ^ ".out2" ;Part Fan
var fan1Index = global.fanCount + 2

M950 F{var.fan0Index} C{var.fan0}
M106 P{var.fan0Index} S0 C{"Part Fan " ^ param.T}
M950 F{var.fan1Index} C{var.fan1}
M106 P{var.fan1Index} S1 H{var.heaterIndex} T60 C{"Hotend Fan " ^ param.T}


;#Define Tools
var extruder = param.B ^ ".0"

M563 P{param.T} S{var.s} H{var.heaterIndex} F{var.fan0Index} D{param.T} 
G10 L1 P{param.T} X{var.x} Y{var.y} Z{var.z}

;#Update globals
set global.heaterIndex = global.heaterIndex + 1
set global.fanCount = global.fanCount + 2

