restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in 0 20ns, 1 40ns, 1 60ns, 1 80ns, 1 100ns, 0 120ns, 0 140ns, 0 160ns
force B_in "01101010" 20 ns, "01001101" 40 ns, "00000100" 60 ns, "00100011" 80 ns, "01011110" 100 ns, "01101111" 120 ns, "01111100" 140 ns, "00000001" 160 ns

run 700000ns