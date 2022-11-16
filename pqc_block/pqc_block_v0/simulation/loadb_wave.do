onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /load_b/clk
add wave -noupdate /load_b/rst
add wave -noupdate /load_b/dsi_ena
add wave -noupdate /load_b/pe_ena
add wave -noupdate -divider Signals
add wave -noupdate /load_b/reg_ena
add wave -noupdate -divider Inputs
add wave -noupdate -radix decimal /load_b/B_in
add wave -noupdate -divider Registers
add wave -noupdate -radix decimal /load_b/b_reg_in(0)
add wave -noupdate -radix decimal /load_b/b_reg_in(1)
add wave -noupdate -radix decimal /load_b/b_reg_in(2)
add wave -noupdate -radix decimal /load_b/b_reg_in(3)
add wave -noupdate -radix decimal /load_b/b_reg_in(4)
add wave -noupdate -radix decimal /load_b/b_reg_in(5)
add wave -noupdate -radix decimal /load_b/b_reg_in(6)
add wave -noupdate -radix decimal /load_b/b_reg_in(7)
add wave -noupdate -radix decimal /load_b/b_reg_out(0)
add wave -noupdate -radix decimal /load_b/b_reg_out(1)
add wave -noupdate -radix decimal /load_b/b_reg_out(2)
add wave -noupdate -radix decimal /load_b/b_reg_out(3)
add wave -noupdate -radix decimal /load_b/b_reg_out(4)
add wave -noupdate -radix decimal /load_b/b_reg_out(5)
add wave -noupdate -radix decimal /load_b/b_reg_out(6)
add wave -noupdate -radix decimal /load_b/b_reg_out(7)
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /load_b/B_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {178447 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
configure wave -valuecolwidth 209
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
WaveRestoreZoom {0 ps} {609 ns}
