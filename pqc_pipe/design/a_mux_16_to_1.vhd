library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity counter is
    port(
        A_in     : in    a_mux_input;
        sel      : in    std_logic_vector(3 downto 0);

        A_out    : out   std_logic_vector(N-1 downto 0)
    );
end entity;

architecture rtl of counter is

begin
    process (A_in, clk) begin
        if (rst = '1') then
            count <= "00000000"; 
        else 
            if (clk'event and clk = '1' and ena = '1') then
                count <= count_nxt;
            end if;
        end if;
    end process;

end rtl;