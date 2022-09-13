library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity reg_aclr_en_8bit is
    port (
        clk   : in    std_logic;
        clr   : in    std_logic;  
        ena   : in    std_logic;
        d     : in    b_matrix;

        q     : out   b_matrix
    );
end entity;

architecture arch of reg_aclr_en_8bit is 
begin
    process(clk, clr, ena)
	begin
        if (clr='1') then
            for i in 0 to N_SIZE-1 loop
                q(i) <= "00000000";
            end loop;
		else		
			if (clk'event and clk='1' and ena='1') then             
		  		q <= d;		 
            end if;
	  	end if;
	end process;
end arch;

