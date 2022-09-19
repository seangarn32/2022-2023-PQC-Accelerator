restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

force A0 "11111111"
run 40 ns
force B_in "00000001"
run 20 ns
force B_in "00000000"
run 20 ns
force B_in "00000000"
run 20 ns
force B_in "00000000"
run 20 ns
force B_in "00000000"
run 20 ns
force B_in "00000000"
run 20 ns
force B_in "00000001"
run 20 ns
force B_in "00000000"

run 350 ns

force rst 1

run 60 ns 

