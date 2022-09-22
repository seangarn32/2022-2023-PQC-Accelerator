restart -f
force clk 0 0, 1 5ns -repeat 10ns
force rst 1 0ns, 0 10ns
force ena 0 0ns, 1 10ns

force A_in 00001010 20 ns
force B_in "00110111" 20 ns, "00011101" 40 ns, "00100101" 60 ns, "00001001" 80 ns, "01110000" 100 ns, "00001000" 120 ns, "01000101" 140 ns, "01000101" 160 ns

run 700000ns