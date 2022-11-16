restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force bl_ena 0 0 ns, 1 10 ns
force pe_ena 0 0 ns, 1 40 ns

force A_in "00001111"

run 400 ns