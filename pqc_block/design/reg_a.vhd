library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity reg_a is
    port (
        clk : in    std_logic;
        ena : in    std_logic;
        rst : in    std_logic;
        
        d   : in    a_vector;

        q   : out   a_vector
    );
end entity;

architecture rtl of reg_a is 
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