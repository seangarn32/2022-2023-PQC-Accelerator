onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /data_shift_out/clk
add wave -noupdate /data_shift_out/rst
add wave -noupdate /data_shift_out/ena
add wave -noupdate -divider Inputs
add wave -noupdate /data_shift_out/C_in
add wave -noupdate -divider Counters
add wave -noupdate -radix unsigned /data_shift_out/count
add wave -noupdate -radix unsigned /data_shift_out/count_nxt
add wave -noupdate -radix unsigned /data_shift_out/c_index
add wave -noupdate -radix unsigned /data_shift_out/c_index_nxt
add wave -noupdate /data_shift_out/reg_ena
add wave -noupdate /data_shift_out/shift_ena
add wave -noupdate -divider Signals
add wave -noupdate /data_shift_out/c_sel
add wave -noupdate /data_shift_out/c_nxt
add wave -noupdate -divider REG0
add wave -noupdate /data_shift_out/SECTION_GEN_0/ena
add wave -noupdate /data_shift_out/SECTION_GEN_0/d
add wave -noupdate /data_shift_out/SECTION_GEN_0/q
add wave -noupdate -divider REG1
add wave -noupdate /data_shift_out/REG_GEN_SECTION_0(1)/REG/ena
add wave -noupdate /data_shift_out/REG_GEN_SECTION_0(1)/REG/d
add wave -noupdate /data_shift_out/REG_GEN_SECTION_0(1)/REG/q
add wave -noupdate -divider REG2
add wave -noupdate /data_shift_out/SECTION_GEN(1)/REG_GEN(0)/REG/ena
add wave -noupdate /data_shift_out/SECTION_GEN(1)/REG_GEN(0)/REG/d
add wave -noupdate /data_shift_out/SECTION_GEN(1)/REG_GEN(0)/REG/q
add wave -noupdate -divider REG3
add wave -noupdate /data_shift_out/SECTION_GEN(1)/REG_GEN(1)/REG/ena
add wave -noupdate /data_shift_out/SECTION_GEN(1)/REG_GEN(1)/REG/d
add wave -noupdate /data_shift_out/SECTION_GEN(1)/REG_GEN(1)/REG/q
add wave -noupdate -divider REG4
add wave -noupdate /data_shift_out/SECTION_GEN(2)/REG_GEN(0)/REG/ena
add wave -noupdate /data_shift_out/SECTION_GEN(2)/REG_GEN(0)/REG/d
add wave -noupdate /data_shift_out/SECTION_GEN(2)/REG_GEN(0)/REG/q
add wave -noupdate -divider REG5
add wave -noupdate /data_shift_out/SECTION_GEN(2)/REG_GEN(1)/REG/ena
add wave -noupdate /data_shift_out/SECTION_GEN(2)/REG_GEN(1)/REG/d
add wave -noupdate /data_shift_out/SECTION_GEN(2)/REG_GEN(1)/REG/q
add wave -noupdate -divider REG6
add wave -noupdate /data_shift_out/SECTION_GEN(3)/REG_GEN(0)/REG/ena
add wave -noupdate /data_shift_out/SECTION_GEN(3)/REG_GEN(0)/REG/d
add wave -noupdate /data_shift_out/SECTION_GEN(3)/REG_GEN(0)/REG/q
add wave -noupdate -divider REG7
add wave -noupdate /data_shift_out/SECTION_GEN(3)/REG_GEN(1)/REG/ena
add wave -noupdate /data_shift_out/SECTION_GEN(3)/REG_GEN(1)/REG/d
add wave -noupdate /data_shift_out/SECTION_GEN(3)/REG_GEN(1)/REG/q
add wave -noupdate -divider Outputs
add wave -noupdate /data_shift_out/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 346
configure wave -valuecolwidth 298
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
WaveRestoreZoom {0 ps} {388500 ps}
