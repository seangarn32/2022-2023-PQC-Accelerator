library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity reg_1bit is
    port (
        clk   : in    std_logic;
        rst   : in    std_logic;  
        ena   : in    std_logic;

        d     : in    std_logic;

        q     : out   std_logic
    );
end entity;

architecture rtl of reg_1bit is 
begin
    process(clk)
	begin
        if (rst = '1') then
            q <= '0';
        else
            if (rising_edge(clk)) then
                if (ena = '1') then
                    q <= d;
                end if; 
            end if;
        end if;
	end process;
end rtl;

