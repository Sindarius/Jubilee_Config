echo >"z_offsets.g" ";Z Offsets"
var count = 0
while(var.count < 4)
	echo >>"z_offsets.g" "G10 P" ^ {var.count} ^ " Z"  ^ {tools[var.count].offsets[2]}
	set var.count = var.count + 1
M117 "Z Saved"