library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity const_error is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;

        W       : in    std_logic_vector(7 downto 0);
        Y       : in    std_logic_vector(7 downto 0);
        
        e1      : in    std_logic;
        e2      : in    std_logic;
        c2      : in    std_logic;

        Ci1      : out   std_logic_vector(7 downto 0);
        Ci2      : out   std_logic_vector(7 downto 0)

        );
end const_error;

architecture rtl of const_error is

    signal sum_c1   : std_logic_vector(7 downto 0);
    signal sum_c2   : std_logic_vector(7 downto 0);
    signal tmp      : std_logic;

begin


    tmp <= e1 when (enc_dec = '0') else c2 when (enc_dec = '1') else '0';

    sum_c1 <= W + tmp;

    sum_c2 <= Y + e2;

    -- W + e1 (8-bit) or Z + c2 (8-bit)
    REG_Ci1 : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,

            sum_c1,
            Ci1
        );

    -- Y + e2 (8-bit)
    REG_Ci2 : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,

            sum_c2,
            Ci2
        );

end rtl;