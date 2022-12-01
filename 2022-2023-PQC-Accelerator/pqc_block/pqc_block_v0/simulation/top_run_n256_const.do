restart -f
force clk 0 0 ns, 1 10 ns -repeat 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns
force mode 1
force Z_in 0
force A_in 1
force B_in "00000101"

run 15000 ns