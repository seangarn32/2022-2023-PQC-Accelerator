library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity add_error is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        W       : in    std_logic_vector(7 downto 0);
        Z       : in    std_logic;

        C_out   : out   std_logic_vector(7 downto 0);
        en      : out   std_logic_vector(7 downto 0);
        de      : out   std_logic
    );
end add_error;

architecture rtl of add_error is

    signal sum_z    : std_logic_vector(7 downto 0);
    signal sum_e    : std_logic_vector(7 downto 0);
    signal de_nxt   : std_logic;

begin

    sum_z <= W + Z;
    sum_e <= sum_z + E;
    de_nxt <= sum_e(0) XOR sum_e(1);

    -- W + Z (8-bit)
    REG_COUT : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,

            sum_z,
            C_out
        );

    -- W + Z + E (8-bit)
    REG_EN : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,

            sum_e,
            en
        );

    -- sum_e(0) XOR sum_e(1) (1-bit)
    REG_DE : entity work.reg_1bit(rtl)
        port map(
            clk,
            rst,
            ena,

            de_nxt,
            de
        );

end rtl;