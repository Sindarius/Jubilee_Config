;## Create Air Print Tool with safe offset
;## Juan Rosario (Sindarius)
;## Expected Params
;## Tool : T# 
;## Offsets X Y Z 
;## S - Name

var x = 0
var y = 0
var z = 0
var s = "Tool"
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
	
echo param.T ^ " " ^ var.x ^ " " ^ var.y ^ " " ^ var.z 

M563 P{param.T} S{var.s}
G10 L1 P{param.T} X{var.x} Y{var.y} Z{var.z}