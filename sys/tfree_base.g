; tfree0.g
; Runs at the start of a toolchange if the current tool is tool-0.
; Note: tool offsets are applied at this point unless we preempt commands with G53!

G91                          ; Relative Mode.
G1 Z2                        ; Pop Z up slightly so we don't crash while traveling over the usable bed region.
if state.status == "processing" ;Only do this if we are printing
	G1 E-18 F400 				;Retract filament 18mm
	M106 S0						;Turn off part fan
G90                          ; Absolute Mode.



G53 G0 X{param.X} F12000     ; Rapid to the back of the post. Stay away from the tool rack so we don't collide with tools.
G53 G0 Y{param.Y} F12000     ; This position must be chosen such that the most protruding y face of the current tool
                             ; (while on the carriage) does not collide with the most protruding y face of any parked tool.

G53 G1 Y335.2 F6000            ; Controlled move to the park position with tool-1. (park_x, park_y)
M98 P"/macros/tool_unlock.g" ; Unlock the tool
G53 G1 Y300 F6000            ; Retract the pin.

