restart -f
force clk 0 0 ns, 1 10 ns -repeat 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

force a_in 0 30ns, 0 50ns, 0 70ns, 1 90ns, 0 110ns, 1 130ns, 0 150ns, 1 170ns
force b_in "01101010" 30 ns, "01001101" 50 ns, "00000100" 70 ns, "00100011" 90 ns, "10011100" 110 ns, "01101111" 130 ns, "01111100" 150 ns, "00000001" 170 ns

run 20000ns