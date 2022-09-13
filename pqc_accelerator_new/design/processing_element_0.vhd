library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals.all;

entity processing_element_0 is
    port (  A       : in STD_LOGIC_VECTOR(7 downto 0);
            b       : in STD_LOGIC(7 downto 0);
            CRC_A   : out STD_LOGIC(7 downto 0);
            result : out STD_LOGIC(63 downto 0);
        );
end entity;

architecture rtl of processing_element_i is

    -- multiplier
    component multiplier is 
        port( 	A   : in STD_LOGIC_VECTOR(7 downto 0);
                b   : in STD_LOGIC;
                SUM : out STD_LOGIC_VECTOR(7 downto 0)
            );
    end component;

    -- crc register
    component reg_8bit is
        port(   clk     : in STD_LOGIC;
                clr, en : in STD_LOGIC;
                d       : in STD_LOGIC_VECTOR(7 downto 0);
                q       : out STD_LOGIC_VECTOR(7 downto 0)
            );
    end component;

    -- addition/multiplication lower register, 64 bits?

    -- crc
    component crc is 
        port(   A       : in STD_LOGIC_VECTOR(7 downto 0);
		        CRC_A   : out STD_LOGIC_VECTOR(7 downto 0)
	        );
    end component;

    signal product : STD_LOGIC_VECTOR(7 downto 0);

begin
    com0: crc port map(A=>A(7 downto 0), CRC_A=>CRC_A(7 downto 0));
    com1: reg_8bit port map(clk=>clk, clr=>clr, en=>en, d=>CRC_A, q=>q);
    com2: multiplier port map(A=>A(7 downto 0), b=>b, SUM=>product(7 downto 0));
    --implement com3 for 64 bit register? mapping product to the input of the register?


end architecture;