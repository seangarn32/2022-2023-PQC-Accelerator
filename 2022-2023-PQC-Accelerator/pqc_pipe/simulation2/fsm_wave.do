onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /fsm/clk
add wave -noupdate /fsm/rst
add wave -noupdate /fsm/ena
add wave -noupdate -divider Counter
add wave -noupdate /fsm/counter_ena
add wave -noupdate /fsm/counter_rst
add wave -noupdate /fsm/count
add wave -noupdate -divider Signals
add wave -noupdate /fsm/state
add wave -noupdate /fsm/state_nxt
add wave -noupdate /fsm/sel_hold
add wave -noupdate /fsm/sel_nxt
add wave -noupdate -divider Outputs
add wave -noupdate /fsm/dsi_ena
add wave -noupdate /fsm/pe_ena
add wave -noupdate /fsm/accum_ena
add wave -noupdate /fsm/dso_ena
add wave -noupdate /fsm/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {875 ps}
