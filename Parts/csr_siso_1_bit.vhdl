LIBRARY ieee;               
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

entity csr_siso_1_bit is
generic (N:INTEGER:=256);
port(
		clk, clr, en, cir_shift: in std_logic;-- cir_shift '0' feed, '1' circular shift
		d: in std_logic;
		q: out std_logic
      );
end entity;

architecture arch of csr_siso_1_bit is
component reg_aclr_en_1bit is
port (clk:  in std_logic;
      clr, en:  in std_logic;
      d:    in std_logic;
      e:    out std_logic
		);
end component;

signal dt: std_logic_vector(n-1 downto 0);
signal din_0: std_logic;

begin
com0: reg_aclr_en_1bit port map(clk=>clk, clr=>clr, en=>en, d=>din_0, e=>dt(0));
din_0<=dt(n-1) when cir_shift='1' else d;

g1:for i in 1 to N-1 generate
 com1: reg_aclr_en_1bit port map(clk=>clk, clr=>clr, en=>en, d=>dt(i-1), e=>dt(i));
end generate;

q<=dt(n-1);

end arch;