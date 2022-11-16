library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_out is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        C_in    : in    c_section;
        C_out   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of data_shift_out is

    signal count            : std_logic_vector(COUNTER_SIZE_B-1 downto 0);
    signal count_nxt        : std_logic_vector(COUNTER_SIZE_B-1 downto 0);

    signal shift_ena        : std_logic;
    signal out_ena          : std_logic;

    signal c_reg_in         : c_section;
    signal c_reg_out        : c_section;

begin

    -- Count to NUM_B_SECTIONS-2 (Number of cycles needed to accumulate pipelined results)
    count_nxt <= count + '1' when count < NUM_B_SECTIONS-1 else (others=>'0');

    -- Take in values from accum, then shift
    shift_ena <= '0' when count = NUM_B_SECTIONS-1 else '1'; 

    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                count <= (others=>'0');
            else 
                if(ena = '1') then
                    count <= count_nxt;
                end if;
            end if;
        end if;
    end process;

    -- Generate register 0 separately because no mux feed from previous register
    c_reg_in(ROWS-1) <= C_in(ROWS-1);
    C_REG_N_GEN : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,

            c_reg_in(ROWS-1),
            c_reg_out(ROWS-1)
        );

    -- Generate the rest of the registers in section 0
    C_REG_I_GEN : for i in 0 to ROWS-2 generate

        c_reg_in(i) <= c_reg_out(i+1) when shift_ena = '1' else C_in(i);

        REG : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,

            c_reg_in(i),
            c_reg_out(i)
        );

    end generate C_REG_I_GEN;

    C_out <= c_reg_out(0);

end rtl;