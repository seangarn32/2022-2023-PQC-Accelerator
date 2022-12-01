restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns
force Z_in 0

# Preset A & B
force a_in 0
force b_in "00000000"
run 30 ns

#0
force a_in '0'
force b_in "01101010"
run 20 ns

#1
force a_in '0'
force b_in "01001101"
run 20 ns

#2
force a_in '0'
force b_in "00000100"
run 20 ns

#3
force a_in '0'
force b_in "00100011"
run 20 ns

#4
force a_in '1'
force b_in "01011110"
run 20 ns

#5
force a_in '0'
force b_in "01101111"
run 20 ns

#6
force a_in '1'
force b_in "01111100"
run 20 ns

#7
force a_in '0'
force b_in "00000001"
run 20 ns

run 140 ns

#0
force Z_in '1'
run 20 ns

#1
force Z_in '1'
run 20 ns

#2
force Z_in '1'
run 20 ns

#3
force Z_in '1'
run 20 ns

#4
force Z_in '1'
run 20 ns

#5
force Z_in '1'
run 20 ns

#6
force Z_in '1'
run 20 ns

#7
force Z_in '1'
run 20 ns

run 20 ns
