restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 10 ns
force ena 1

force A_in "00001111"


run 200 ns