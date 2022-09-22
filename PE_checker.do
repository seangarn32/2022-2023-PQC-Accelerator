restart -f
force clk 0 0, 1 5ns -repeat 10ns
force rst 1 0ns, 0 10ns
force ena 0 0ns, 1 10ns

force A_in 00110100 20 ns
force B_in "01111101" 20 ns, "01010100" 40 ns, "01011100" 60 ns, "01101000" 80 ns, "00111100" 100 ns, "00001111" 120 ns, "01011111" 140 ns, "01110010" 160 ns

run 700000ns