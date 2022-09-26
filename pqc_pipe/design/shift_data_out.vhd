library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_out is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        c_in    : in    c_matrix;

        c_out   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of data_shift_out is

    signal c_sel    : c_matrix;
    signal c_nxt    : c_matrix;

begin

    REG_GEN : for i in 0 to N_SIZE-2 generate

        c_sel <= c_in when ena = '0' else c_nxt;

        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                '1',
                c_sel(i),
                c_nxt(i+1)
            );
    end generate REG_GEN;

    REG_N : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            '1',
            c_sel(N_SIZE-1),
            c_out
        );

end rtl;