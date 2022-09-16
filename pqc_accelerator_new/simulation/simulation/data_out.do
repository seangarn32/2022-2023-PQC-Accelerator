restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 1

force d_rdy 0 0 ns, 1 110 ns
force d_in(0) "00000000"
force d_in(1) "00000001"
force d_in(2) "00000010"
force d_in(3) "00000011"
force d_in(4) "00000100"
force d_in(5) "00000101"
force d_in(6) "00000110"
force d_in(7) "00000111"

run 300 ns
