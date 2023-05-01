library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a_cpy is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        load_a_ena  : in    std_logic;
        enc_dec : in    std_logic;

        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);
        A_out   : out   a_vector
    );
end entity;

architecture rtl of load_a_cpy is

    signal a0          : a_vector;
    signal a_nxt_set   : a_circ_hold_matrix := (others=>(others=>(others=>'0')));
    signal A_reg_in         : a_vector := (others=>(others=>'0'));
    signal A_set_0         : a_vector := (others=>(others=>'0'));
    signal A_set_0_hold         : a_vector := (others=>(others=>'0'));
    signal A_reg_out        : a_vector;
    
    signal count        : std_logic := '1';
    signal count_nxt        : std_logic := '1';
    
begin

    -- Sign A_in to create A0
    SIGNED : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SIGNED;

    ENC_DEC_SHIFT_CELL : entity work.signed_shift(rtl)
            port map (
                a_nxt_set(0),
                a_nxt_set(1)
            );

    ENC_DEC_SHIFT_SET_CELL : entity work.signed_set_shift(rtl)
            port map (
                a_nxt_set(0),
                a_nxt_set(2)
            );

    process(load_a_ena, count)
    begin
        count_nxt <= count xor '1';
        A_set_0 <= (others=>(others=>'0'));
        --set_idx_hold <= set_idx + SET_SIZE;
        if (load_a_ena = '1') then
            if (enc_dec = '0') then
                if (count = '1') then
                    --count <= '0';
                    A_set_0 <= a_nxt_set(0);
                    --A_reg_in <= a_nxt_set(1);
                else
                    --count <= '1';
                    A_set_0 <= a_nxt_set(2);
                    --A_reg_in <= a_nxt_set(2);
                end if;
            else
                --count <= '0';
                A_set_0 <= a_nxt_set(2);
                --A_reg_in <= a_nxt_set(2);
            end if;
        end if;
    end process;

    a_nxt_set(0) <= A_set_0;

    process(clk)
    begin
        if (rst = '1') then
            count <= '1';
            A_reg_in <= a0;
        else
            if (rising_edge(clk)) then
                --if (load_a_ena = '1') then
                    count <= count_nxt;
                    if (enc_dec = '0') then
                        if (count = '1') then
                            A_reg_in <= a_nxt_set(1);
                        else
                            A_reg_in <= a_nxt_set(2);
                        end if;
                    else
                        A_reg_in <= a_nxt_set(2);
                    end if;
                --end if;
            end if;
        end if;
    end process;
    
    A_out <= A_reg_in;

end rtl;