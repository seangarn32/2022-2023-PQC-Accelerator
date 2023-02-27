onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Finite State Machine}
add wave -noupdate /pqc_accelerator_top/FSM/state
add wave -noupdate /pqc_accelerator_top/FSM/dsi_ena
add wave -noupdate /pqc_accelerator_top/FSM/pe_ena
add wave -noupdate /pqc_accelerator_top/FSM/accum_ena
add wave -noupdate /pqc_accelerator_top/FSM/dso_ena
add wave -noupdate -divider Sampler
add wave -noupdate -divider {Data Shift In}
add wave -noupdate /pqc_accelerator_top/DSI/a_in
add wave -noupdate /pqc_accelerator_top/DSI/b_in
add wave -noupdate /pqc_accelerator_top/DSI/p_in
add wave -noupdate /pqc_accelerator_top/DSI/a_out
add wave -noupdate /pqc_accelerator_top/DSI/b_out
add wave -noupdate /pqc_accelerator_top/DSI/p_out
add wave -noupdate -divider {Load A}
add wave -noupdate /pqc_accelerator_top/LOAD_A/rst
add wave -noupdate /pqc_accelerator_top/LOAD_A/load_a_ena
add wave -noupdate /pqc_accelerator_top/LOAD_A/A_in
add wave -noupdate /pqc_accelerator_top/LOAD_A/a0
add wave -noupdate /pqc_accelerator_top/LOAD_A/a_nxt
add wave -noupdate /pqc_accelerator_top/LOAD_A/tmp
add wave -noupdate /pqc_accelerator_top/LOAD_A/A_out
add wave -noupdate /pqc_accelerator_top/LOAD_A/a_reg
add wave -noupdate /pqc_accelerator_top/LOAD_A/count
add wave -noupdate /pqc_accelerator_top/LOAD_A/enc_dec
add wave -noupdate -divider {Load B}
add wave -noupdate /pqc_accelerator_top/LOAD_B/count
add wave -noupdate /pqc_accelerator_top/LOAD_B/enc_dec
add wave -noupdate /pqc_accelerator_top/LOAD_B/rst
add wave -noupdate /pqc_accelerator_top/LOAD_B/load_b_ena
add wave -noupdate /pqc_accelerator_top/LOAD_B/B_in
add wave -noupdate /pqc_accelerator_top/LOAD_B/P_in
add wave -noupdate /pqc_accelerator_top/LOAD_B/B_out
add wave -noupdate /pqc_accelerator_top/LOAD_B/P_out
add wave -noupdate /pqc_accelerator_top/LOAD_B/b_tmp
add wave -noupdate /pqc_accelerator_top/LOAD_B/p_tmp
add wave -noupdate -divider {PE Chain}
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/enc_dec
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A0
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B0
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B1
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C_out_0
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C_out_1
add wave -noupdate -expand /pqc_accelerator_top/PE_CHAIN/a_wire
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/b_wire
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/p_wire
add wave -noupdate -divider {Accumulator Cell}
add wave -noupdate /pqc_accelerator_top/ACCUM/rst
add wave -noupdate /pqc_accelerator_top/ACCUM/ena
add wave -noupdate /pqc_accelerator_top/ACCUM/A0
add wave -noupdate /pqc_accelerator_top/ACCUM/A1
add wave -noupdate /pqc_accelerator_top/ACCUM/C0
add wave -noupdate /pqc_accelerator_top/ACCUM/C1
add wave -noupdate /pqc_accelerator_top/ACCUM/C2
add wave -noupdate /pqc_accelerator_top/ACCUM/sum
add wave -noupdate /pqc_accelerator_top/ACCUM/c0_out
add wave -noupdate /pqc_accelerator_top/ACCUM/c1_out
add wave -noupdate /pqc_accelerator_top/ACCUM/sc1_out
add wave -noupdate -divider {Data Shift Out}
add wave -noupdate -radix hexadecimal /pqc_accelerator_top/DSO/c_in_0
add wave -noupdate -radix hexadecimal /pqc_accelerator_top/DSO/c_in_1
add wave -noupdate -radix hexadecimal /pqc_accelerator_top/DSO/c_in_2
add wave -noupdate -radix hexadecimal /pqc_accelerator_top/DSO/c_enc_dec
add wave -noupdate -radix hexadecimal /pqc_accelerator_top/DSO/c_out_0
add wave -noupdate -radix hexadecimal /pqc_accelerator_top/DSO/c_out_1
add wave -noupdate -divider Error
add wave -noupdate /pqc_accelerator_top/ERR/W
add wave -noupdate /pqc_accelerator_top/ERR/Y
add wave -noupdate /pqc_accelerator_top/ERR/e1
add wave -noupdate /pqc_accelerator_top/ERR/e2
add wave -noupdate /pqc_accelerator_top/ERR/c2
add wave -noupdate /pqc_accelerator_top/ERR/Ci1
add wave -noupdate /pqc_accelerator_top/ERR/Ci2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {359069 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 302
configure wave -valuecolwidth 178
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
WaveRestoreZoom {5817570 ps} {6176639 ps}
