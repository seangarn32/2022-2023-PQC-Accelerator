onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pqc_accelerator_top/clk
add wave -noupdate /pqc_accelerator_top/ena
add wave -noupdate /pqc_accelerator_top/rst
add wave -noupdate /pqc_accelerator_top/A0
add wave -noupdate /pqc_accelerator_top/B
add wave -noupdate /pqc_accelerator_top/A1
add wave -noupdate /pqc_accelerator_top/A2
add wave -noupdate /pqc_accelerator_top/A3
add wave -noupdate /pqc_accelerator_top/A4
add wave -noupdate /pqc_accelerator_top/A5
add wave -noupdate /pqc_accelerator_top/A6
add wave -noupdate /pqc_accelerator_top/A7
add wave -noupdate /pqc_accelerator_top/C1
add wave -noupdate /pqc_accelerator_top/C2
add wave -noupdate /pqc_accelerator_top/C3
add wave -noupdate /pqc_accelerator_top/C4
add wave -noupdate /pqc_accelerator_top/C5
add wave -noupdate /pqc_accelerator_top/C6
add wave -noupdate /pqc_accelerator_top/C7
add wave -noupdate -divider Out
add wave -noupdate /pqc_accelerator_top/A_out
add wave -noupdate /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1999502 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
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
WaveRestoreZoom {1999050 ps} {2000004 ps}
