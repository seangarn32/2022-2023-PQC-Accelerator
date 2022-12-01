restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force dsi_ena 1 0 ns, 0 171 ns
force pe_ena 0 0 ns, 1 171 ns
force a_sel "111"

force a_in '0'
force b_in "00000000"
run 20 ns

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
force a_in '1'
force b_in "01101111"
run 20 ns

#6
force a_in '1'
force b_in "01111100"
run 20 ns

#7
force a_in '1'
force b_in "00000001"
run 20 ns


run 200 ns