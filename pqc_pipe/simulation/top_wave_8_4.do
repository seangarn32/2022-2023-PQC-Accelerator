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
add wave -noupdate -divider PE0
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/C_out
add wave -noupdate -divider PE1
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(1)/PE/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(1)/PE/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(1)/PE/C_in
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(1)/PE/C_out
add wave -noupdate -divider PE2
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(2)/PE/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(2)/PE/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(2)/PE/C_in
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_GEN(2)/PE/C_out
add wave -noupdate -divider PE3
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N/C_in
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N/C_out
add wave -noupdate -divider Accum
add wave -noupdate /pqc_accelerator_top/pe_mux_sel
add wave -noupdate -radix decimal -childformat {{/pqc_accelerator_top/C_accum(0) -radix decimal} {/pqc_accelerator_top/C_accum(1) -radix decimal} {/pqc_accelerator_top/C_accum(2) -radix decimal} {/pqc_accelerator_top/C_accum(3) -radix decimal} {/pqc_accelerator_top/C_accum(4) -radix decimal} {/pqc_accelerator_top/C_accum(5) -radix decimal} {/pqc_accelerator_top/C_accum(6) -radix decimal} {/pqc_accelerator_top/C_accum(7) -radix decimal}} -subitemconfig {/pqc_accelerator_top/C_accum(0) {-height 15 -radix decimal} /pqc_accelerator_top/C_accum(1) {-height 15 -radix decimal} /pqc_accelerator_top/C_accum(2) {-height 15 -radix decimal} /pqc_accelerator_top/C_accum(3) {-height 15 -radix decimal} /pqc_accelerator_top/C_accum(4) {-height 15 -radix decimal} /pqc_accelerator_top/C_accum(5) {-height 15 -radix decimal} /pqc_accelerator_top/C_accum(6) {-height 15 -radix decimal} /pqc_accelerator_top/C_accum(7) {-height 15 -radix decimal}} /pqc_accelerator_top/C_accum
add wave -noupdate -divider Enables
add wave -noupdate /pqc_accelerator_top/dsi_ena
add wave -noupdate /pqc_accelerator_top/pe_ena
add wave -noupdate /pqc_accelerator_top/dso_ena
add wave -noupdate /pqc_accelerator_top/accum_ena
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {275428 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 317
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
WaveRestoreZoom {0 ps} {1213046 ps}
