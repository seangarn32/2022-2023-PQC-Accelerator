-- Description:
--
-- Load A supplies the first PE in the PE chain the correct input vector. It does so in accordance to set notation,
-- where a set size equals the number of PE's in the PE chain multiplied by 2.  For example, four PE's will have a 
-- set size of 8 (0 through 7).
--
-- For decryption, Load A supplies the first PE the first A vector of each set after each clock cylce.
--      Ex: A0, A8, A16, A24 ... A(N - PE_SIZE * 2)
--
-- For encryption, Load A supplies the first PE the first even A vector, then the first odd A vector, of each set 
-- after each clock cylce.  Then, it will supply it the first even and odd A vector of the next set.
--      Ex: A0, A1, A8, A9, A16, A17, A24, A25, ... A(N - PE_SIZE * 2), A(N - PE_SIZE * 2 + 1)


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        load_a_ena  : in    std_logic;
        enc_dec : in    std_logic;

        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);
        A_out   : out   a_vector
    );
end entity;

architecture rtl of load_a is
    
    signal a0          : a_vector; -- A0 input with appended 0's to bit 1
    -- a_nxt_set holds three A vectors: 
    --  0- First even vector of set
    --  1- First odd vector of set
    --  2- First even vector of next set
    signal a_nxt_set   : a_circ_hold_matrix := (others=>(others=>(others=>'0')));
    signal A_reg_in         : a_vector := (others=>(others=>'0'));
    signal A_set_0         : a_vector := (others=>(others=>'0')); -- Saves a_nxt_set (0)
    signal A_set_0_hold         : a_vector := (others=>(others=>'0'));
    signal A_reg_out        : a_vector;
    
    signal count        : std_logic := '1'; -- Flips between selecting even or odd A vector of a set
    
begin

    seq_logic: process(clk, rst)
    begin
      if (rst = '1') then
        -- a_nxt_set contains A0, A1, and A(PE_SIZE * 2)
        A_set_0 <= a0;
        A_reg_in <= a0;
        count <= '1';
      else
        if (rising_edge(clk)) then
            if (load_a_ena = '1') then
                if (enc_dec = '0') then
                    if (count = '1') then
                        -- Odd vector
                        A_set_0 <= a_nxt_set(0);
                        A_reg_in <= a_nxt_set(1);
                    else
                        -- Even vector of the next set
                        A_set_0 <= a_nxt_set(2);
                        A_reg_in <= a_nxt_set(2);
                    end if;
                else
                    -- Even vector of the next set
                    A_set_0 <= a_nxt_set(2);
                    A_reg_in <= a_nxt_set(2);
                end if;
                count <= count xor '1';
            end if;
        end if;
      end if;
    end process seq_logic;

    -- Sign A_in to create A0
    SIGNED : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SIGNED;

    -- Shifts the first even vector of a set by one
    ENC_DEC_SHIFT_CELL : entity work.signed_shift(rtl)
            port map (
                a_nxt_set(0),
                a_nxt_set(1)
            );

    -- Shifts the first even vector of a set by PE_SIZE * 2
    ENC_DEC_SHIFT_SET_CELL : entity work.signed_set_shift(rtl)
            port map (
                a_nxt_set(0),
                a_nxt_set(2)
            );

    REG_A :   entity work.reg_nbit_a(rtl)
    port map(
        clk,
        rst,
        load_a_ena,
        A_reg_in,

        A_reg_out
    );

    A_set_0_hold <= A_set_0;
    a_nxt_set(0) <= A_set_0;
    A_out <= A_reg_out;

end rtl;