onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pqc_accelerator_top/clk
add wave -noupdate /pqc_accelerator_top/rst
add wave -noupdate /pqc_accelerator_top/ena
add wave -noupdate -divider B
add wave -noupdate /pqc_accelerator_top/B0
add wave -noupdate /pqc_accelerator_top/B1
add wave -noupdate /pqc_accelerator_top/B2
add wave -noupdate /pqc_accelerator_top/B3
add wave -noupdate /pqc_accelerator_top/B4
add wave -noupdate /pqc_accelerator_top/B5
add wave -noupdate /pqc_accelerator_top/B6
add wave -noupdate /pqc_accelerator_top/B7
add wave -noupdate -divider A
add wave -noupdate /pqc_accelerator_top/A0
add wave -noupdate /pqc_accelerator_top/A1
add wave -noupdate /pqc_accelerator_top/A2
add wave -noupdate /pqc_accelerator_top/A3
add wave -noupdate /pqc_accelerator_top/A4
add wave -noupdate /pqc_accelerator_top/A5
add wave -noupdate /pqc_accelerator_top/A6
add wave -noupdate /pqc_accelerator_top/A7
add wave -noupdate -divider C
add wave -noupdate /pqc_accelerator_top/C1
add wave -noupdate /pqc_accelerator_top/C2
add wave -noupdate /pqc_accelerator_top/C3
add wave -noupdate /pqc_accelerator_top/C4
add wave -noupdate /pqc_accelerator_top/C5
add wave -noupdate /pqc_accelerator_top/C6
add wave -noupdate /pqc_accelerator_top/C7
add wave -noupdate -divider out
add wave -noupdate /pqc_accelerator_top/A_out
add wave -noupdate /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 201
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
WaveRestoreZoom {0 ps} {2065913 ps}
