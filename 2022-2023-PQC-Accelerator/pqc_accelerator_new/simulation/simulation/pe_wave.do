onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/clk
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/ena
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/rst
add wave -noupdate -divider Inputs
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A0
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B
add wave -noupdate -divider {A (Circulant Problem)}
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A(1)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A(2)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A(3)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A(4)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A(5)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A(6)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A(7)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/A_out
add wave -noupdate -divider B
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(0)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(1)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(2)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(3)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(4)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(5)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(6)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/B(7)
add wave -noupdate -divider C
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C(1)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C(2)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C(3)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C(4)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C(5)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C(6)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C(7)
add wave -noupdate /pqc_accelerator_top/PE_CHAIN/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {228 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
configure wave -valuecolwidth 38
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
WaveRestoreZoom {0 ps} {1003 ps}
