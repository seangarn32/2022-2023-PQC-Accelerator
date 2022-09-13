restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 10 ns
force ena 1

force A0 	"00010001"
force B(0) 	"00000000"
force B(1) 	"00000000"
force B(2) 	"00000000"
force B(3) 	"10101010"
force B(4) 	"00000000"
force B(5) 	"00000000"
force B(6) 	"00000000"
force B(7) 	"01010101"

run 2000 ns
