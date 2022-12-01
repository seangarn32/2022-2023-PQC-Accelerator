onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /load_a/clk
add wave -noupdate /load_a/rst
add wave -noupdate /load_a/dsi_ena
add wave -noupdate /load_a/pe_ena
add wave -noupdate -divider Signals
add wave -noupdate /load_a/reg_ena
add wave -noupdate -divider Inputs
add wave -noupdate -radix decimal /load_a/A_in
add wave -noupdate -radix decimal /load_a/a_signed
add wave -noupdate -radix unsigned /load_a/a_sel
add wave -noupdate -divider Registers
add wave -noupdate -radix decimal /load_a/a_reg_in(0)
add wave -noupdate -radix decimal /load_a/a_reg_in(1)
add wave -noupdate -radix decimal /load_a/a_reg_in(2)
add wave -noupdate -radix decimal /load_a/a_reg_in(3)
add wave -noupdate -radix decimal /load_a/a_reg_in(4)
add wave -noupdate -radix decimal /load_a/a_reg_in(5)
add wave -noupdate -radix decimal /load_a/a_reg_in(6)
add wave -noupdate -radix decimal /load_a/a_reg_in(7)
add wave -noupdate -radix decimal /load_a/a_reg_in(8)
add wave -noupdate -radix decimal /load_a/a_reg_in(9)
add wave -noupdate -radix decimal /load_a/a_reg_in(10)
add wave -noupdate -radix decimal /load_a/a_reg_in(11)
add wave -noupdate -radix decimal /load_a/a_reg_in(12)
add wave -noupdate -radix decimal /load_a/a_reg_in(13)
add wave -noupdate -radix decimal /load_a/a_reg_in(14)
add wave -noupdate -radix decimal /load_a/a_reg_in(15)
add wave -noupdate -radix decimal /load_a/a_reg_out(0)
add wave -noupdate -radix decimal /load_a/a_reg_out(1)
add wave -noupdate -radix decimal /load_a/a_reg_out(2)
add wave -noupdate -radix decimal /load_a/a_reg_out(3)
add wave -noupdate -radix decimal /load_a/a_reg_out(4)
add wave -noupdate -radix decimal /load_a/a_reg_out(5)
add wave -noupdate -radix decimal /load_a/a_reg_out(6)
add wave -noupdate -radix decimal /load_a/a_reg_out(7)
add wave -noupdate -radix decimal /load_a/a_reg_out(8)
add wave -noupdate -radix decimal /load_a/a_reg_out(9)
add wave -noupdate -radix decimal /load_a/a_reg_out(10)
add wave -noupdate -radix decimal /load_a/a_reg_out(11)
add wave -noupdate -radix decimal /load_a/a_reg_out(12)
add wave -noupdate -radix decimal /load_a/a_reg_out(13)
add wave -noupdate -radix decimal /load_a/a_reg_out(14)
add wave -noupdate -radix decimal /load_a/a_reg_out(15)
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /load_a/A_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15795 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 203
configure wave -valuecolwidth 340
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
WaveRestoreZoom {0 ps} {64750 ps}
