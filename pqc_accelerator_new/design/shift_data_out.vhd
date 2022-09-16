library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_out is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        d_rdy   : in    std_logic;
        d_in    : in    b_matrix;
        
        d_out   : out   std_logic_vector(7 downto 0);
        d_done  : out   std_logic
    );
end entity;

architecture rtl of data_shift_out is

    signal d_sel    : b_matrix;
    signal d_nxt    : b_matrix;
    signal cnt_ena  : std_logic;
    signal cnt      : std_logic_vector(7 downto 0);

begin

    COUNTER : entity work.counter(rtl)
        port map(
            clk,
            rst,
            cnt_ena,

            cnt
        );

    cnt_ena <= '1' when d_rdy = '1' AND cnt < N_SIZE-1 else '0';
    d_done  <= '1' when cnt = N_SIZE-1 else '0';

    REG_GEN : for i in 0 to N_SIZE-2 generate

        d_sel <= d_in when d_rdy = '0' else d_nxt;

        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,
                d_sel(i),
                d_nxt(i+1)
            );
    end generate REG_GEN;

    REG_N : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,
            d_sel(N_SIZE-1),
            d_out
        );

end rtl;