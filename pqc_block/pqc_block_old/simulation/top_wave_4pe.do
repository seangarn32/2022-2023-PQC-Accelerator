onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pqc_accelerator_top/clk
add wave -noupdate /pqc_accelerator_top/rst
add wave -noupdate /pqc_accelerator_top/ena
add wave -noupdate -divider Inputs
add wave -noupdate /pqc_accelerator_top/A_in
add wave -noupdate -radix decimal /pqc_accelerator_top/B_in
add wave -noupdate -divider State
add wave -noupdate /pqc_accelerator_top/FSM/state
add wave -noupdate /pqc_accelerator_top/dsi_ena
add wave -noupdate /pqc_accelerator_top/bl_ena
add wave -noupdate /pqc_accelerator_top/pe_ena
add wave -noupdate /pqc_accelerator_top/accum_ena
add wave -noupdate /pqc_accelerator_top/dso_ena
add wave -noupdate -divider signals
add wave -noupdate /pqc_accelerator_top/a0
add wave -noupdate -radix decimal /pqc_accelerator_top/b_all
add wave -noupdate -radix decimal /pqc_accelerator_top/a_shift2pe
add wave -noupdate -radix decimal /pqc_accelerator_top/b_shift2pe
add wave -noupdate -radix decimal /pqc_accelerator_top/c_accum2dso
add wave -noupdate -radix decimal /pqc_accelerator_top/c_pe2accum
add wave -noupdate -divider PE0
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/a_col
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/c_mult
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/A_out
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/C_out
add wave -noupdate -divider PE1
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/a_col
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/c_mult
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/C_in
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/c_sum
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/A_out
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(1)/PE/C_out
add wave -noupdate -divider PE2
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/a_col
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/c_mult
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/C_in
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/c_sum
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/A_out
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_I_GEN(2)/PE/C_out
add wave -noupdate -divider PE3
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N_GEN(1)/PE_N/A
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N_GEN(1)/PE_N/a_col
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N_GEN(1)/PE_N/B
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N_GEN(1)/PE_N/c_mult
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N_GEN(1)/PE_N/C_in
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N_GEN(1)/PE_N/c_sum
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_N_GEN(1)/PE_N/C_out
add wave -noupdate -divider Accumulator
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_ACCUM/d
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_ACCUM/sum_with
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_ACCUM/sum_nxt
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_ACCUM/sum
add wave -noupdate -divider DSO
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/C_in
add wave -noupdate -radix unsigned /pqc_accelerator_top/DSO/c_index
add wave -noupdate /pqc_accelerator_top/DSO/reg_ena
add wave -noupdate /pqc_accelerator_top/DSO/shift_ena
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/SECTION_GEN_0/q
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/REG_GEN_SECTION_0(1)/REG/q
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/SECTION_GEN(1)/REG_GEN(0)/REG/q
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/SECTION_GEN(1)/REG_GEN(1)/REG/q
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/SECTION_GEN(2)/REG_GEN(0)/REG/q
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/SECTION_GEN(2)/REG_GEN(1)/REG/q
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/SECTION_GEN(3)/REG_GEN(0)/REG/q
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/SECTION_GEN(3)/REG_GEN(1)/REG/q
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {521729 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 340
configure wave -valuecolwidth 233
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
WaveRestoreZoom {0 ps} {673684 ps}
