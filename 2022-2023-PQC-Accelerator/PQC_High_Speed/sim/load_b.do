restart -f
force clk 0 0 ns, 1 10 ns -repeat 20 ns
force rst 1 0 ns, 0 20 ns
force load_b_ena 0 0 ns, 1 20 ns
force enc_dec 0 0 ns

force B_in(0) "00000000" 20 ns
force B_in(1) "00000001" 20 ns
force B_in(2) "00000010" 20 ns
force B_in(3) "00000011" 20 ns
force B_in(4) "00000100" 20 ns
force B_in(5) "00000101" 20 ns
force B_in(6) "00000110" 20 ns
force B_in(7) "00000111" 20 ns

force B_in(8) "00001000" 20 ns
force B_in(9) "00010000" 20 ns
force B_in(10) "00011000" 20 ns
force B_in(11) "00100000" 20 ns
force B_in(12) "00101000" 20 ns
force B_in(13) "00110000" 20 ns
force B_in(14) "00111000" 20 ns
force B_in(15) "01000000" 20 ns

force B_in(16) "00000000" 20 ns
force B_in(17) "00000001" 20 ns
force B_in(18) "00000010" 20 ns
force B_in(19) "00000011" 20 ns
force B_in(20) "00000100" 20 ns
force B_in(21) "00000101" 20 ns
force B_in(22) "00000110" 20 ns
force B_in(23) "00000111" 20 ns

force B_in(24) "00001000" 20 ns
force B_in(25) "00010000" 20 ns
force B_in(26) "00011000" 20 ns
force B_in(27) "00100000" 20 ns
force B_in(28) "00101000" 20 ns
force B_in(29) "00110000" 20 ns
force B_in(30) "00111000" 20 ns
force B_in(31) "01000000" 20 ns

force load_b_ena 0 2000 ns

run 2000ns