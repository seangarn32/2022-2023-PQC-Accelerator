library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity processing_element_0 is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        
        A       : in    a_vector;
        a_sel   : in    std_logic_vector(A_INDEX_SIZE-1 downto 0);
        B       : in    std_logic_vector(7 downto 0);

        a_selout: out   std_logic_vector(A_INDEX_SIZE-1 downto 0);
        A_out   : out   a_vector;
        C_out   : out   c_section
    );
end entity;

architecture rtl of processing_element_0 is

    signal a_nxt    : a_vector;
    signal a_col    : a_section_col;
    signal c_mult   : c_section;

begin

    -- Select top ROWS number elements for MULT
    A_COL_GEN : for i in 0 to ROWS-1 generate
        a_col(i) <= A(i);
    end generate A_COL_GEN;

    -- With A(n), determine A(n+1) -> a_nxt
    SHIFT_A :   entity work.signed_shift_dynamic(rtl)
        port map(
            a_sel,
            A,

            a_nxt
        );

    -- Multiply AxB -> c_mult
    MULT :      entity work.multiplier(rtl)
        port map(
            a_col,
            B,

            c_mult
        );

    -- Register A output -> A_nxt
    REG_A_OUT :   entity work.reg_a(rtl)
        port map(
            clk,
            rst,
            ena,

            a_nxt,

            A_out
        );

    -- Pass a_sel to next PE
    REG_A_SEL :   entity work.reg_a_sel(rtl)
        port map(
            clk,
            rst,
            ena,
            
            a_sel,

            a_selout
        );

    -- Register C output -> c_out
    REG_C_OUT :   entity work.reg_c(rtl)
        port map(
            clk,
            rst,
            ena,

            c_mult,

            C_out
        );

end rtl;