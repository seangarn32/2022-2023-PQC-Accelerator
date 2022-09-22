restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in 10000111 20 ns
force B_in "00101101" 20 ns, "00000001" 40 ns, "00000101" 60 ns, "01101010" 80 ns, "01011010" 100 ns, "01010101" 120 ns, "01000000" 140 ns, "01101000" 160 ns

run 700000ns