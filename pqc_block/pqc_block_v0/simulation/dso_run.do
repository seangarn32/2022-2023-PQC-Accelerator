restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 1

force C_in(0) "10101010"
force C_in(1) "10101010"
run 30 ns

force C_in(0) "00001111"
force C_in(1) "11110000"
run 20 ns

force C_in(0) "10101010"
force C_in(1) "10101010"
run 20 ns

force C_in(0) "00001111"
force C_in(1) "11110000"
run 20 ns

force C_in(0) "10101010"
force C_in(1) "10101010"
run 20 ns

force C_in(0) "00001111"
force C_in(1) "11110000"
run 20 ns

force C_in(0) "10101010"
force C_in(1) "10101010"
run 20 ns

force C_in(0) "00001111"
force C_in(1) "11110000"
run 20 ns

run 200 ns