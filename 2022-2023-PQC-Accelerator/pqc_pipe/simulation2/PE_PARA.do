onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pe_chain/clk
add wave -noupdate /pe_chain/ena
add wave -noupdate /pe_chain/rst
add wave -noupdate -divider Inputs
add wave -noupdate /pe_chain/A0
add wave -noupdate /pe_chain/B
add wave -noupdate -divider Holds
add wave -noupdate /pe_chain/A
add wave -noupdate /pe_chain/A_hold
add wave -noupdate /pe_chain/B_hold
add wave -noupdate /pe_chain/C
add wave -noupdate -divider MUX
add wave -noupdate /pe_chain/A_sel
add wave -noupdate /pe_chain/A_mux2pe
add wave -noupdate /pe_chain/B_sel
add wave -noupdate /pe_chain/B_mux2pe
add wave -noupdate -divider Outputs
add wave -noupdate /pe_chain/A_out
add wave -noupdate /pe_chain/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {2213 ps}
