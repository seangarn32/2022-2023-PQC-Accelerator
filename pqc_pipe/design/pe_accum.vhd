library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;
 
entity accumulator is
    port(
            clk, reset : in std_logic;
            Din : in std_logic_vector(0 to N_SIZE-1);
            Q : out std_logic_vector(0 to N_SIZE-1)
        );
end accumulator;

architecture rtl of accumulator is

signal tmp: std_logic_vector(0 to N_SIZE-1);
constant C: std_logic_vector(0 to N_SIZE-1):=(others => '0');

begin
    process (clk, reset)
        begin
        if (reset='1') then
            tmp <= C;
        elsif rising_edge(clk) then
            tmp <= tmp + Din;
        end if;
    end process;
    Q <= tmp;
end rtl;