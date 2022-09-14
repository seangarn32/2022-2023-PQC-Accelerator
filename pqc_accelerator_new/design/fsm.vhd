library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity fsm is
    port ( 
        reset : in  STD_LOGIC;
        input : in  STD_LOGIC;
        output : out  STD_LOGIC;
        clk : in  STD_LOGIC
    );
end fsm;

architecture Behavioral of fsm is

    type state_available is (PE0,PE1,PE2,PE3,PE4,PE5,PE6,PE7);  --type of state machine.
    signal present_state,next_state: state_available;

begin
    process (clk,reset)
    begin
        if (reset='1') then
            present_state<= A;  --default state on reset.
        elsif (rising_edge(clk)) then
            present_state<= next_state;   --state change.
        end if;
    end process;

    process (present_state,input)
    begin
        case present_state is
            when A =>        --when current state is "A"
                if(input ='0') then
                    output <= '1';
                    next_state<= C;
                else
                    output <= '0';
                    next_state<= B;
                end if;  
            when B =>        --when current state is "B"
                if(input ='0') then
                    output <= '0';
                    next_state<= D;
                else
                    output <= '1';
                    next_state<= B;
                end if;
            when C =>       --when current state is "C"
                if(input ='0') then
                    output <= '1';
                    next_state<= D;
                else
                    output <= '1';
                    next_state<= C;
                end if;
            when D =>         --when current state is "D"
                if(input ='0') then
                    output <= '1';
                    next_state<= A;
                else
                    output <= '0';
                    next_state<= D;
                end if;
        end case;
    end process;
end Behavioral;