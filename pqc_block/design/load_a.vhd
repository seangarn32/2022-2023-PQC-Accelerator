library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        pe_ena  : in    std_logic;

        a_sel   : in    std_logic_vector(A_INDEX_SIZE-1 downto 0);
        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);
        A_out   : out   a_vector
    );
end entity;

architecture rtl of load_a is

    -- Delay by 1 cycle for correct orientation
    signal delay        : std_logic := '0';

    -- Toggle between a0 and aN values for each pipeline cycle
    signal aN_sel       : std_logic := '0';
    signal count        : std_logic_vector(COUNTER_SIZE_B-1 downto 0);
    signal count_nxt    : std_logic_vector(COUNTER_SIZE_B-1 downto 0);

    -- Toggle between original a0 and shifted a0 values for each row
    signal a0_sel       : std_logic := '0'; 
    signal a0_shift_ena : std_logic := '1';

    -- Original a0
    signal a0           : a_vector;
    -- Value from mux of a0 and a0_shift
    signal a0_pass      : a_vector;
    -- Combinatorial next a0 value
    signal a0_shift_nxt : a_vector;
    -- Registered next a0 value passed to mux
    signal a0_shift     : a_vector;

    -- Combinatorial next aN value
    signal aN_nxt       : a_vector;
    -- Registered next aN value passed to mux
    signal aN           : a_vector;

    -- Value being muxed and fed to PE0
    signal a_now        : a_vector;

begin

    -- Sign A_in to create A0
    SIGNED : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SIGNED;

    -- Shift a0 for next a_section_col
    SHIFT_A0 : entity work.shift_a0(rtl)
        port map(
            a0_pass,
            a0_shift_nxt
        );

    -- Register shifted a0 and send to mux
    REG_A0 : entity work.reg_a(rtl)
        port map(
            clk,
            rst,
            a0_shift_ena,

            a0_shift_nxt,
            a0_shift
        );

    -- Shift aN
    SHIFT_AN : entity work.shift_an(rtl)
        port map(
            a_sel,
            a_now,
            
            aN_nxt
        );

    -- Register AN and send to mux
    REG_AN : entity work.reg_a(rtl)
        port map(
            clk,
            rst,
            '1',

            aN_nxt,
            aN
        );

    -- Toggle between A0 and AN
    count_nxt <= count + '1' when count < NUM_B_SECTIONS-1 else (others => '0');
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                aN_sel <= '0';
                a0_sel <= '0';
                delay <= '0';
                count <= (others => '0');
            else
                if(delay = '1') then
                    if(pe_ena = '1') then
                        count <= count_nxt;
                        a0_sel <= '1';
                        if(count = NUM_B_SECTIONS-1) then
                            aN_sel <= '0';
                            a0_shift_ena <= '1';
                        else
                            aN_sel <= '1';
                            a0_shift_ena <= '0';
                        end if;
                    end if;
                else
                    delay <= '1';
                end if;
            end if;
        end if;
    end process;

    a0_pass <= a0 when a0_sel = '0' else a0_shift;
    a_now <= a0_pass when aN_sel = '0' else aN;
    A_out <= a_now; 

end rtl;