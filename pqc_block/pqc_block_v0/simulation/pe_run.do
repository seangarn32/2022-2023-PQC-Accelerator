restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 10 ns
force ena 1

force B(0) "00000000"
force B(1) "00000001"
force B(2) "00000010"
force B(3) "00000100"
force B(4) "00001000"
force B(5) "00010000"
force B(6) "00100000"
force B(7) "01000000"

run 200 ns