onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Globals
add wave -noupdate /pqc_accelerator_top/clk
add wave -noupdate /pqc_accelerator_top/ena
add wave -noupdate /pqc_accelerator_top/rst
add wave -noupdate -divider Inputs
add wave -noupdate /pqc_accelerator_top/A0
add wave -noupdate /pqc_accelerator_top/B
add wave -noupdate -divider PE0
add wave -noupdate /pqc_accelerator_top/PE0/A_sign
add wave -noupdate /pqc_accelerator_top/B(0)
add wave -noupdate /pqc_accelerator_top/C(1)
add wave -noupdate -divider PE1
add wave -noupdate /pqc_accelerator_top/A(1)
add wave -noupdate /pqc_accelerator_top/B(1)
add wave -noupdate /pqc_accelerator_top/C(2)
add wave -noupdate -divider PE2
add wave -noupdate /pqc_accelerator_top/A(2)
add wave -noupdate /pqc_accelerator_top/B(2)
add wave -noupdate /pqc_accelerator_top/C(3)
add wave -noupdate -divider PE3
add wave -noupdate /pqc_accelerator_top/A(3)
add wave -noupdate /pqc_accelerator_top/B(3)
add wave -noupdate /pqc_accelerator_top/C(4)
add wave -noupdate -divider PE4
add wave -noupdate /pqc_accelerator_top/A(4)
add wave -noupdate /pqc_accelerator_top/B(4)
add wave -noupdate /pqc_accelerator_top/C(5)
add wave -noupdate -divider PE5
add wave -noupdate /pqc_accelerator_top/A(5)
add wave -noupdate /pqc_accelerator_top/B(5)
add wave -noupdate /pqc_accelerator_top/C(6)
add wave -noupdate -divider PE6
add wave -noupdate /pqc_accelerator_top/A(6)
add wave -noupdate /pqc_accelerator_top/B(6)
add wave -noupdate /pqc_accelerator_top/C(7)
add wave -noupdate -divider PE7
add wave -noupdate /pqc_accelerator_top/A(7)
add wave -noupdate /pqc_accelerator_top/B(7)
add wave -noupdate -divider Out
add wave -noupdate /pqc_accelerator_top/A_out
add wave -noupdate /pqc_accelerator_top/C_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {901772 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
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
WaveRestoreZoom {1002500 ps} {2052500 ps}
