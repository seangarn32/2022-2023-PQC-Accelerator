restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns

# Preset A & B
force a_in 0
force b_in "00000000"
run 30 ns

# Set A0(15)
force a_in 0
# Set B(15) 
force b_in "00000001"
run 20 ns

# Set A0(14)
force a_in 0
# Set B(14) 
force b_in "01111100"
run 20 ns

# Set A0(13)
force a_in 0
# Set B(13) 
force b_in "01101111"
run 20 ns

# Set A0(12)
force a_in 0
# Set B(12) 
force b_in "01011110"
run 20 ns

# Set A0(11)
force a_in 1
# Set B(11) 
force b_in "00100011"
run 20 ns

# Set A0(10)
force a_in 0
# Set B(10) 
force b_in "00000100"
run 20 ns

# Set A0(9)
force a_in 1
# Set B(9) 
force b_in "01001101"
run 20 ns

# Set A0(8)
force a_in 0
# Set B(8) 
force b_in "01101010"
run 20 ns

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


run 1200 ns 

