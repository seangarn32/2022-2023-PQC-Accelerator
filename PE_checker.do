restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in 01101011 20 ns
force B_in "01100111" 20 ns, "00000001" 40 ns, "00110111" 60 ns, "00001100" 80 ns, "00100110" 100 ns, "00000110" 120 ns, "00110110" 140 ns, "00001001" 160 ns

run 700000ns