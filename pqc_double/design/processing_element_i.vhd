library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity processing_element_i is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;
        
        A0       : in    a_vector;

        B_0       : in    std_logic_vector(7 downto 0);
        B_1       : in    std_logic_vector(7 downto 0);

        C_out_0   : out   c_matrix
        C_out_1   : out   c_matrix

        A2     : out    a_vector;
    );
end entity;

architecture rtl of processing_element_i is

    signal C_mult_0 : c_matrix;
    signal C_mult_1 : c_matrix;
    signal A1     : a_vector;
    signal sc_A0  : a_vector;


begin
    -- Multiply AxB -> C_mult
    MULT_0 :      entity work.multiplier_nbit(rtl)
        port map(
            A0,
            B_0,

            C_mult_0
        );

    -- Register Output -> C_out
    REG_SUM_0 :   entity work.reg_nbit_matrix(rtl)
        port map(
            clk,
            rst,
            ena,
            C_mult_0,

            C_out
        );

    -- Add code to circular shift A0 to A1.  If encryption, don't add sign

    MULT_1 :      entity work.multiplier_nbit(rtl)
        port map(
            A1,
            B_1,

            C_mult_1
        );

    REG_SUM_1 :   entity work.reg_nbit_matrix(rtl)
        port map(
            clk,
            rst,
            ena,
            C_mult_1,

            C_out
        );

    -- Add code to circular shift A0 to A2

end rtl;