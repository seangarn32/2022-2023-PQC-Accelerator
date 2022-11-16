onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pe_accum/clk
add wave -noupdate /pe_accum/rst
add wave -noupdate /pe_accum/ena
add wave -noupdate -divider Inputs
add wave -noupdate -radix decimal /pe_accum/d
add wave -noupdate -divider Signals
add wave -noupdate -radix decimal /pe_accum/count
add wave -noupdate -radix decimal /pe_accum/count_nxt
add wave -noupdate -radix decimal /pe_accum/sum_sel
add wave -noupdate -divider sum
add wave -noupdate -radix decimal /pe_accum/sum_zero
add wave -noupdate -radix decimal /pe_accum/sum
add wave -noupdate -radix decimal /pe_accum/sum_with
add wave -noupdate -radix decimal /pe_accum/sum_nxt
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pe_accum/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1409 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 157
configure wave -valuecolwidth 142
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
WaveRestoreZoom {0 ps} {31159 ps}
