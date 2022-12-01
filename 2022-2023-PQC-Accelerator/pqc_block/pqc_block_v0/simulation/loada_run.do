restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force dsi_ena 1 0 ns, 0 330 ns
force pe_ena 0 0 ns, 1 330 ns
force A_in '0'
run 20 ns

# B(0)
force A_in '0'
run 20 ns

# B(1)
force A_in '0'
run 20 ns

# B(2)
force A_in '0'
run 20 ns

# B(3)
force A_in '0'
run 20 ns

# B(4)
force A_in '0'
run 20 ns

# B(5)
force A_in '0'
run 20 ns

# B(6)
force A_in '0'
run 20 ns

# B(7)
force A_in '0'
run 20 ns

# B(0)
force A_in '1'
run 20 ns

# B(1)
force A_in '1'
run 20 ns

# B(2)
force A_in '1'
run 20 ns

# B(3)
force A_in '1'
run 20 ns

# B(4)
force A_in '1'
run 20 ns

# B(5)
force A_in '1'
run 20 ns

# B(6)
force A_in '1'
run 20 ns

force A_in '1'
run 20 ns


run 400 ns