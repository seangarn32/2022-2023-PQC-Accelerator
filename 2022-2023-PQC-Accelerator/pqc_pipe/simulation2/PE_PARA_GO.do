restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 10 ns
force ena 0 0 ns, 1 20 ns

force A_sel(0) 0
force B_sel(0) 0
force A_sel(1) 0
force B_sel(1) 0
force A_sel(2) 0
force B_sel(2) 0
force A_sel(3) 0
force B_sel(3) 0

force A0 "11111111"
force B(0) "00000000"
force B(1) "00000000"
force B(2) "00000000"
force B(3) "00000000"
force B(4) "00000000"
force B(5) "00000000"
force B(6) "00000000"
force B(7) "00000000"

run 20 ns

run 20 ns

force A_sel(0) 1
force B_sel(0) 1

run 20 ns

force A_sel(1) 1
force B_sel(1) 1

run 20 ns

force A_sel(2) 1
force B_sel(2) 1

run 20 ns

force A_sel(3) 1
force B_sel(3) 1

run 40 ns