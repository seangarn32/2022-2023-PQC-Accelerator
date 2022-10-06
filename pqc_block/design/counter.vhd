library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity counter is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        cnt     : out   std_logic_vector(COUNTER_SIZE-1 downto 0)
    );
end entity;

architecture rtl of counter is

    signal count        : std_logic_vector(COUNTER_SIZE-1 downto 0) := (others => '0');
    signal count_nxt    : std_logic_vector(COUNTER_SIZE-1 downto 0) := (others => '0');

begin

    count_nxt <= count + '1' when count < N_SIZE-1
                 else (others => '0');

    process (clk) 
    begin
        if (rst = '1') then
            count <= (others => '0'); 
        else 
            if (rising_edge(clk) and ena = '1') then
                count <= count_nxt;
            end if;
        end if;
    end process;

    cnt <= count;

end rtl;