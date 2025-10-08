library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; -- we need a conversion to unsigned 

entity TBADD is 
end TBADD; 

architecture TEST of TBADD is

component add 
	generic(
		x: integer := 15
	);
	
	
	Port (	A:	In	std_logic_vector((x-1) downto 0);
		B:	In	std_logic_vector((x-1) downto 0);
		S:	Out	std_logic_vector((x-1) downto 0)
	);
end component; 
  
  signal Ai, Bi: std_logic_vector(14 downto 0); 
  signal Si : std_logic_vector(14 downto 0);

Begin

  ADD1: add 
	generic map(
		x => 15
	)
	port map (
		A => Ai,
      B => Bi,
      S => Si
	);

  STIMULUS1: process
  begin
    Ai <= "000000000000001";
    Bi <= "000000000000001";
    wait for 2 ns;
    Ai <= "001101000000000";
    Bi <= "111101000000000";
	 wait for 2 ns;
    Ai <= "111110000000000";
    Bi <= "111101000000000";
    
  end process STIMULUS1;

end TEST;

