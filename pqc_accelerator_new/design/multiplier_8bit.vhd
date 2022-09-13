library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity multiplier_8bit is
    port(
        A   : in    a_matrix;
        B   : in    std_logic_vector(7 downto 0);
        C   : out   b_matrix
    );
end entity;

architecture rtl of multiplier_8bit is

    signal C_hold   : b_matrix;

begin
    process begin
    
        for i in 0 to N_SIZE-1 loop
            for j in 0 to 7 loop
                C_hold(i)(j) <= (A(i)(0)) AND B(j);
                wait;
            end loop;

            if((A(i)(1)) = '1') then
                C_hold(i) <= NOT(C_hold(i)) + "00000001";
            end if;

        end loop;

        C <= C_hold;

    end process;

end rtl;