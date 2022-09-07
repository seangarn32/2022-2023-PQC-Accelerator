LIBRARY ieee;
USE ieee.std_logic_1164.ALL;  
use ieee.numeric_bit.all;

entity reg_aclr_en_8bit is
port (clk:  in std_logic;
      clr, en:  in std_logic;
      d: in std_logic_vector(7 downto 0);
      e: out std_logic_vector(7 downto 0)
		);
end entity;

architecture arch of reg_aclr_en_8bit is 

begin
     process(clk, clr, en)
	  begin
             	if (clr='1') then
                 	e<="00000000";
		else
			
	    			if (clk'event and clk='1' and en='1' ) then             
		  			e<= d;		 
             			end if;
	  end if;
	  end process;
end arch;

