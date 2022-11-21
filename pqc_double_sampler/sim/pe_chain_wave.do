onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pe_chain/clk
add wave -noupdate /pe_chain/rst
add wave -noupdate /pe_chain/ena
add wave -noupdate /pe_chain/enc_dec
add wave -noupdate /pe_chain/A0
add wave -noupdate /pe_chain/B0
add wave -noupdate /pe_chain/B1
add wave -noupdate /pe_chain/C_out_0
add wave -noupdate /pe_chain/C_out_1
add wave -noupdate -divider PE0
add wave -noupdate /pe_chain/PE_0/A0
add wave -noupdate /pe_chain/PE_0/B_0
add wave -noupdate /pe_chain/PE_0/B_1
add wave -noupdate /pe_chain/PE_0/C_out_0
add wave -noupdate /pe_chain/PE_0/C_out_1
add wave -noupdate /pe_chain/PE_0/A2
add wave -noupdate -expand /pe_chain/PE_0/C_mult_0
add wave -noupdate -expand /pe_chain/PE_0/C_mult_1
add wave -noupdate -divider PE1
add wave -noupdate -expand /pe_chain/a_wire
add wave -noupdate /pe_chain/b_wire
add wave -noupdate /pe_chain/p_wire
add wave -noupdate -expand /pe_chain/c0_wire
add wave -noupdate -expand /pe_chain/PE_0/A1
add wave -noupdate -expand /pe_chain/c1_wire
add wave -noupdate -divider PE2
add wave -noupdate /pe_chain/a_wire
add wave -noupdate /pe_chain/b_wire
add wave -noupdate /pe_chain/p_wire
add wave -noupdate /pe_chain/c0_wire
add wave -noupdate /pe_chain/c1_wire
add wave -noupdate -divider PE3
add wave -noupdate /pe_chain/a_wire
add wave -noupdate /pe_chain/b_wire
add wave -noupdate /pe_chain/p_wire
add wave -noupdate /pe_chain/c0_wire
add wave -noupdate /pe_chain/c1_wire
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {279913 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
configure wave -valuecolwidth 680
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
WaveRestoreZoom {169942 ps} {1043687 ps}
