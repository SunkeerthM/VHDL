library IEEE;
library BITLIB;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use BITLIB-use_pack.all;


entity Multiplier_VHDL is
   port
   (
   		clk,st 	: 	in bit;
   		multiplier, multiplicand 	: in bit_vector(3 downto 0);
   		done	: out bit

   );

end entity Multiplier_VHDL;

architecture Behavioral of Multiplier_VHDL is
signal State 		: integer range 0 to 9;
signal accumulator	: in bit_vector(8 downto 0)
alias M 			: bit is accumulator(0);

begin	
	process
	begin
	wait until rising_edge(clk);
	case State is
		when 0 =>
		if(st <= '0') then
			State <=0;
		else
			State <= 1;
			accumulator ( 8 downto 4) <= "00000";	
			accumulator ( 4 downto 0) <=  multiplier;

		when 1 | 3 | 5 | 7 =>

		if(M <= '1') then
			State <= State + 1;
			accumulator ( 8 downto 4 ) <= add4( accumulator ( 7 downto 4 ) , multiplicand, '0' );
		else
			State <= 1;
			accumulator <= '0' & accumulator ( 8 downto 1 );
			State <= State + 2;
		end if;
		
		when 2 | 4 | 6 | 8 =>
			accumulator <= '0' & accumulator ( 8 downto 1 );
			State <= State + 1;
			
		when 9 =>
		State <= 0;
		
	end case;
	end process;
	Done <= '1' when State = 9 else 0 ;
end behave;		
