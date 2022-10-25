library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_b is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        B_in    : in    b_matrix;
        B_out   : out   b_section
    );
end entity;

architecture rtl of load_b is

    signal shift_ena    : std_logic := '0';
    signal b_arrange    : b_array;
    signal b_hold       : b_array;
    signal b_reg        : b_array;
    signal b_reg_nxt    : b_array;

begin

    -- Arrange B matrix into array of b_section
    B_SECTION_GEN : for i in 0 to NUM_B_SECTIONS-1 generate
        B_ELEMENT_GEN : for j in 0 to COLS-1 generate
            b_arrange(i)(j) <= B_in((i*COLS)+j);
        end generate B_ELEMENT_GEN;
    end generate B_SECTION_GEN;

    -- Determine next shifted b_array based on current b_array
    b_reg_nxt(NUM_B_SECTIONS-1) <= b_reg(0);
    B_NXT_GEN : for i in 0 to NUM_B_SECTIONS-2 generate
        b_reg_nxt(i) <= b_reg(i+1);
    end generate B_NXT_GEN;

    -- Toggle register input after initial b_array is loaded from DSI
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                shift_ena <= '0';
            else
                if(ena = '1') then
                    shift_ena <= '1';
                end if;
            end if;
        end if;
    end process;
    b_hold <= b_arrange when shift_ena = '0' else b_reg_nxt;

    -- Register either initial B values or next shifted B values
    REG_B : entity work.reg_b(rtl)
        port map(
            clk,
            rst,
            ena,

            b_hold,
            b_reg
        );

    B_out <= b_reg(0);


end rtl;