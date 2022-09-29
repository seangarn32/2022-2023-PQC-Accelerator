restart -f
force clk 0 0, 1 10ns -repeat 20ns
force rst 1 0ns, 0 20ns
force ena 0 0ns, 1 20ns

force A_in '1' 20 ns, '1' 40 ns, '1' 60 ns, '1' 80 ns, '1' 100 ns, '1' 120 ns, '1' 140 ns, '1' 160 ns
force B_in "00000000" 20 ns, "00000001" 40 ns, "00000000" 60 ns, "00000000" 80 ns, "00000000" 100 ns, "00000000" 120 ns, "00000000" 140 ns, "00000001" 160 ns

run 700000ns