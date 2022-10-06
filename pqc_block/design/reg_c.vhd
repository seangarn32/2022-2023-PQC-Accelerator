library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity reg_c is
    port (
        d   : in    c_section;

        q   : out   c_section
    );
end entity;

architecture rtl of reg_c is 
begin
    process(clk)
	begin
        if (rst = '1') then
            q <= (others=>(others=>'0'));
		else		
			if (rising_edge(clk) and ena = '1') then             
		  		q <= d;		 
            end if;
	  	end if;
	end process;
end rtl;