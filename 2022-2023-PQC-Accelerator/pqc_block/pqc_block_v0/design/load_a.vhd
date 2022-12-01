library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a is
    port(
        clk         : in    std_logic;
        rst         : in    std_logic;
        dsi_ena     : in    std_logic;
        shift_ena   : in    std_logic;

        A_in        : in    std_logic;
        A_out       : out   a_vector
    );
end entity;

architecture rtl of load_a is

    signal a_signed     : std_logic_vector(1 downto 0);

    signal a_reg_in     : a_vector;
    signal a_reg_out    : a_vector;

    signal reg_ena      : std_logic;

begin

    -- Add sign bit to A_in
    a_signed <= '0' & A_in;

    -- Create register enable
    reg_ena <= dsi_ena or shift_ena; -- add logic for timed shifting

    -- Create last register where data is shifted in
    a_reg_in(N_SIZE-1) <= a_signed when shift_ena = '0' else a_reg_out(ROWS-1);
    A_REG_N_GEN : entity work.reg_2bit(rtl)
        port map(
            clk,
            rst,
            reg_ena,

            a_reg_in(N_SIZE-1),
            a_reg_out(N_SIZE-1)
        );

    -- Create registers for b_section(s) where values will be shifted upward
    A_REG_SHIFT_UP_GEN : for i in 0 to N_SIZE-ROWS-1 generate

        a_reg_in(i) <= a_reg_out(i+1) when shift_ena = '0' else a_reg_out(i+ROWS);

        REG : entity work.reg_2bit(rtl)
            port map(
                clk,
                rst,
                reg_ena,

                a_reg_in(i),
                a_reg_out(i)
            );
    end generate A_REG_SHIFT_UP_GEN;

    -- Create registers for b_section(s) where values will be shifted down and around
    A_REG_SHIFT_AROUND_GEN : for j in N_SIZE-ROWS to N_SIZE-2 generate

        a_reg_in(j) <= a_reg_out(j+1) when shift_ena = '0' else a_reg_out(j-(N_SIZE-ROWS));

        REG : entity work.reg_2bit(rtl)
            port map(
                clk,
                rst,
                reg_ena,

                a_reg_in(j),
                a_reg_out(j)
            );
    end generate A_REG_SHIFT_AROUND_GEN;

    A_out <= a_reg_out;

end rtl;