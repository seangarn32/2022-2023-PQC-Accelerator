restart -f
force clk 0 0, 1 5ns -repeat 10ns
force rst 1 0ns, 0 10ns
force ena 0 0ns, 1 10ns

<<<<<<< HEAD
force A_in 0 20ns, 1 30ns, 1 40ns, 1 50ns, 1 60ns, 0 70ns, 0 80ns, 1 90ns
force B_in 01001110 20ns, 01010001 30ns, 01100011 40ns, 01001111 50ns, 01110110 60ns, 00011111 70ns, 00001101 80ns, 00110000 90ns
=======
force A_in 00110100 20 ns
force B_in "01111101" 20 ns, "01010100" 40 ns, "01011100" 60 ns, "01101000" 80 ns, "00111100" 100 ns, "00001111" 120 ns, "01011111" 140 ns, "01110010" 160 ns
>>>>>>> 50b13e31941e49d36ddb244b8fea06a13fa328f1

run 700000ns