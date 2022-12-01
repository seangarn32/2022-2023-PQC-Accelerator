restart -f
force clk 0 0 ns, 1 10 ns -repeat 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns
force z_in 0

force a_in 0 35 ns, 0 55 ns, 0 75 ns, 0 95 ns, 1 115 ns, 0 135 ns, 1 155 ns, 1 175 ns
force b_in "01101010" 35 ns, "01001101" 55 ns, "00000100" 75 ns, "00100011" 95 ns, "01011110" 115 ns, "01101111" 135 ns, "01111100" 155 ns, "00100000" 175 ns
force z_in 1 335 ns, 0 355 ns, 1 375 ns, 0 395 ns, 1 415 ns, 0 435 ns, 1 455 ns, 0 475 ns

run 790ns