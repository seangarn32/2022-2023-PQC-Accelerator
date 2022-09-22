library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity counter is
    port(
        A_in     : in    a_mux_input;
        sel      : in    std_logic_vector(N_SIZE/DIVIDE downto 0);

        A_out    : out   std_logic_vector(N-1 downto 0)
    );
end entity;

architecture rtl of counter is

begin
    with sel select B <=
    A(7 downto 0) when "00000000",
A(15 downto 8) when "00000001",
A(23 downto 16) when "00000010"


end rtl;