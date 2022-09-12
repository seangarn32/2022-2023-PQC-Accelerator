LIBRARY ieee;
USE ieee.std_logic_1164.ALL;  

entity reg_aclr_en_1bit is
port (clk:  in std_logic;
      clr, en:  in std_logic;
      d: in std_logic;
      q: out std_logic
);
end entity;

architecture arch of reg_aclr_en_1bit is 
begin
    process(clk, clr, en)
	begin
        if (clr='1') then
            q<='0';
		else
			if (clk'event and clk='1' and en='1') then             
			  	q<= d;		 
 			end if;
	  	end if;
	end process;
end arch;

