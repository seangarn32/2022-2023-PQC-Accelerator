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

    signal a0          : a_vector;
    signal a_nxt_set          : a_circ_hold_matrix;
    signal tmp         : a_vector;
    signal a_reg         : a_vector;
    
    signal count        : std_logic := '1';
    
begin

    seq_logic: process(clk, rst)
    begin
      if (rst = '1') then
        --A_out <= zero;
        tmp <= a0;
        a_nxt_set(0) <= a0;
      else
        if (rising_edge(clk)) then
            if (load_a_ena = '1') then
                tmp <= a_nxt_set(2);
                if (count = '1') then
                    count <= '0';
                    if (enc_dec = '0') then
                        a_nxt_set(0) <= a_nxt_set(0);
                        tmp <= a_nxt_set(1);
                    else
                        a_nxt_set(0) <= a_nxt_set(2);
                    end if;
                else
                    count <= '1';
                    a_nxt_set(0) <= a_nxt_set(2);
                end if;
            end if;
        end if;
      end if;
    end process seq_logic;

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

    REG_A :   entity work.reg_nbit_a(rtl)
    port map(
        clk,
        rst,
        load_a_ena,
        tmp,

        a_reg
    );

    --a_nxt_set(0) <= a_reg when (count = '1');
    A_out <= a_reg;

end rtl;