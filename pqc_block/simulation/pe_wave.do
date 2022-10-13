onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pe_chain/clk
add wave -noupdate /pe_chain/rst
add wave -noupdate /pe_chain/ena
add wave -noupdate -divider Inputs
add wave -noupdate -radix decimal /pe_chain/A
add wave -noupdate -radix decimal /pe_chain/B
add wave -noupdate -divider Signals
add wave -noupdate -radix decimal /pe_chain/a_wire
add wave -noupdate -radix decimal /pe_chain/c_wire
add wave -noupdate -divider PE0
add wave -noupdate -radix decimal /pe_chain/PE_0/A
add wave -noupdate -radix decimal /pe_chain/PE_0/a_col
add wave -noupdate -radix decimal /pe_chain/PE_0/B
add wave -noupdate -radix decimal /pe_chain/PE_0/c_mult
add wave -noupdate -radix decimal /pe_chain/PE_0/A_out
add wave -noupdate -radix decimal /pe_chain/PE_0/C_out
add wave -noupdate -divider PE1
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/A
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/a_col
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/B
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/c_mult
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/C_in
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/c_sum
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/A_out
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(1)/PE/C_out
add wave -noupdate -divider PE2
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/A
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/a_col
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/B
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/c_mult
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/C_in
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/c_sum
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/A_out
add wave -noupdate -radix decimal /pe_chain/PE_I_GEN(2)/PE/C_out
add wave -noupdate -divider PE3
add wave -noupdate -radix decimal /pe_chain/PE_N_GEN(1)/PE_N/A
add wave -noupdate -radix decimal /pe_chain/PE_N_GEN(1)/PE_N/a_col
add wave -noupdate -radix decimal /pe_chain/PE_N_GEN(1)/PE_N/B
add wave -noupdate -radix decimal /pe_chain/PE_N_GEN(1)/PE_N/c_mult
add wave -noupdate -radix decimal /pe_chain/PE_N_GEN(1)/PE_N/C_in
add wave -noupdate -radix decimal /pe_chain/PE_N_GEN(1)/PE_N/c_sum
add wave -noupdate -radix decimal /pe_chain/PE_N_GEN(1)/PE_N/C_out
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pe_chain/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 232
configure wave -valuecolwidth 606
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
WaveRestoreZoom {0 ps} {17736 ps}
