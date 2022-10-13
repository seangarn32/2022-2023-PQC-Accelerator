restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 1

force d(0) "00000011"
force d(1) "00000101"

run 200 ns