library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        pe_ena  : in    std_logic;

        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);
        A_out   : out   a_vector
    );
end entity;

architecture rtl of load_a is

    signal a0          : a_vector;
    signal tmp         : a_vector;
    signal a1          : a_vector;
    signal s           : a_vector;
    signal nxt         : a_vector;
    signal d           : a_vector;
    signal q           : a_vector;
    
begin

    -- Sign A_in to create A0
    SIGNED : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SIGNED;

    SHIFT_CELL:   entity work.shift_cell(rtl)
        port map (
            a0,

            a1
        );

    ENC_SHIFTER : for i in 0 to PE_SIZE generate
        
    end generate ENC_SHIFTER;

    DEC_SHIFTER : for i in 0 to PE_SIZE*2 generate

    end generate DEC_SHIFTER;



        


    REG_0 :   entity work.reg_nbit_a(rtl)
    port map(
        clk,
        rst,
        ena,
        tmp,

        s
    );

    REG_1 :   entity work.reg_nbit_a(rtl)
    port map(
        clk,
        rst,
        ena,
        s,

        q
    );
    
    
    
    A_out <= tmp;

end rtl;