restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 20 ns
force load_a_ena 0 0 ns, 1 20 ns
force enc_dec 1 0 ns

force A_in "01010111" 0 ns

force load_a_ena 0 100 ns

run 1000 ns
