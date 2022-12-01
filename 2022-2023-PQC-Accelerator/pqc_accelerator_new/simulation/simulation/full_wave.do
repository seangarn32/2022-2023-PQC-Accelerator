onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pqc_accelerator_top/clk
add wave -noupdate /pqc_accelerator_top/rst
add wave -noupdate /pqc_accelerator_top/ena
add wave -noupdate -divider Inputs
add wave -noupdate /pqc_accelerator_top/A0
add wave -noupdate /pqc_accelerator_top/B_in
add wave -noupdate -divider FSM
add wave -noupdate /pqc_accelerator_top/FSM/state_current
add wave -noupdate /pqc_accelerator_top/dsi_ena
add wave -noupdate /pqc_accelerator_top/pe_ena
add wave -noupdate /pqc_accelerator_top/dso_ena
add wave -noupdate -divider Wires
add wave -noupdate -radix decimal /pqc_accelerator_top/B
add wave -noupdate -radix decimal /pqc_accelerator_top/C
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/PE_0/A_sign
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/A(1)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/A(2)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/A(3)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/A(4)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/A(5)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/A(6)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/A(7)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C(1)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C(2)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C(3)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C(4)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C(5)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C(6)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C(7)
add wave -noupdate -radix decimal /pqc_accelerator_top/PE_CHAIN/C_out
add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {567041 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {334441 ps}
