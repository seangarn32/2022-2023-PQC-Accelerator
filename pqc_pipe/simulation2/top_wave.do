onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pqc_accelerator_top/clk
add wave -noupdate /pqc_accelerator_top/rst
add wave -noupdate /pqc_accelerator_top/ena
add wave -noupdate -divider Inputs
add wave -noupdate -radix decimal /pqc_accelerator_top/A_in
add wave -noupdate -radix decimal /pqc_accelerator_top/B_in
add wave -noupdate /pqc_accelerator_top/A
add wave -noupdate -radix decimal /pqc_accelerator_top/B
add wave -noupdate -radix decimal /pqc_accelerator_top/C
add wave -noupdate -divider State
add wave -noupdate /pqc_accelerator_top/FSM/state
add wave -noupdate /pqc_accelerator_top/FSM/STATE_COUNTER/cnt
add wave -noupdate -divider Accum
add wave -noupdate /pqc_accelerator_top/pe_mux_sel
add wave -noupdate -radix decimal /pqc_accelerator_top/C_accum
add wave -noupdate -divider Enables
add wave -noupdate /pqc_accelerator_top/dsi_ena
add wave -noupdate /pqc_accelerator_top/pe_ena
add wave -noupdate /pqc_accelerator_top/dso_ena
add wave -noupdate /pqc_accelerator_top/accum_ena
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 220
configure wave -valuecolwidth 569
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
WaveRestoreZoom {0 ps} {1260 ns}
