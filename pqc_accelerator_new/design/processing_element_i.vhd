library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity processing_element_i is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        
        A       : in    std_logic_vector(N_SIZE-1 downto 0);
        B       : in    std_logic_vector(7 downto 0);

        A_nxt   : out   a_matrix;
        C_out   : out   b_matrix
    );
end entity;

architecture rtl of processing_element_i is

    signal A_sign : a_matrix;
    signal C_mult : b_matrix;

begin

    -- Sign A
    process begin
        for i in 0 to N_SIZE-1 loop
            A_sign(i) <= '0' & A(i);
            wait;
        end loop;
    end process;

    -- Determine A(n+1) -> A_nxt
    OUT_A_NXT : entity work.signed_shift(rtl)
        port map(
            A_sign,
            A_nxt
        );

    -- Multiply AxB -> C_mult
    MULT :      entity work.multiplier_8bit(rtl)
        port map(
            A_sign,
            B,
            C_mult
        );

    -- Register Output -> C_out
    REG_SUM :   entity work.reg_aclr_en_8bit(arch)
        port map(
            clk,
            rst,
            ena,
            C_mult,

            C_out
        );

end rtl;