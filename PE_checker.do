restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in 11110100 20 ns
force B_in "01101101" 20 ns, "00100010" 40 ns, "01100001" 60 ns, "01111010" 80 ns, "00011000" 100 ns, "00111010" 120 ns, "01001110" 140 ns, "00101011" 160 ns

run 700000ns