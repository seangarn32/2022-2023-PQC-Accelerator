-- adapted from http://cas.ee.ic.ac.uk/people/dt10/research/thomas-10-lut_sr_rngs.pdf
-- David B. Thomas and Wayne Luk. FPGA-Optimised Uniform Random Number Generators using LUTs and Shift Registers
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity rng_n1024_r32_t5_k32_s1c48_SR is
  generic(K:integer);
  port(clk:in std_logic; ce:in std_logic; din:in std_logic; dout:out std_logic);
end entity;

-- DO NOT USE THIS COMPONENT
-- ce is chip enable signal.
-- din is 1-bit input.
-- dout is 1-bit random output.

architecture RTL of rng_n1024_r32_t5_k32_s1c48_SR is
  signal bits : std_logic_vector(0 to K);
begin
	bits(0) <= din;
	process(clk) begin
		if(rising_edge(clk) and (ce='1')) then
			bits(1 to K) <= bits(0 to K-1);
		end if;
	end process;
	dout <= bits(K);
end;

library ieee;
use ieee.std_logic_1164.all;

entity rng_n1024_r32_t5_k32_s1c48 is
  port(
    clk:in std_logic;
    ce:in std_logic;
    mode:in std_logic;
    s_in:in std_logic;
    s_out:out std_logic;
    rng:out std_logic_vector(31 downto 0)
  );
end rng_n1024_r32_t5_k32_s1c48;

-- USE THIS COMPONENT
-- ce is chip enable signal.
-- mode is 1 when input data, 0 when output.
-- s_in is 1-bit input.
-- s_out is 1-bit random output.
-- rng is 32-bits random output.

architecture RTL of rng_n1024_r32_t5_k32_s1c48 is
component rng_n1024_r32_t5_k32_s1c48_SR is
  generic(K:integer);
  port(clk:in std_logic; ce:in std_logic; din:in std_logic; dout:out std_logic);
end component;

  signal fifo_out, r_out:std_logic_vector(31 downto 0);
begin
  rng(0) <= r_out(6);
  rng(1) <= r_out(10);
  rng(2) <= r_out(26);
  rng(3) <= r_out(14);
  rng(4) <= r_out(2);
  rng(5) <= r_out(30);
  rng(6) <= r_out(0);
  rng(7) <= r_out(22);
  rng(8) <= r_out(24);
  rng(9) <= r_out(27);
  rng(10) <= r_out(29);
  rng(11) <= r_out(13);
  rng(12) <= r_out(8);
  rng(13) <= r_out(28);
  rng(14) <= r_out(7);
  rng(15) <= r_out(3);
  rng(16) <= r_out(23);
  rng(17) <= r_out(9);
  rng(18) <= r_out(21);
  rng(19) <= r_out(19);
  rng(20) <= r_out(20);
  rng(21) <= r_out(25);
  rng(22) <= r_out(18);
  rng(23) <= r_out(17);
  rng(24) <= r_out(31);
  rng(25) <= r_out(1);
  rng(26) <= r_out(4);
  rng(27) <= r_out(16);
  rng(28) <= r_out(12);
  rng(29) <= r_out(5);
  rng(30) <= r_out(11);
  rng(31) <= r_out(15);
  s_out <= fifo_out(23);
  regs : process(clk) begin
    if(rising_edge(clk) and (ce='1')) then
      r_out(0)<=(mode and fifo_out(0)) or ((not mode) and ('0' xor fifo_out(16) xor fifo_out(0) xor fifo_out(12) xor fifo_out(27)));
      r_out(1)<=(mode and fifo_out(1)) or ((not mode) and ('0' xor fifo_out(16) xor fifo_out(12) xor fifo_out(20) xor fifo_out(24) xor fifo_out(1)));
      r_out(2)<=(mode and fifo_out(2)) or ((not mode) and ('0' xor fifo_out(2) xor fifo_out(15) xor fifo_out(0) xor fifo_out(11) xor fifo_out(1)));
      r_out(3)<=(mode and fifo_out(3)) or ((not mode) and ('0' xor fifo_out(3) xor fifo_out(2) xor fifo_out(4) xor fifo_out(5) xor fifo_out(25)));
      r_out(4)<=(mode and fifo_out(4)) or ((not mode) and ('0' xor fifo_out(7) xor fifo_out(19) xor fifo_out(4) xor fifo_out(23) xor fifo_out(26)));
      r_out(5)<=(mode and fifo_out(5)) or ((not mode) and ('0' xor fifo_out(10) xor fifo_out(3) xor fifo_out(0) xor fifo_out(5) xor fifo_out(6)));
      r_out(6)<=(mode and fifo_out(6)) or ((not mode) and ('0' xor fifo_out(3) xor fifo_out(9) xor fifo_out(11) xor fifo_out(20) xor fifo_out(6)));
      r_out(7)<=(mode and fifo_out(7)) or ((not mode) and ('0' xor fifo_out(7) xor fifo_out(22) xor fifo_out(24) xor fifo_out(28) xor fifo_out(14)));
      r_out(8)<=(mode and fifo_out(8)) or ((not mode) and ('0' xor fifo_out(7) xor fifo_out(16) xor fifo_out(18) xor fifo_out(8)));
      r_out(9)<=(mode and fifo_out(9)) or ((not mode) and ('0' xor fifo_out(9) xor fifo_out(0) xor fifo_out(18) xor fifo_out(23) xor fifo_out(13)));
      r_out(10)<=(mode and fifo_out(10)) or ((not mode) and ('0' xor fifo_out(10) xor fifo_out(9) xor fifo_out(21) xor fifo_out(29) xor fifo_out(28)));
      r_out(11)<=(mode and fifo_out(11)) or ((not mode) and ('0' xor fifo_out(3) xor fifo_out(15) xor fifo_out(11) xor fifo_out(6)));
      r_out(12)<=(mode and fifo_out(12)) or ((not mode) and ('0' xor fifo_out(18) xor fifo_out(12) xor fifo_out(26) xor fifo_out(24) xor fifo_out(6)));
      r_out(13)<=(mode and fifo_out(13)) or ((not mode) and ('0' xor fifo_out(4) xor fifo_out(31) xor fifo_out(8) xor fifo_out(13) xor fifo_out(30)));
      r_out(14)<=(mode and fifo_out(14)) or ((not mode) and ('0' xor fifo_out(15) xor fifo_out(30) xor fifo_out(5) xor fifo_out(14) xor fifo_out(27)));
      r_out(15)<=(mode and fifo_out(15)) or ((not mode) and ('0' xor fifo_out(15) xor fifo_out(4) xor fifo_out(22) xor fifo_out(8) xor fifo_out(26)));
      r_out(16)<=(mode and fifo_out(16)) or ((not mode) and ('0' xor fifo_out(16) xor fifo_out(2) xor fifo_out(9) xor fifo_out(26) xor fifo_out(14)));
      r_out(17)<=(mode and fifo_out(17)) or ((not mode) and ('0' xor fifo_out(17) xor fifo_out(19) xor fifo_out(12) xor fifo_out(31) xor fifo_out(8)));
      r_out(18)<=(mode and fifo_out(18)) or ((not mode) and ('0' xor fifo_out(21) xor fifo_out(18) xor fifo_out(20) xor fifo_out(5) xor fifo_out(14)));
      r_out(19)<=(mode and fifo_out(19)) or ((not mode) and ('0' xor fifo_out(19) xor fifo_out(4) xor fifo_out(25) xor fifo_out(1)));
      r_out(20)<=(mode and fifo_out(20)) or ((not mode) and ('0' xor fifo_out(10) xor fifo_out(17) xor fifo_out(2) xor fifo_out(20) xor fifo_out(1)));
      r_out(21)<=(mode and fifo_out(21)) or ((not mode) and ('0' xor fifo_out(17) xor fifo_out(16) xor fifo_out(21) xor fifo_out(11) xor fifo_out(25)));
      r_out(22)<=(mode and fifo_out(22)) or ((not mode) and ('0' xor fifo_out(17) xor fifo_out(2) xor fifo_out(22) xor fifo_out(8) xor fifo_out(28)));
      r_out(23)<=(mode and s_in) or ((not mode) and ('0' xor fifo_out(0) xor fifo_out(21) xor fifo_out(23) xor fifo_out(29)));
      r_out(24)<=(mode and fifo_out(24)) or ((not mode) and ('0' xor fifo_out(11) xor fifo_out(24) xor fifo_out(13) xor fifo_out(6) xor fifo_out(27)));
      r_out(25)<=(mode and fifo_out(25)) or ((not mode) and ('0' xor fifo_out(7) xor fifo_out(22) xor fifo_out(12) xor fifo_out(30) xor fifo_out(25)));
      r_out(26)<=(mode and fifo_out(26)) or ((not mode) and ('0' xor fifo_out(10) xor fifo_out(21) xor fifo_out(18) xor fifo_out(22) xor fifo_out(26)));
      r_out(27)<=(mode and fifo_out(27)) or ((not mode) and ('0' xor fifo_out(17) xor fifo_out(29) xor fifo_out(13) xor fifo_out(5) xor fifo_out(27)));
      r_out(28)<=(mode and fifo_out(28)) or ((not mode) and ('0' xor fifo_out(10) xor fifo_out(19) xor fifo_out(15) xor fifo_out(28) xor fifo_out(14)));
      r_out(29)<=(mode and fifo_out(29)) or ((not mode) and ('0' xor fifo_out(23) xor fifo_out(31) xor fifo_out(29) xor fifo_out(20) xor fifo_out(30)));
      r_out(30)<=(mode and fifo_out(30)) or ((not mode) and ('0' xor fifo_out(9) xor fifo_out(31) xor fifo_out(30) xor fifo_out(25) xor fifo_out(28)));
      r_out(31)<=(mode and fifo_out(31)) or ((not mode) and ('0' xor fifo_out(31) xor fifo_out(29) xor fifo_out(24) xor fifo_out(13) xor fifo_out(1)));
    end if;
  end process;
 fifo_0 : rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(1), dout=>fifo_out(0));
 fifo_1 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>30)
    port map(clk=>clk, ce=>ce, din=>r_out(2), dout=>fifo_out(1));
 fifo_2 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(3), dout=>fifo_out(2));
 fifo_3 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(4), dout=>fifo_out(3));
 fifo_4 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(5), dout=>fifo_out(4));
 fifo_5 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(6), dout=>fifo_out(5));
 fifo_6 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>31)
    port map(clk=>clk, ce=>ce, din=>r_out(7), dout=>fifo_out(6));
 fifo_7 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(8), dout=>fifo_out(7));
 fifo_8 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>26)
    port map(clk=>clk, ce=>ce, din=>r_out(9), dout=>fifo_out(8));
 fifo_9 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(10), dout=>fifo_out(9));
 fifo_10 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(11), dout=>fifo_out(10));
 fifo_11 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(12), dout=>fifo_out(11));
 fifo_12 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(13), dout=>fifo_out(12));
 fifo_13 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(14), dout=>fifo_out(13));
 fifo_14 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>21)
    port map(clk=>clk, ce=>ce, din=>r_out(15), dout=>fifo_out(14));
 fifo_15 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(16), dout=>fifo_out(15));
 fifo_16 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(17), dout=>fifo_out(16));
 fifo_17 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(18), dout=>fifo_out(17));
 fifo_18 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(19), dout=>fifo_out(18));
 fifo_19 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(20), dout=>fifo_out(19));
 fifo_20 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(21), dout=>fifo_out(20));
 fifo_21 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(22), dout=>fifo_out(21));
 fifo_22 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(23), dout=>fifo_out(22));
 fifo_23 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(24), dout=>fifo_out(23));
 fifo_24 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>29)
    port map(clk=>clk, ce=>ce, din=>r_out(25), dout=>fifo_out(24));
 fifo_25 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>30)
    port map(clk=>clk, ce=>ce, din=>r_out(26), dout=>fifo_out(25));
 fifo_26 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(27), dout=>fifo_out(26));
 fifo_27 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>29)
    port map(clk=>clk, ce=>ce, din=>r_out(28), dout=>fifo_out(27));
 fifo_28 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(29), dout=>fifo_out(28));
 fifo_29 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>28)
    port map(clk=>clk, ce=>ce, din=>r_out(30), dout=>fifo_out(29));
 fifo_30 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(31), dout=>fifo_out(30));
 fifo_31 :  rng_n1024_r32_t5_k32_s1c48_SR generic map (K=>32)
    port map(clk=>clk, ce=>ce, din=>r_out(0), dout=>fifo_out(31));
end RTL;
