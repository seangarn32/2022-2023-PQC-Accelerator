restart -f
force clk 0 0, 1 5ns -repeat 10ns
force rst 1 0ns, 0 10ns
force ena 0 0ns, 1 10ns

force A_in 10011001 20 ns
force B_in "00110010" 20 ns, "01111011" 40 ns, "01001100" 60 ns, "00010110" 80 ns, "00001011" 100 ns, "01011000" 120 ns, "01010011" 140 ns, "01010111" 160 ns

run 700000ns