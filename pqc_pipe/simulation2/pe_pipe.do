restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

run 20 ns

force a_in 0
force b_in "00000000"
run 20 ns

force a_in 1
force b_in "00000000"
run 20 ns

force a_in 0
force b_in "00000000"
run 20 ns

force a_in 1
force b_in "00000000"
run 20 ns

force a_in 0
force b_in "00000000"
run 20 ns

force a_in 1
force b_in "00000000"
run 20 ns

force a_in 0
force b_in "00000000"
run 20 ns

force a_in 1
force b_in "00000000"
run 20 ns

force rst 1
force ena 0

run 60 ns 

