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
add wave -noupdate -radix unsigned /pqc_accelerator_top/FSM/count
add wave -noupdate /pqc_accelerator_top/FSM/state
add wave -noupdate /pqc_accelerator_top/dsi_ena
add wave -noupdate /pqc_accelerator_top/pe_ena
add wave -noupdate /pqc_accelerator_top/accum_ena
add wave -noupdate /pqc_accelerator_top/dso_ena
add wave -noupdate -divider LOAD_A
add wave -noupdate -radix decimal /pqc_accelerator_top/DSI/a0
add wave -noupdate -radix decimal /pqc_accelerator_top/DSI/aN
add wave -noupdate -radix decimal /pqc_accelerator_top/DSI/aN_nxt
add wave -noupdate /pqc_accelerator_top/DSI/a_now_sel
add wave -noupdate -radix decimal /pqc_accelerator_top/DSI/a_now
add wave -noupdate -radix unsigned /pqc_accelerator_top/FSM/a_sel
add wave -noupdate -radix unsigned /pqc_accelerator_top/FSM/a_sel_nxt
add wave -noupdate -radix unsigned /pqc_accelerator_top/FSM/count_a_sel
add wave -noupdate -radix unsigned /pqc_accelerator_top/FSM/count_a_sel_nxt
add wave -noupdate /pqc_accelerator_top/DSI/shift_ena
add wave -noupdate -divider signals
add wave -noupdate -radix decimal -childformat {{/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(0) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(1) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(2) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(3) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(4) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(5) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(6) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(7) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(8) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(9) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(10) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(11) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(12) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(13) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(14) -radix decimal} {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(15) -radix decimal}} -subitemconfig {/pqc_accelerator_top/DSI/A_LOAD/a_reg_out(0) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(1) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(2) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(3) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(4) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(5) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(6) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(7) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(8) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(9) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(10) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(11) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(12) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(13) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(14) {-height 15 -radix decimal} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out(15) {-height 15 -radix decimal}} /pqc_accelerator_top/DSI/A_LOAD/a_reg_out
add wave -noupdate -radix decimal /pqc_accelerator_top/DSI/B_LOAD/b_reg_out
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
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/c_reg_out(0)
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/c_reg_out(1)
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/c_reg_out(2)
add wave -noupdate -radix decimal /pqc_accelerator_top/DSO/c_reg_out(3)
add wave -noupdate -radix unsigned /pqc_accelerator_top/DSO/count
add wave -noupdate -radix unsigned /pqc_accelerator_top/DSO/count_nxt
add wave -noupdate /pqc_accelerator_top/DSO/shift_ena
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {572871 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 340
configure wave -valuecolwidth 432
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
WaveRestoreZoom {0 ps} {1186500 ps}
