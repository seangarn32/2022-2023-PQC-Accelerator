restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

force A0 "11010011"
force B_in "00000000"

run 30 ns

force B_in "01000111"
run 20 ns

force B_in "01101110"
run 20 ns

force B_in "00001111"
run 20 ns

force B_in "01011110"
run 20 ns

force B_in "00010101"
run 20 ns

force B_in "00100101"
run 20 ns

force B_in "00101001"
run 20 ns

force B_in "00100011"
run 20 ns



run 340 ns

force rst 1
force ena 0

run 60 ns 

