library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; -- we need a conversion to unsigned 

entity TBMUL is 
end TBMUL; 

architecture TEST of TBMUL is

component mul 
	generic(
		x: integer := 15
	);
	Port (	A:	In	std_logic_vector(14 downto 0);
		B:	In	std_logic_vector(14 downto 0);
		M:	Out	std_logic_vector((x-1) downto 0)
	);
end component; 
  
  signal Ai, Bi: std_logic_vector(14 downto 0); 
  signal Mi : std_logic_vector(14 downto 0);

Begin

  MULT: mul 
	generic map (x => 15)
	port map (A => Ai,
                     B => Bi,
                     M => Mi);

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

