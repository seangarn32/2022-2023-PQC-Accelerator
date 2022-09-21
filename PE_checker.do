restart
force clock 0 0, 1 5ns -repeat 10ns
force reset 1 0ns, 0 10ns
force load 0 0ns, 1 10ns
force clear 0 0ns

force A_in 1 20ns, 0 30ns, 1 40ns, 0 50ns, 0 60ns, 0 70ns, 0 80ns, 0 90ns
force B_in 10101110 20ns, 00111100 30ns, 01010101 40ns, 11011011 50ns, 11000110 60ns, 00101100 70ns, 11010110 80ns, 10011011 90ns

run 700000ns