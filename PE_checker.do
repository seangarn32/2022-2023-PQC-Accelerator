restart
force clock 0 0, 1 5ns -repeat 10ns
force reset 1 0ns, 0 10ns
force load 0 0ns, 1 10ns
force clear 0 0ns

force A_in 1 20ns, 1 30ns, 1 40ns, 0 50ns, 1 60ns, 1 70ns, 1 80ns, 1 90ns
force B_in 00110010 20ns, 01111110 30ns, 01000111 40ns, 00010100 50ns, 01000111 60ns, 01001011 70ns, 01010001 80ns, 01101110 90ns

run 700000ns