onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /data_shift_in/clk
add wave -noupdate /data_shift_in/rst
add wave -noupdate /data_shift_in/dsi_ena
add wave -noupdate /data_shift_in/pe_ena
add wave -noupdate -divider Inputs
add wave -noupdate /data_shift_in/a_in
add wave -noupdate /data_shift_in/b_in
add wave -noupdate -divider Process
add wave -noupdate -radix unsigned /data_shift_in/count
add wave -noupdate -radix unsigned /data_shift_in/count_nxt
add wave -noupdate /data_shift_in/shift_ena
add wave -noupdate -divider Signals
add wave -noupdate -radix unsigned /data_shift_in/a_sel
add wave -noupdate -radix decimal /data_shift_in/a0
add wave -noupdate -radix decimal /data_shift_in/aN
add wave -noupdate -radix decimal /data_shift_in/aN_nxt
add wave -noupdate -radix decimal /data_shift_in/a_now
add wave -noupdate -divider {A Registers}
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(0)
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(1)
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(2)
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(3)
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(4)
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(5)
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(6)
add wave -noupdate -radix decimal /data_shift_in/A_LOAD/a_reg_out(7)
add wave -noupdate -divider {B Registers}
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(0)
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(1)
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(2)
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(3)
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(4)
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(5)
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(6)
add wave -noupdate -radix decimal /data_shift_in/B_LOAD/b_reg_out(7)
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /data_shift_in/a_out
add wave -noupdate -radix decimal /data_shift_in/b_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {180391 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 368
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
WaveRestoreZoom {0 ps} {399 ns}
