onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /reg_shift_b/clk
add wave -noupdate /reg_shift_b/rst
add wave -noupdate /reg_shift_b/ena
add wave -noupdate -divider Inputs
add wave -noupdate /reg_shift_b/B_in
add wave -noupdate -divider Signals
add wave -noupdate /reg_shift_b/shift_ena
add wave -noupdate -divider Register
add wave -noupdate /reg_shift_b/b_arrange
add wave -noupdate /reg_shift_b/b_reg_nxt
add wave -noupdate /reg_shift_b/b_hold
add wave -noupdate /reg_shift_b/b_reg
add wave -noupdate -divider Outputs
add wave -noupdate /reg_shift_b/B_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {32904 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 211
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {26135 ps}
