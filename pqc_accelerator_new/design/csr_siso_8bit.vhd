library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity csr_siso_8bit is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        shft    : in    std_logic;
        d       : in    std_logic_vector(7 downto 0);
        q       : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of csr_siso_8bit is

    signal dt   : std_logic_vector(8*(N_SIZE-1) downto 0);
    signal din  : std_logic_vector(7 downto 0);

begin

    

end rtl;

