restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

run 40 ns

force a_in 0
force b_in "00000000"
run 20 ns

force a_in 1
force b_in "00000001"
run 20 ns

force a_in 0
force b_in "01000000"
run 20 ns

force a_in 1
force b_in "11111000"
run 20 ns

force a_in 0
force b_in "00001000"
run 20 ns

force a_in 1
force b_in "00111000"
run 20 ns

force a_in 0
force b_in "00110010"
run 20 ns

force a_in 1
force b_in "00110011"
run 20 ns


run 1000 ns 

