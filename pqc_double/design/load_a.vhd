library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        pe_ena  : in    std_logic;
        enc_dec : in    std_logic;

        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);
        A_out   : out   a_vector
    );
end entity;

architecture rtl of load_a is

    signal a0          : a_vector;
    signal a_nxt         : a_matrix;
    signal a1          : a_vector;
    signal a2           : a_vector;
    signal tmp         : a_vector;
    signal a_reg         : a_vector;
    signal a_init       : std_logic;
    
    signal count        : std_logic := '0';
    
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                a_init <= '0';
            else 
                if(pe_ena = '1') then
                    a_init <= '1';
                    if (count = '0') then
                        count <= '1';
                    else 
                        count <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;
    

    -- Sign A_in to create A0
    SIGNED : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SIGNED;

    ENC_DEC_SHIFT_CELL : for i in 0 to PE_SIZE*2 - 2 generate
        ENC_SHIFT_CELL_N: entity work.signed_shift(rtl)
            port map (
                a_nxt(i),

                a_nxt(i+1)
            );
    end generate ENC_DEC_SHIFT_CELL;

    tmp <= a0 when (rst = '1' and a_init = '0') else
             a_nxt(1) when (enc_dec = '0' and a_init = '1' and count = '0') else
             a_nxt(PE_SIZE * 2 - 1) when (enc_dec = '0' and a_init = '1' and count = '1') else
             a_nxt(PE_SIZE * 2 - 1) when (enc_dec = '1' and a_init = '1');

    REG_A :   entity work.reg_nbit_a(rtl)
    port map(
        clk,
        rst,
        pe_ena,
        tmp,

        a_reg
    );

    a_nxt(0) <= a_reg;
    A_out <= a_reg;

end rtl;