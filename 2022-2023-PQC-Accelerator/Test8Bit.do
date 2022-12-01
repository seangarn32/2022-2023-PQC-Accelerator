restart -f
force clk 0 0 ns, 1 10 ns -repeat 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

force a_in 0 35ns, 1 55ns, 1 75ns, 0 95ns, 1 115ns, 0 135ns, 1 155ns, 0 175ns
force b_in "00110101" 35 ns, "00110010" 55 ns, "10110010" 75 ns, "11100000" 95 ns, "00010100" 115 ns, "01110100" 135 ns, "10111101" 155 ns, "10100010" 175 ns

run 20000ns