library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_in is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        d_in    : in    std_logic_vector(7 downto 0);

        d_out   : out   b_matrix
    );
end entity;

architecture rtl of data_shift_in is

    signal d       : b_matrix;

begin

    REG_0 : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,
            d_in,
            d(0)
        );

    REG_GEN : for i in 1 to N_SIZE-1 generate
        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,
                d(i-1),
                d(i)
            );
    end generate REG_GEN;

    d_out <= d;

end rtl;