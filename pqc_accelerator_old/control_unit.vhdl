LIBRARY ieee;               
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY control_unit is
generic(
	N:integer:=256;
	MAX:integer:=8
);
PORT(	clock		: in STD_LOGIC;
	reset		: in STD_LOGIC;
	load		: in STD_LOGIC;
	clear		: in STD_LOGIC;
	done		: out STD_LOGIC;
	en_A		: out STD_LOGIC;
	en_B		: out STD_LOGIC;
	en_C		: out STD_LOGIC;
	clear_all	: out STD_LOGIC;
	en_reg		: out STD_LOGIC;
	cir_shift	: out STD_LOGIC;
	ctrl_1	    	: out STD_LOGIC;
	ctrl_2	    	: out STD_LOGIC;
	ctrl_mux_1	: out STD_LOGIC_VECTOR(MAX-1 downto 0);
	clear_reg 	: out STD_LOGIC;
	D_valid		: out STD_LOGIC
    );
END ENTITY;

ARCHITECTURE a OF control_unit IS
TYPE state_type IS (state_reset, state_load, state_multi, state_add, state_done);
	SIGNAL state : state_type;
	SIGNAL counter_shift 	: STD_LOGIC_VECTOR(MAX-1 downto 0);
	SIGNAL counter1		: STD_LOGIC_VECTOR(MAX-1 downto 0);
	SIGNAL counter2		: STD_LOGIC_VECTOR(MAX-1 downto 0);
	SIGNAL counter3		: STD_LOGIC_VECTOR(MAX-1 downto 0);
	SIGNAL finish_load	: STD_LOGIC;
	SIGNAL finish_add	: STD_LOGIC;
	SIGNAL clear_D_reg	: STD_LOGIC;
BEGIN
	PROCESS(clock, reset, clear)
	BEGIN
		IF (reset = '1') THEN
			state 		<= state_reset;			-- state
			clear_all	<= '1';				-- clear A, B, C registers
			done		<= '0';				-- HIGH when finished
			en_A 		<= '0';				-- HIGH shift A, B, C
			en_B		<= '0';
			en_C		<= '0';
			en_reg		<= '1';				-- HIGH stores value from adder
			cir_shift	<= '0';				-- HIGH regs will circular shift, LOW will load in from input
			ctrl_1 		<= '0';				-- HIGH turns coef negative
			ctrl_2 		<= '0';				-- LOW selects A coef HIGH selects C
			ctrl_mux_1 	<= (others => '1');		-- A reg mux select starts HIGH
			clear_D_reg 	<= '1';				-- HIGH clears coef register
			counter_shift 	<= (others => '0');		-- keeps track of shifts for LOAD state
			counter1	<= (others => '1');		-- assigns value to ctrl_mux_1 (starts HIGH)
			counter2 	<= (others => '0');		-- used to decrement counter1 (starts at LOW)
			counter3 	<= (others => '0');		-- keeps track of MULTI state cycles (starts LOW)
			finish_load	<= '0';				-- HIGH when load state ends
			finish_add	<= '0';				-- HIGH when add state ends
			D_valid		<= '0';
		ELSIF (clear = '1') THEN
			clear_D_reg 	<= '1';				-- clear coef reg
			ctrl_1 		<= '0';	
			ctrl_2 		<= '0';
			counter1	<= (others => '1');		-- clear counters
			counter2 	<= (others => '0');
			counter3 	<= (others => '0');			
		ELSIF rising_edge(clock) THEN
			CASE state IS
				WHEN state_reset =>
					IF (load = '1') THEN 			-- first go to load state
						state <= state_load;
						en_A <= '1';			-- start shifting in values
						en_B <= '1';
						en_C <= '1';
						clear_all <= '0';		-- stop clearing A, B, C
					END IF;
				WHEN state_load => 
					IF (counter_shift = std_logic_vector(to_unsigned(N-1, MAX))) THEN	-- check if done loading A B C
						finish_load <= '1';
						state <= state_multi;
						clear_D_reg <= '1';
						counter_shift <= (others => '0');
						en_A <= '0';						-- STOP shifting registers
						en_B <= '0';
						en_C <= '0';	
						cir_shift <= '1';					-- turn circular shift on after done loading
					ELSE
						counter_shift <= counter_shift + '1';					
					END IF;
				WHEN state_multi =>				
					IF (clear_D_reg <= '1') THEN
						clear_D_reg <= '0';
					END IF;			 				-- if counter1 has hit 0 then values after should be negative BUT not first cycle
					IF (counter1 = std_logic_vector(to_unsigned(N-1, MAX)) and finish_load = '0' and counter2 > std_logic_vector(to_unsigned(0, MAX))) THEN	
						ctrl_1 <= '1';
					END IF;
					IF (counter3 = std_logic_vector(to_unsigned(N-1, MAX))) THEN	-- check if finished all cycles of MULTI
						counter3 <= (others => '0');	
						counter1 <= (others => '1');			-- reset counters 1 3
						counter2 <= counter2 + '1';			-- incr counter2 so next time counter1 starts at a lower value
						state <= state_add;
					ELSE 
						IF (finish_load = '1') THEN			-- if coming from load state: stop clearing coefficient register
							clear_D_reg <= '0';
							finish_load <= '0';
							counter1 <= counter1 - '1';			-- decr counter1 & incr counter3
							en_B <= '1';
							counter3 <= counter3 + '1';
						ELSIF (finish_add = '1') THEN			-- if coming from add state: stop shifting C reg and select values from A
					
							en_C <= '0';
							ctrl_2 <= '0';
							finish_add <= '0';
							clear_D_reg <= '1';
							D_valid <= '1';
						ELSE
							D_valid <= '0';
							counter1 <= counter1 - '1';			-- decr counter1 & incr counter3
							en_B <= '1';
							counter3 <= counter3 + '1';
						END IF;
					END IF;	
					ctrl_mux_1 <= counter1;				-- assign counter1 to select values from A reg	
				WHEN state_add =>
					en_B <= '0';
					IF (counter2 = std_logic_vector(to_unsigned(0, MAX))) THEN	-- check if all rows of matrix have cycled
						done <= '1';
						state <= state_done;
						ctrl_1 <= '0';
						ctrl_2 <= '1';
					ELSE
						ctrl_1 <= '0';			-- make sure not to set C coef to negative
						state <= state_multi;		-- return to MULTI
						ctrl_2 <= '1';			-- take coef from C now
						en_C <= '1';			-- shift C
						finish_add <= '1';		
						counter1 <= counter1 - counter2; 	-- decr counter1 for next row
					END IF;
				WHEN state_done =>
					done <= '1';		
					D_valid <= '1';	
			END CASE;
		END IF;
		clear_reg <= clear_D_reg;
	END PROCESS;
END a;

