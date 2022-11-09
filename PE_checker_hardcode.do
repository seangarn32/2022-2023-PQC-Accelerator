restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in 1 20ns, 0 40ns, 1 60ns, 0 80ns, 1 100ns, 1 120ns, 1 140ns, 0 160ns
force B_in "00000001" 20 ns, "00000001" 40 ns, "00000000" 60 ns, "00000001" 80 ns, "00000000" 100 ns, "00000001" 120 ns, "00000000" 140 ns, "00000001" 160 ns

run 700000ns