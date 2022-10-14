onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pqc_accelerator_top/clk
add wave -noupdate /pqc_accelerator_top/rst
add wave -noupdate /pqc_accelerator_top/ena
add wave -noupdate -divider Inputs
add wave -noupdate /pqc_accelerator_top/A_in
add wave -noupdate /pqc_accelerator_top/B_in
add wave -noupdate -divider State
add wave -noupdate /pqc_accelerator_top/dsi_ena
add wave -noupdate /pqc_accelerator_top/bl_ena
add wave -noupdate /pqc_accelerator_top/pe_ena
add wave -noupdate /pqc_accelerator_top/accum_ena
add wave -noupdate /pqc_accelerator_top/dso_ena
add wave -noupdate -divider signals
add wave -noupdate /pqc_accelerator_top/a0
add wave -noupdate /pqc_accelerator_top/b_all
add wave -noupdate /pqc_accelerator_top/a_shift2pe
add wave -noupdate /pqc_accelerator_top/b_shift2pe
add wave -noupdate /pqc_accelerator_top/c_accum2dso
add wave -noupdate /pqc_accelerator_top/c_pe2accum
add wave -noupdate -divider Outputs
add wave -noupdate /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24432 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 233
configure wave -valuecolwidth 234
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
WaveRestoreZoom {0 ps} {66477 ps}
