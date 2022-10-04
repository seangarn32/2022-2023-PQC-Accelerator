restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in 01001010 20 ns
force B_in "01011111" 20 ns, "00000101" 40 ns, "00110010" 60 ns, "00111011" 80 ns, "00011001" 100 ns, "01101110" 120 ns, "00010011" 140 ns, "00001001" 160 ns

run 700000ns