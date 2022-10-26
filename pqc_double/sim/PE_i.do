restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 10 ns
force ena 0 0 ns, 1 20 ns
force enc_dec 0

force A0(0) 00 0 ns
force A0(1) 01 0 ns
force A0(2) 00 0 ns
force A0(3) 01 0 ns
force A0(4) 00 0 ns
force A0(5) 01 0 ns
force A0(6) 01 0 ns
force A0(7) 00 0 ns

force B_0 "00000001"
force B_1 "00000010"

run 60 ns
