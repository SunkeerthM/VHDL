library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity updown_counter is
port(
C, CLR	 : in std_logic;
up_down  : in bit;
Q	 : out std_logic_vector(3 downto 0) := "0000"
);
end updown_counter;

architecture bhv of updown_counter is
signal tmp: std_logic_vector(3 downto 0) :="0000";
begin
process (C, CLR)
begin
if (CLR= '1') then
tmp <= "0000";
elsif (C'event and C= '1') then
  if(up_down = '1') then
    tmp <= tmp + 1;
  else
    tmp <= tmp - 1;
   end if;
end if;
end process;
Q <= tmp;
end bhv;