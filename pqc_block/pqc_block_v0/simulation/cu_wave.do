onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /control_unit/clk
add wave -noupdate /control_unit/rst
add wave -noupdate /control_unit/ena
add wave -noupdate -divider state
add wave -noupdate -radix unsigned /control_unit/count
add wave -noupdate -radix unsigned /control_unit/count_nxt
add wave -noupdate /control_unit/state
add wave -noupdate /control_unit/state_nxt
add wave -noupdate -divider A_sel
add wave -noupdate -radix unsigned /control_unit/count_a_sel
add wave -noupdate -radix unsigned /control_unit/count_a_sel_nxt
add wave -noupdate -radix unsigned /control_unit/a_sel
add wave -noupdate -radix unsigned /control_unit/a_sel_nxt
add wave -noupdate -divider Outputs
add wave -noupdate /control_unit/dsi_ena
add wave -noupdate /control_unit/bl_ena
add wave -noupdate /control_unit/pe_ena
add wave -noupdate /control_unit/accum_ena
add wave -noupdate /control_unit/dso_ena
add wave -noupdate /control_unit/a_selout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {451916 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
configure wave -valuecolwidth 141
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
WaveRestoreZoom {0 ps} {1575 ns}
