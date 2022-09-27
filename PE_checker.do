restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in 01001001 20 ns
force B_in "01101100" 20 ns, "01001000" 40 ns, "01010110" 60 ns, "01010010" 80 ns, "01100101" 100 ns, "01010010" 120 ns, "01011011" 140 ns, "00100010" 160 ns

run 700000ns