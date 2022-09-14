library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity counter is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        cnt     : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of counter is

    signal counter  : std_logic_vector(7 downto 0) := "00000000";

begin

    process (clk, rst, ena) begin
        if (rst = '0') then
            counter <= "00000000"; 
        else 
            if (clk'event and clk = '1' and ena = '1') then
                counter <= counter + "00000001";
            end if;
        end if;
    end process;

    cnt <= counter;

end rtl;