restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 10 ns
force ena 0 0 ns, 1 20 ns
force enc_dec 1

force A0(0) 00 0 ns
force A0(1) 01 0 ns
force A0(2) 00 0 ns
force A0(3) 01 0 ns
force A0(4) 00 0 ns
force A0(5) 01 0 ns
force A0(6) 01 0 ns
force A0(7) 01 0 ns

force B0(0) "00000000" 0 ns
force B0(1) "00000001" 0 ns
force B0(2) "00000000" 0 ns
force B0(3) "00000001" 0 ns
force B0(4) "00000000" 0 ns
force B0(5) "00000001" 0 ns
force B0(6) "00000000" 0 ns
force B0(7) "00000001" 0 ns

force B1(0) "00000000" 0 ns
force B1(1) "00000001" 0 ns
force B1(2) "00000000" 0 ns
force B1(3) "00000001" 0 ns
force B1(4) "00000000" 0 ns
force B1(5) "00000001" 0 ns
force B1(6) "00000000" 0 ns
force B1(7) "00000001" 0 ns


run 1000 ns
