; Home y, x, z, and Toolchanger Lock axes

;Disable Closed Loop While homing
M569 P50.0 D3
M569 P51.0 D3

M98 P"homeu.g" ; X and Z require U to be homed first in case a tool is currently active
M98 P"homey.g"
M98 P"homex.g"
M98 P"homez.g"
;M98 P"tune.g"