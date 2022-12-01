library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity mux4to1 is
	port( a0,a1,a2,a3		: in std_logic_vector(N_SIZE - 1 downto 0);
	      sel		: in std_logic_vector(1 downto 0);
	      res	: out std_logic_vector(N_SIZE - 1 downto 0)
);
end mux4to1;

architecture rtl of mux4to1 is
begin

	res <= a0 when sel = "00" else 
		 a1 when sel = "01" else 
		 a2 when sel = "10" else 
		 a3 when sel = "11";
end rtl;