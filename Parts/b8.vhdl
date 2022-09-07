LIBRARY ieee;               
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

entity b8 is
generic (N:INTEGER:=256);
port(
		clk, clr, en, cir_shift: in std_logic;-- cir_shift '0' feed, '1' circular shift
		d: in std_logic_vector(7 downto 0);
		q: out std_logic_vector(8*N-1 downto 0)
      );
end entity;

architecture arch of b8 is
component reg_aclr_en_8bit is
port (clk:  in std_logic;
      clr, en:  in std_logic;
      d: in std_logic_vector(7 downto 0);
      e: out std_logic_vector(7 downto 0)
		);
end component;

signal dt: std_logic_vector(8*n-1 downto 0);
signal din_0: std_logic_vector(7 downto 0);

begin
com0: reg_aclr_en_8bit port map(clk, clr, en, din_0, e=>dt(7 downto 0));
din_0<=dt(8*n-1 downto 8*n-8) when cir_shift='1' else d;

g1:for i in 1 to N-1 generate
 com1: reg_aclr_en_8bit port map(clk, clr, en, dt(8*i-1 downto 8*i-8), e=>dt(8*i+7 downto 8*i));
end generate;

q<=dt;

end arch;