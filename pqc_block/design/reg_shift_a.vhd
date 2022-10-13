library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity reg_shift_a is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);

        A_out   : out   a_vector
    );
end entity;

architecture rtl of reg_shift_a is

    signal a_sel        : std_logic := '0';
    signal a0           : a_vector;
    signal aN           : a_vector;
    signal a_now        : a_vector;
    signal a_wire       : a_array;

    signal count        : std_logic_vector(COUNTER_SIZE_A-1 downto 0);
    signal count_nxt    : std_logic_vector(COUNTER_SIZE_A-1 downto 0);

begin

    -- Sign A_in to create A0
    SIGNED : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SIGNED;

    -- Create shift chain to generate AN
    SHIFT0 : entity work.signed_shift(rtl)
        port map(
            a_now,
            a_wire(0)
        );
    A_SHIFT_GEN : for i in 0 to COLS-2 generate
        SHIFT : entity work.signed_shift(rtl)
            port map(
                a_wire(i),
                a_wire(i+1)
            );
    end generate A_SHIFT_GEN;

    -- Register AN and send to mux
    A_REG : entity work.reg_a(rtl)
        port map(
            clk,
            rst,
            ena,

            a_wire(COLS-1),
            aN
        );

    -- Toggle between A0 and AN
    count_nxt <= count + '1' when count < NUM_B_SECTIONS-1 else (others => '0');
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                a_sel <= '0';
                count <= (others => '0');
            else
                if(ena = '1') then
                    count <= count_nxt;
                    if(count = NUM_B_SECTIONS-1) then
                        a_sel <= '0';
                    else
                        a_sel <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;
    a_now <= a0 when a_sel = '0' else aN;

    A_out <= a_now;

end rtl;