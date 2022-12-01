onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /reg_shift_a/clk
add wave -noupdate /reg_shift_a/rst
add wave -noupdate /reg_shift_a/ena
add wave -noupdate -divider Inputs
add wave -noupdate /reg_shift_a/A_in
add wave -noupdate -divider Signals
add wave -noupdate /reg_shift_a/a0
add wave -noupdate /reg_shift_a/count
add wave -noupdate /reg_shift_a/count_nxt
add wave -noupdate -divider Register
add wave -noupdate /reg_shift_a/a_sel
add wave -noupdate /reg_shift_a/a_now
add wave -noupdate /reg_shift_a/a_wire
add wave -noupdate /reg_shift_a/aN
add wave -noupdate -divider Outputs
add wave -noupdate /reg_shift_a/A_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {47454 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 542
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
WaveRestoreZoom {0 ps} {210 ns}
