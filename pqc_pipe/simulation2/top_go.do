restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

# Preset A & B
force a_in 0
force b_in "00000000"
run 60 ns




# Set A0(7)
force a_in 0
# Set B(7) 
force b_in "00000001"
run 20 ns

# Set A0(6)
force a_in 0
# Set B(6) 
force b_in "01111100"
run 20 ns

# Set A0(5)
force a_in 0
# Set B(5) 
force b_in "01101111"
run 20 ns

# Set A0(4)
force a_in 0
# Set B(4) 
force b_in "01011110"
run 20 ns

# Set A0(3)
force a_in 1
# Set B(3) 
force b_in "00100011"
run 20 ns

# Set A0(2)
force a_in 0
# Set B(2) 
force b_in "00000100"
run 20 ns

# Set A0(1)
force a_in 1
# Set B(1) 
force b_in "01001101"
run 20 ns

# Set A0(0)
force a_in 0
# Set B(0) 
force b_in "01101010"
run 20 ns


run 310 ns 

