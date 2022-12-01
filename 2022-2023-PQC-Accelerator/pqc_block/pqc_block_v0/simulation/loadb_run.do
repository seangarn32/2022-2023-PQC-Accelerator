restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force dsi_ena 1 0 ns, 0 330 ns
force pe_ena 0 0 ns, 1 330 ns
force B_in "00000000"
run 20 ns

# B(0)
force B_in "00000001"
run 20 ns

# B(1)
force B_in "00000010"
run 20 ns

# B(2)
force B_in "00000011"
run 20 ns

# B(3)
force B_in "00000100"
run 20 ns

# B(4)
force B_in "00000101"
run 20 ns

# B(5)
force B_in "00000110"
run 20 ns

# B(6)
force B_in "00000111"
run 20 ns

# B(7)
force B_in "00001000"
run 20 ns

# B(0)
force B_in "00001001"
run 20 ns

# B(1)
force B_in "00001010"
run 20 ns

# B(2)
force B_in "00001011"
run 20 ns

# B(3)
force B_in "00001100"
run 20 ns

# B(4)
force B_in "00001101"
run 20 ns

# B(5)
force B_in "00001110"
run 20 ns

# B(6)
force B_in "00001111"
run 20 ns

force B_in "00010000"
run 20 ns


run 400 ns