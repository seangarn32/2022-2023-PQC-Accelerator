library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_b is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        dsi_ena : in    std_logic;
        pe_ena  : in    std_logic;

        B_in    : in    std_logic_vector(7 downto 0);
        B_out   : out   b_section
    );
end entity;

architecture rtl of load_b is

    signal b_reg_in     : b_matrix;
    signal b_reg_out    : b_matrix;

    signal reg_ena      : std_logic;
    signal b_out_hold   : b_section;

begin

    -- Create register enable
    reg_ena <= dsi_ena or pe_ena;

    -- Create last register where data is shifted in
    b_reg_in(N_SIZE-1) <= B_in when pe_ena = '0' else b_reg_out(COLS-1);
    B_REG_N_GEN : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            reg_ena,

            b_reg_in(N_SIZE-1),
            b_reg_out(N_SIZE-1)
        );

    -- Create registers for b_section(s) where values will be shifted upward
    B_REG_SHIFT_UP_GEN : for i in 0 to N_SIZE-COLS-1 generate

        b_reg_in(i) <= b_reg_out(i+1) when pe_ena = '0' else b_reg_out(i+COLS);

        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                reg_ena,

                b_reg_in(i),
                b_reg_out(i)
            );
    end generate B_REG_SHIFT_UP_GEN;

    -- Create registers for b_section(s) where values will be shifted down and around
    B_REG_SHIFT_AROUND_GEN : for j in N_SIZE-COLS to N_SIZE-2 generate

        b_reg_in(j) <= b_reg_out(j+1) when pe_ena = '0' else b_reg_out(j-(N_SIZE-COLS));

        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                reg_ena,

                b_reg_in(j),
                b_reg_out(j)
            );
    end generate B_REG_SHIFT_AROUND_GEN;

    -- Arrange correct b_reg_out elements in b_section
    B_OUT_GEN : for i in 0 to COLS-1 generate
        b_out_hold(i) <= b_reg_out(i);
    end generate B_OUT_GEN;
    B_out <= b_out_hold;


end rtl;