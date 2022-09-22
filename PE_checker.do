restart
force clock 0 0, 1 5ns -repeat 10ns
force reset 1 0ns, 0 10ns
force load 0 0ns, 1 10ns
force clear 0 0ns

force A_in 0 20ns, 1 30ns, 1 40ns, 1 50ns, 1 60ns, 0 70ns, 0 80ns, 1 90ns
force B_in 01001110 20ns, 01010001 30ns, 01100011 40ns, 01001111 50ns, 01110110 60ns, 00011111 70ns, 00001101 80ns, 00110000 90ns

run 700000ns