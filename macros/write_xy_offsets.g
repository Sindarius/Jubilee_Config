echo >"xy_offsets.g" ";Offsets"
var count = 0
while(var.count < 4)
	echo >>"xy_offsets.g" "G10 P" ^ {var.count} ^  " X"  ^ {tools[var.count].offsets[0]} ^ " Y" ^ {tools[var.count].offsets[1]}
	set var.count = var.count + 1
M117 "XY Saved"