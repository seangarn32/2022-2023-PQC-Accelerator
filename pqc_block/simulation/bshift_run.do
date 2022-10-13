restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 10 ns
force ena 1

force B_in(0) "00000001"
force B_in(1) "00000010"
force B_in(2) "00000100"
force B_in(3) "00001000"
force B_in(4) "00010000"
force B_in(5) "00100000"
force B_in(6) "01000000"
force B_in(7) "10000000"

run 200 ns