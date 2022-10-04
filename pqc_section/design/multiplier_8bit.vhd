library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity multiplier_8bit is
    port(
        A   : in    std_logic_vector(1 downto 0);
        B   : in    std_logic_vector(7 downto 0);

        C   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of multiplier_8bit is

    signal C_hold   : std_logic_vector(7 downto 0);
    signal C_inv    : std_logic_vector(7 downto 0);

begin

        LOOP_8 : for i in 0 to 7 generate
            C_hold(i) <= A(0) AND B(i);
        end generate LOOP_8;

        C_inv <= NOT(C_hold) + "00000001" when A(1) = '1' else C_hold;


    C <= C_inv;

end rtl;