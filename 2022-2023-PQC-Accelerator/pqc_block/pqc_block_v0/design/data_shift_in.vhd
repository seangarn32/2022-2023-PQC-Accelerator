library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_in is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        dsi_ena : in    std_logic;
        pe_ena  : in    std_logic;

        a_sel   : in    std_logic_vector(A_INDEX_SIZE-1 downto 0);
        a_in    : in    std_logic;
        b_in    : in    std_logic_vector(7 downto 0);

        a_out   : out   a_vector;
        b_out   : out   b_section
    );
end entity;

architecture rtl of data_shift_in is

    signal count            : std_logic_vector(COUNTER_SIZE_B-1 downto 0);
    signal count_nxt        : std_logic_vector(COUNTER_SIZE_B-1 downto 0);

    signal a0               : a_vector;
    signal aN               : a_vector;
    signal aN_nxt           : a_vector;

    signal shift_ena        : std_logic;
    signal shift_ena_gate   : std_logic;
    
    signal a_now            : a_vector;
    signal a_now_sel        : std_logic;

begin

    shift_ena_gate <= shift_ena and pe_ena;

    -- Shift A values in and rotate
    A_LOAD : entity work.load_a(rtl)
        port map(
            clk,
            rst,
            dsi_ena,
            shift_ena_gate,

            a_in,
            a0
        );

    -- Jump ahead to next A column, Ex) A0 -> A4
    A_SHIFT : entity work.shift_an(rtl)
        port map(
            a_sel,

            a_now,
            aN_nxt
        );

    -- Register next aN
    REG_AN : entity work.reg_a(rtl)
        port map(
            clk,
            rst,
            '1',

            aN_nxt,
            aN
        );

    -- Select between a0 and aN
    a_now <= a0 when a_now_sel = '0' else aN;
    a_out <= a_now;

    -- Toggle between A0 and AN
    count_nxt <= count + '1' when (count < NUM_B_SECTIONS-1 and pe_ena = '1') else (others => '0');
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                a_now_sel <= '0';
                shift_ena <= '1';
                count <= (others => '0');
            else
                if(pe_ena = '1') then
                    count <= count_nxt;
                    if(count = NUM_B_SECTIONS-1) then
                        a_now_sel <= '0';
                        shift_ena <= '1';
                    else
                        a_now_sel <= '1';
                        shift_ena <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

    B_LOAD: entity work.load_b(rtl)
        port map(
            clk,
            rst,
            dsi_ena,
            pe_ena,

            b_in,
            b_out
        );

end rtl;