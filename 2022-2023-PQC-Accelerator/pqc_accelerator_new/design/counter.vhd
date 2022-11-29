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

    signal count        : std_logic_vector(7 downto 0) := "00000000";
    signal count_nxt    : std_logic_vector(7 downto 0) := "00000000";

begin

    count_nxt <= count + "00000001" when count < N_SIZE-1
                 else "00000000";

    process (clk, rst, ena) begin
        if (rst = '1') then
            count <= "00000000"; 
        else 
            if (clk'event and clk = '1' and ena = '1') then
                count <= count_nxt;
            end if;
        end if;
    end process;

    cnt <= count;

end rtl;