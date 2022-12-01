library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;
 
entity pe_accum is
    port(
            clk     : in    std_logic;
            rst     : in    std_logic;
            ena     : in    std_logic;

            d       : in    c_section;
            q       : out   c_section
        );
end pe_accum;

architecture rtl of pe_accum is

    signal count     : std_logic_vector(COUNTER_SIZE_A-1 downto 0);
    signal count_nxt : std_logic_vector(COUNTER_SIZE_A-1 downto 0);

    signal sum_sel   : std_logic;
    signal sum_zero  : c_section := (others=>(others=>'0'));
    signal sum       : c_section;
    signal sum_with  : c_section;
    signal sum_nxt   : c_section;

begin

    -- Switch sum_sel to select sum_zero at beginning of each row accumulation
    count_nxt <= count + '1' when count < NUM_B_SECTIONS-1 else (others => '0');
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                count <= (others => '0');
                sum_sel <= '0';
            else
                if(ena = '1') then
                    count <= count_nxt;
                    if(count = NUM_B_SECTIONS-1) then
                        sum_sel <= '0';
                    else
                        sum_sel <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;
    sum_with <= sum_zero when sum_sel = '0' else sum;

    -- Accumulate row-wise
    SUM_ROW_GEN : for i in 0 to ROWS-1 generate
        sum_nxt(i) <= sum_with(i) + d(i);
    end generate SUM_ROW_GEN;

    -- Register accumulated rows
    ACCUM_REG : entity work.reg_c(rtl)
        port map(
            clk,
            rst,
            ena,

            sum_nxt,
            sum
        );

    q <= sum;

end rtl;