restart -f

force clk 0 0 ns, 1 10 ns -r 20 ns
force rst 1 0 ns, 0 40 ns
force ena 1 0 ns
force enc_dec 1 0 ns

force c_in_0(0) "00000000" 0 ns
force c_in_0(1) "00000001" 0 ns
force c_in_0(2) "00000010" 0 ns
force c_in_0(3) "00000011" 0 ns
force c_in_0(4) "00000100" 0 ns
force c_in_0(5) "00000101" 0 ns
force c_in_0(6) "00000110" 0 ns
force c_in_0(7) "00000111" 0 ns

force c_in_1(0) "00000000" 0 ns
force c_in_1(1) "00000001" 0 ns
force c_in_1(2) "00000010" 0 ns
force c_in_1(3) "00000011" 0 ns
force c_in_1(4) "00000100" 0 ns
force c_in_1(5) "00000101" 0 ns
force c_in_1(6) "00000110" 0 ns
force c_in_1(7) "00000111" 0 ns

force c_in_2(0) "10000000" 0 ns
force c_in_2(1) "00000001" 0 ns
force c_in_2(2) "00000010" 0 ns
force c_in_2(3) "00000011" 0 ns
force c_in_2(4) "00000100" 0 ns
force c_in_2(5) "00000101" 0 ns
force c_in_2(6) "00000110" 0 ns
force c_in_2(7) "00000111" 0 ns

run 210 ns