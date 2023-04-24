-- Description:
--
-- Read Load A description to gain sense of processing.
--
-- Load B supplies the correct B values to the PE chain to match the A vector set being processed.
--
-- For decryption, Load B supplies the entire set of B index values after each clock cylce.
--      Ex: B(0..7), B(8..15), B(16..23), B(24..31) ... B((N - PE_SIZE * 2)..(N - 1))
--
-- For encryption, Load B supplies the even B and P index values, then the odd B and P index values, of the entire set 
-- after each clock cylce.  Then, it will supply it the next even and odd B and P index values of the next set.  It
-- supplies B and P simultaneously 
--      Ex: B(0, 2, 4, 6), B(1, 3, 5, 7), B(8, 10, 12, 14), B(9, 11, 13, 15) ...
--      Ex: P(0, 2, 4, 6), P(1, 3, 5, 7), P(8, 10, 12, 14), P(9, 11, 13, 15) ...

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_b is
    port(
        clk         : in    std_logic;
        rst         : in    std_logic;
        load_b_ena  : in    std_logic;
        enc_dec     : in    std_logic;

        B_in        : in    b_matrix;
        P_in        : in    b_matrix;
        B_out       : out   b_hold_matrix;
        P_out       : out   b_hold_matrix
    );
end entity;

architecture rtl of load_b is

    signal b_tmp        :   b_hold_matrix; -- Temporary hold for the B values that will be delivered
    signal p_tmp        :   b_hold_matrix; -- Temporary hold for the P values that will be delivered
    signal b_even        :   b_hold_matrix;
    signal b_odd      :   b_hold_matrix;
    signal p_even        :   b_hold_matrix;
    signal p_odd      :   b_hold_matrix;
    signal b_dec        : b_hold_matrix; -- Contains the entire set of B index values
    signal count      :  std_logic := '0';
    signal count_nxt     :  std_logic := '0';
    signal set_idx        :  integer := 0;
    signal set_idx_hold   :  integer := 0;

    begin

        -- Assigns B and P even and odd index values of a set to respective signal
        LOAD_B_P_ENC : for i in 0 to PE_SIZE-1 generate
            b_even(i) <= B_in(set_idx + i*2);
            b_odd(i) <= B_in(set_idx + i*2 + 1);
            p_even(i) <= P_in(set_idx + i*2);
            p_odd(i) <= P_in(set_idx + i*2 + 1);
        end generate LOAD_B_P_ENC;

        -- Assigns B index values for an entire set to respective signal
        LOAD_B_DEC : for i in 0 to PE_SIZE*2-1 generate
            b_dec(i) <= B_in(set_idx + i);
        end generate LOAD_B_DEC;

        process(load_b_ena, count)
        begin
            count_nxt <= count xor '1';
            -- Increments the set_idx by the SET_SIZE
            set_idx_hold <= set_idx + SET_SIZE;
            if (load_b_ena = '1') then
                if (enc_dec = '0') then
                    if (count = '0') then
                        -- Keeps set_idx the same
                        set_idx_hold <= set_idx;
                    end if;
                end if;
                if (set_idx = N_SIZE - SET_SIZE) then
                    -- Restricts set_idx from incrementing
                    set_idx_hold <= set_idx;
                end if;
            end if;
        end process;

        process(clk)
        begin
            if (rst = '1') then
                b_tmp <= (others => (others => '0'));
                p_tmp <= (others => (others => '0'));
                count <= '0';
                set_idx <= 0;
            else
                if (rising_edge(clk)) then
                    if (load_b_ena = '1') then
                        count <= count_nxt;
                        set_idx <= set_idx_hold;
                        if (enc_dec = '0') then
                            if (count = '0') then
                                -- Delivers even index values
                                b_tmp <= b_even;
                                p_tmp <= p_even;
                            else
                                -- Delivers odd index values
                                b_tmp <= b_odd;
                                p_tmp <= p_odd;
                            end if;
                        else
                            -- Delivers entire set of index values
                            b_tmp <= b_dec;
                        end if;
                    end if;
                end if;
            end if;
        end process;

        B_out <= b_tmp;
        P_out <= p_tmp;
end rtl;