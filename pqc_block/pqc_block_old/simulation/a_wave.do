onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /load_a/clk
add wave -noupdate /load_a/rst
add wave -noupdate /load_a/pe_ena
add wave -noupdate -divider Inputs
add wave -noupdate /load_a/A_in
add wave -noupdate -radix decimal /load_a/a0
add wave -noupdate -divider Signals
add wave -noupdate -radix decimal /load_a/a_now
add wave -noupdate /load_a/count
add wave -noupdate /load_a/count_nxt
add wave -noupdate -divider a0_shift
add wave -noupdate /load_a/a0_sel
add wave -noupdate /load_a/a0_shift_ena
add wave -noupdate -radix decimal /load_a/a0_shift_nxt
add wave -noupdate -radix decimal /load_a/a0_shift
add wave -noupdate -divider a0
add wave -noupdate -radix decimal /load_a/a0_pass
add wave -noupdate -divider aN
add wave -noupdate /load_a/aN_sel
add wave -noupdate -radix decimal /load_a/aN_nxt
add wave -noupdate -radix decimal /load_a/aN
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /load_a/A_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42880 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 171
configure wave -valuecolwidth 173
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
WaveRestoreZoom {0 ps} {155576 ps}
