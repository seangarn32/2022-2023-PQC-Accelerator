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

    signal c_index      : std_logic_vector(COUNTER_SIZE_C-1 downto 0);
    signal c_index_nxt  : std_logic_vector(COUNTER_SIZE_C-1 downto 0);
    signal count        : std_logic_vector(COUNTER_SIZE_B-1 downto 0);
    signal count_nxt    : std_logic_vector(COUNTER_SIZE_B-1 downto 0);

    signal reg_ena      : std_logic_vector(NUM_C_SECTIONS-1 downto 0);
    signal shift_ena    : std_logic;

    signal c_sel        : c_matrix;
    signal c_nxt        : c_matrix;

begin

    -- Count to NUM_B_SECTIONS (Number of cycles needed to accumulate pipelined results)
    count_nxt <= count + '1' when count < NUM_B_SECTIONS-1 
            else (others => '0') when c_index < NUM_C_SECTIONS-1
            else count;
    -- After every NUM_B_SECTIONS cycles, shift to next DSO section index
    c_index_nxt <= c_index + '1' when c_index < NUM_C_SECTIONS-1 and count = NUM_B_SECTIONS-1 
            else c_index;

    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                shift_ena <= '0';
                count <= (others => '0');
                c_index <= (others => '0');
            else 
                if(ena = '1') then
                    count <= count_nxt;
                    c_index <= c_index_nxt;
                    if(count = NUM_B_SECTIONS-1 and c_index = NUM_C_SECTIONS-1) then
                        shift_ena <= '1';
                    end if;
                else
                    shift_ena <= '0';
                end if;
            end if;
        end if;
    end process;

    -- Generate register 0 separately because no mux feed from previous register
    reg_ena(0) <= '1' when c_index = 0 or shift_ena = '1' else '0';
    c_sel(0) <= C_in(0);
    SECTION_GEN_0 : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            reg_ena(0),
            c_sel(0),
            c_nxt(0)
        );

    -- Generate the rest of the registers in section 0
    REG_GEN_SECTION_0 : for j in 1 to ROWS-1 generate

        c_sel(j) <= c_nxt(j-1) when shift_ena = '1' else C_in(j);

        REG : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            reg_ena(0),
            c_sel(j),
            c_nxt(j)
        );

    end generate REG_GEN_SECTION_0;

    -- Generate remaining sections and respective registers
    SECTION_GEN : for i in 1 to NUM_C_SECTIONS-1 generate

        reg_ena(i) <= '1' when c_index = i or shift_ena = '1' else '0';

        REG_GEN : for j in 0 to ROWS-1 generate

            c_sel((i*ROWS)+j) <= c_nxt((i*ROWS)+j-1) when shift_ena = '1' else C_in(j);

            REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                reg_ena(i),
                c_sel((i*ROWS)+j),
                c_nxt((i*ROWS)+j)
            );
        
        end generate REG_GEN;
    end generate SECTION_GEN;

    C_out <= c_nxt(N_SIZE-1);

end rtl;