library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity reg_8bit is
    port (
        clk   : in    std_logic;
        clr   : in    std_logic;  
        ena   : in    std_logic;
        d     : in    std_logic_vector(7 downto 0);

        q     : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of reg_8bit is 
begin
    process(clk, clr, ena)
	begin
        if (clr='1') then
            q <= "00000000";
		else		
			if (clk'event and clk='1' and ena='1') then             
		  		q <= d;		 
            end if;
	  	end if;
	end process;
end rtl;

