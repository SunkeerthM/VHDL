library ieee;
use ieee.std_logic_1164.all;

entity FSM_1 is 
port 
(  
	tog_en 	: in std_logic;
	CLK,CLR 	: in std_logic;
	Z1	: out std_logic);
end FSM_1;

architecture behave of FSM_1 is
	type state_type is ( st0, st1 );
	signal PS, NS : state_type;
begin
	sync_process : process(CLK, NS, CLR)
	begin
	  if (CLR = '1') then
		PS <= ST0;
	  elsif (rising_edge(CLK)) then
		PS <= NS;
	  end if;
    end process sync_process;

	comb_process : process(PS, tog_en)
	begin
		Z1 <= '0';
		case PS is
		when ST0 => -- items regarding state ST0
			Z1 <= '0'; -- Moore output
			if (TOG_EN = '1') then NS <= ST1;
			else NS <= ST0;
			end if;
		when ST1 => -- items regarding state ST1
			Z1 <= '1'; -- Moore output
			if (TOG_EN = '1') then NS <= ST0;
			else NS <= ST1;
			end if;
		when others => -- the catch-all condition
			Z1 <= '0'; -- arbitrary; it should never
			NS <= ST0; -- make it to these two statements
		end case;
	end process comb_process;
end behave;