restart -f
force clk 0 0 ns, 1 10 ns -repeat 20 ns
force rst 1 0 ns, 0 20 ns
force ena 0 0 ns, 1 20 ns
force z_in 0

force a_in 0 19870 ns, 1 19890 ns, 1 19910 ns, 0 19930 ns, 0 19950 ns, 1 19970 ns, 1 19990 ns, 0 20010 ns
force b_in "00000000" 19875 ns, "00000001" 19895 ns, "00000000" 19915 ns, "00000001" 19935 ns, "00000000" 19955 ns, "00000001" 19975 ns, "00000000" 19995 ns, "00000001" 20015 ns
force z_in 0 335 ns, 0 355 ns, 0 375 ns, 0 395 ns, 0 415 ns, 0 435 ns, 0 455 ns, 0 475 ns

run 790ns